/**
 * @file engine.cpp
 * @brief Simplx engine class
 * @copyright 2013-2018 Tredzone (www.tredzone.com). All rights reserved.
 * Please see accompanying LICENSE file for licensing terms.
 */

#include "trz/engine/internal/node.h"

extern "C"
{
    int TREDZONE_SDK_ARCHITECTURE = tredzone::Engine::SDK_ARCHITECTURE;
    int TREDZONE_SDK_COMPATIBILITY_VERSION = tredzone::Engine::SDK_COMPATIBILITY_VERSION;
    int TREDZONE_SDK_PATCH_VERSION = tredzone::Engine::SDK_PATCH_VERSION;
    int TREDZONE_SDK_COMPILER_ID = TREDZONE_COMPILER_ID;
}

bool TREDZONE_SDK_IS_DEBUG_RELEASE_COMPATIBLE(bool isNDEBUG)
{
#ifndef NDEBUG
    // debug
    if (isNDEBUG)
    {
        return false;
    }
#else
    // release
    if (!isNDEBUG)
    {
        return false;
    }
#endif
    return true;
}

bool TREDZONE_SDK_IS_COMPILER_COMPATIBLE(int compilerId, const void *compilerVersion)
{
    if (compilerId == TREDZONE_SDK_COMPILER_ID)
    {
        const TREDZONE_SDK_COMPILER_VERSION_type &gccVersion =
            *static_cast<const TREDZONE_SDK_COMPILER_VERSION_type *>(compilerVersion);
#if defined(__GNUG__)
        return gccVersion.vmajor == __GNUC__ && gccVersion.vminor == __GNUC_MINOR__;
#else
    #error No supported C++ compiler
#endif
    }
    return false;
}

namespace tredzone
{

ThreadLocalStorage<Engine *> Engine::currentEngineTLS;

AsyncEngineCustomEventLoopFactory::EventLoopAutoPointer AsyncEngineCustomEventLoopFactory::newEventLoop()
{
    return EventLoopAutoPointer::newEventLoop<DefaultEventLoop>();
}

AsyncEngineEventLoop::AsyncEngineEventLoop() noexcept : asyncNode(0),
                                                        interruptFlag(0),
                                                        isBeingDestroyedFlag(false)
#ifndef NDEBUG
                                                            ,
                                                        debugPreRunCalledFlag(false),
                                                        debugSynchronizeCount(0)
#endif
{
}

AsyncEngineEventLoop::~AsyncEngineEventLoop() noexcept
{
#ifndef NDEBUG
    if (debugPreRunCalledFlag)
    {
        assert(asyncNode != 0);
        assert(!isRunning());
        assert(asyncNode->nodeHandle.stopFlag || asyncNode->nodeHandle.shutdownFlag);
        assert(asyncNode->asyncActorChain.empty());
        assert(asyncNode->destroyedAsyncActorChain.empty());
    }
#endif
}

Engine &AsyncEngineEventLoop::getEngine() noexcept { return Engine::getEngine(); }

const Engine &AsyncEngineEventLoop::getEngine() const noexcept { return Engine::getEngine(); }

void AsyncEngineEventLoop::init(AsyncNode &pasyncNode) noexcept
{
    assert(isBeingDestroyedFlag == false);
    assert(!debugPreRunCalledFlag);
    assert(asyncNode == 0);
    asyncNode = &pasyncNode;
    assert(interruptFlag == 0);
    interruptFlag = &asyncNode->nodeHandle.interruptFlag;
}

void AsyncEngineEventLoop::preRun() noexcept
{
#ifndef NDEBUG
    assert(!debugPreRunCalledFlag);
    debugPreRunCalledFlag = true;
    ++debugSynchronizeCount;
#endif
    asyncNode->synchronizePreBarrier();
}

void AsyncEngineEventLoop::postRun() noexcept
{
#ifndef NDEBUG
    ++debugSynchronizeCount;
#endif
    assert(debugPreRunCalledFlag);
    asyncNode->synchronizePostBarrier();
}

void AsyncEngineEventLoop::runWhileNotInterrupted() noexcept
{
#ifndef NDEBUG
    ++debugSynchronizeCount;
#endif
    assert(asyncNode != 0);
    assert(interruptFlag != 0);
    assert(debugPreRunCalledFlag);
    asyncNode->synchronizePostBarrier();
    do
    {
        asyncNode->synchronize();
    } while (!*interruptFlag);
    asyncNode->synchronizePreBarrier();
}

#ifndef NDEBUG
bool AsyncEngineEventLoop::debugIsInNodeThread() const noexcept
{
    assert(asyncNode != 0);
    return asyncNode->debugGetThreadId() == ThreadId::current();
}
#endif

Actor::NodeId AsyncEngineEventLoop::getNodeId() const noexcept
{
    assert(asyncNode != 0);
    return asyncNode->id;
}

Actor::CoreId AsyncEngineEventLoop::getCoreId() const noexcept
{
    assert(asyncNode != 0);
    return asyncNode->getCoreSet().at(asyncNode->id);
}

AsyncExceptionHandler &AsyncEngineEventLoop::getAsyncExceptionHandler() const noexcept
{
    assert(asyncNode != 0);
    return asyncNode->nodeManager.exceptionHandler;
}

void AsyncEngineEventLoop::returnToSender(const Actor::Event &event) noexcept
{
#ifndef NDEBUG
    bool debugFoundFlag = false;
#endif
    assert(asyncNode != 0);
    assert(asyncNode->debugSynchronizePostBarrierFlag);
    assert(event.getDestinationActorId().isInProcess());
    assert((event.isRouted() && event.isRouteToSource()) || event.getSourceActorId().isInProcess());
    Actor::NodeId sourceNodeId =
        event.isRouted() ? event.getRouteId().getNodeId() : event.getSourceInProcessActorId().getNodeId();
    if (sourceNodeId == asyncNode->id)
    {
        AsyncNodesHandle::WriterSharedHandle &writerSharedHandle =
            asyncNode->nodeHandle.getWriterSharedHandle(sourceNodeId);
        assert(debugFoundFlag == false);
#ifndef NDEBUG
        debugFoundFlag = true;
#endif
        writerSharedHandle.onUndeliveredEvent(event);
    }
    else
    {
        AsyncNodesHandle::ReaderSharedHandle &readerSharedHandler =
            asyncNode->nodeHandle.getReaderSharedHandle(sourceNodeId);
        assert(debugFoundFlag == false);
#ifndef NDEBUG
        debugFoundFlag =
#endif
            readerSharedHandler.returnToSender(event);
    }
    assert(debugFoundFlag == true);
}

bool AsyncEngineEventLoop::isRunning() noexcept
{
    assert(asyncNode != 0);
    assert(debugPreRunCalledFlag);
    assert(asyncNode->nodeHandle.interruptFlag);
    asyncNode->nodeHandle.interruptFlag = false;

    memoryBarrier();

    if (isBeingDestroyedFlag)
    {
        asyncNode->nodeHandle.interruptFlag = true;
        assert(asyncNode->nodeHandle.stopFlag || asyncNode->nodeHandle.shutdownFlag);
        return !asyncNode->asyncActorChain.empty() || !asyncNode->destroyedAsyncActorChain.empty();
    }
    else if (asyncNode->nodeHandle.stopFlag || asyncNode->nodeHandle.shutdownFlag)
    {
        asyncNode->nodeHandle.interruptFlag = true;
        isBeingDestroyedFlag = true;
        asyncNode->destroyAsyncActors();
    }
    return true;
}

void AsyncEngineEventLoop::synchronize() noexcept
{
#ifndef NDEBUG
    ++debugSynchronizeCount;
#endif
    assert(asyncNode != 0);
    assert(debugPreRunCalledFlag);
    asyncNode->synchronizePostBarrier();
    asyncNode->synchronizePreBarrier();
}

void AsyncEngineCustomEventLoopFactory::DefaultEventLoop::run() noexcept
{
    assert(asyncNode != 0);
    assert(interruptFlag != 0);
    assert(debugPreRunCalledFlag);
    asyncNode->synchronizePostBarrier();
    while (isRunning())
    {
        do
        {
            asyncNode->synchronize();
        } while (!*interruptFlag);
    }
    asyncNode->synchronizePreBarrier();
}

//---- CORE ACTOR --------------------------------------------------------------

class Engine::CoreActor : public Actor
{
  public:
    struct Init
    {
        Engine &asyncEngine;
        const CoreId coreId;
        const bool isRedZoneFlag;
        inline Init(Engine &pasyncEngine, CoreId pcoreId, bool pisRedZoneFlag) noexcept
            : asyncEngine(pasyncEngine),
              coreId(pcoreId),
              isRedZoneFlag(pisRedZoneFlag)
        {
        }
    };
    
    // ctor, can throw throw (std::bad_alloc)
    CoreActor(const Init &init)
        : stopFlag(asyncNode->nodeHandle.stopFlag), m_ShutdownFlag(asyncNode->nodeHandle.shutdownFlag),
          regularActorsCoreCount(*init.asyncEngine.regularActorsCoreCount), regularActorsCoreCountFlag(false),
          serviceSingletonActor(newReferencedSingletonActor<ServiceSingletonActor>()),
          customCoreActor(init.asyncEngine.customCoreActorFactory.newCustomCoreActor(init.asyncEngine, init.coreId,
                                                                                     init.isRedZoneFlag, *this)),
          nodeActorCountListener(*this), loopForRegularActorsCoreCountZeroCallback(*this)
    {
        asyncNode->subscribeNodeActorCountListener(nodeActorCountListener);
        assert(serviceSingletonActor->isServiceDestroyTimeFlag);
        serviceSingletonActor->isServiceDestroyTimeFlag = false;
        atomicAddAndFetch(&regularActorsCoreCount, 1);
    }
    virtual ~CoreActor() noexcept { nodeActorCountListener.unsubscribe(); }

  private:
  
    struct LoopForRegularActorsCoreCountZeroCallback : Callback
    {
        CoreActor &coreActor;

        inline LoopForRegularActorsCoreCountZeroCallback(CoreActor &pcoreActor) noexcept : coreActor(pcoreActor) {}
        
        inline void onCallback() noexcept
        {
            // [LOIC] coreActor.regularActorsCoreCount
            
            if (coreActor.regularActorsCoreCount == 0)
            {
                coreActor.serviceSingletonActor->destroyServiceActors();
            }
            else
            {
                coreActor.registerCallback(*this);
            }
        }
    };
    
    class NodeActorCountListener: public AsyncNodeBase::NodeActorCountListener
    {
    public:
        CoreActor &coreActor;
        NodeActorCountListener(CoreActor &pcoreActor) noexcept : coreActor(pcoreActor) {}
        
        void onNodeActorCountChange(size_t oldCount, size_t newCount) noexcept override
        {
            // [LOIC] oldCount, newCount
            if (oldCount > newCount)
            {   coreActor.onNodeActorsDestroyed();
            }
        }
    };

    bool &stopFlag;
    const bool &m_ShutdownFlag;                                                     // ref affects unit tests! [PL]
    unsigned &regularActorsCoreCount;
    bool regularActorsCoreCountFlag;
    ActorReference<ServiceSingletonActor> serviceSingletonActor;
    ActorReference<Actor> customCoreActor;
    NodeActorCountListener nodeActorCountListener;
    LoopForRegularActorsCoreCountZeroCallback loopForRegularActorsCoreCountZeroCallback;

    static const Actor::ActorReferenceBase *findFirstActorReference(const Actor &referencingActor,
                                                                         const Actor &referencedActor) noexcept
    {
        if (&referencingActor == &referencedActor)
        {
            return 0;
        }
        const Actor::ActorReferenceBase *ret = 0;
        for (Actor::ReferenceToChain::const_iterator i = referencingActor.m_ReferenceToChain.begin(),
                                                          endi = referencingActor.m_ReferenceToChain.end();
             ret == 0 && i != endi; ++i)
        {
            const Actor &actor = *i->getReferencedActor();
            if (&actor == &referencedActor)
            {
                ret = &*i;
            }
            else
            {
                ret = findFirstActorReference(actor, referencedActor);
            }
        }
        return ret;
    }
    const Actor::ActorReferenceBase *
    findFirstActorReferenceWithinCoreAndServiceReferencedActors(const Actor &referencedActor) const noexcept
    {
        assert(referencedActor.referenceFromCount > 1);
        const Actor::ActorReferenceBase *ret =
            (this->referenceFromCount == 0 ? findFirstActorReference(*this, referencedActor) : 0);
        for (ServiceSingletonActor::ServiceActorList::const_iterator
                 i = serviceSingletonActor->getServiceActorList().begin(),
                 endi = serviceSingletonActor->getServiceActorList().end();
             ret == 0 && i != endi; ++i)
        {
            ret = ((*i)->referenceFromCount == 0 ? findFirstActorReference(**i, referencedActor) : 0);
        }
        assert(ret != 0);
        return ret;
    }
    size_t countReferencedActors(const Actor &referencingActor) const noexcept
    {
        size_t ret = 0;
        for (Actor::ReferenceToChain::const_iterator i = referencingActor.m_ReferenceToChain.begin(),
                                                          endi = referencingActor.m_ReferenceToChain.end();
             i != endi; ++i)
        {
            const Actor &actor = *i->getReferencedActor();
            assert(actor.referenceFromCount >= 1);
            if (actor.referenceFromCount == 1 ||
                findFirstActorReferenceWithinCoreAndServiceReferencedActors(actor) == &*i)
            {
                ret += 1 + countReferencedActors(actor);
            }
        }
        
        // [LOIC] ret
        
        return ret;
    }
    
    bool onlyCoreAndServiceReferencedActorsLeft() const noexcept
    {
        size_t count = (this->referenceFromCount == 0 ? 1 + countReferencedActors(*this) : 0);
        for (ServiceSingletonActor::ServiceActorList::const_iterator
                 i = serviceSingletonActor->getServiceActorList().begin(),
                 endi = serviceSingletonActor->getServiceActorList().end();
             i != endi; ++i)
        {
            count += ((*i)->referenceFromCount == 0 ? 1 + countReferencedActors(**i) : 0);
        }
        return count == asyncNode->getActorCount();
    }
    
    virtual void onDestroyRequest() noexcept
    {
        if (onlyCoreAndServiceReferencedActorsLeft())
        {
            if (serviceSingletonActor->getServiceActorList().empty())
            {
                stopFlag = true;
                if (!regularActorsCoreCountFlag)
                {
                    regularActorsCoreCountFlag = true;
                    atomicSubAndFetch(&regularActorsCoreCount, 1);
                }
                Actor::onDestroyRequest();
            }
            else if (m_ShutdownFlag && !regularActorsCoreCountFlag)
            {
                regularActorsCoreCountFlag = true;
                atomicSubAndFetch(&regularActorsCoreCount, 1);
                registerCallback(loopForRegularActorsCoreCountZeroCallback);
            }
        }
    }
    void onNodeActorsDestroyed() noexcept
    {
        if (onlyCoreAndServiceReferencedActorsLeft() &&
            (serviceSingletonActor->getServiceActorList().empty() ||
             (m_ShutdownFlag && !serviceSingletonActor->isServiceDestroyTimeFlag)))
        {
            requestDestroy();
        }
    }
};

Mutex Engine::ServiceIndex::mutex;
unsigned Engine::ServiceIndex::staticIndexValue = 0;

Engine::Engine(const StartSequence &startSequence)
    : engineName(startSequence.getEngineName()), engineSuffix(startSequence.getEngineSuffix()),
      threadStackSizeByte(startSequence.getThreadStackSizeByte()), redZoneParam(startSequence.getRedZoneParam()),
      regularActorsCoreCount(1u), defaultCoreActorFactory(new AsyncEngineCustomCoreActorFactory),
      defaultEventLoopFactory(new AsyncEngineCustomEventLoopFactory),
      nodeManager(startSequence.getAsyncExceptionHandler() == 0
                      ? new AsyncNodeManager(startSequence.getEventAllocatorPageSizeByte(), startSequence.getCoreSet())
                      : new AsyncNodeManager(*startSequence.getAsyncExceptionHandler(),
                                             startSequence.getEventAllocatorPageSizeByte(),
                                             startSequence.getCoreSet())),
      customCoreActorFactory(
          startSequence.getAsyncEngineCustomCoreActorFactory() == 0
              ? *defaultCoreActorFactory
              : (defaultCoreActorFactory.reset(), *startSequence.getAsyncEngineCustomCoreActorFactory())),
      customEventLoopFactory(
          startSequence.getAsyncEngineCustomEventLoopFactory() == 0
              ? *defaultEventLoopFactory
              : (defaultEventLoopFactory.reset(), *startSequence.getAsyncEngineCustomEventLoopFactory()))
{
    try
    {
        *cacheLineHeaderPadding = *cacheLineTrailerPadding = '\0'; // to silence unused private field warning
        currentEngineTLS.set(this);
        start(startSequence);
        currentEngineTLS.set(0);
    }
    catch (const std::exception &e)
    {
#ifndef NDEBUG
        std::cerr << "DEBUG (" << __FILE__ << ":" << __LINE__ << "): " << e.what() << std::endl;
#endif
        currentEngineTLS.set(0);
        finish();
        throw;
    }
    catch (...)
    {
#ifndef NDEBUG
        std::cerr << "DEBUG (" << __FILE__ << ":" << __LINE__ << "): ?" << std::endl;
#endif
        currentEngineTLS.set(0);
        finish();
        throw;
    }
}

Engine::~Engine() noexcept { finish(); }

std::string Engine::getVersion()
{
    std::stringstream ss;
    ss << "Tredzone C++ Simplx framework" << (int)TREDZONE_ENGINE_VERSION_MAJOR << "." << (int)TREDZONE_ENGINE_VERSION_MINOR;
    if (TREDZONE_ENGINE_VERSION_PATCH != 0)
    {
        ss << '.' << (int)TREDZONE_ENGINE_VERSION_PATCH;
    }
    ss << " (";
    if (strcmp("master", TREDZONE_ENGINE_VERSION_BRANCH) == 0)
    {
        ss << TREDZONE_ENGINE_VERSION_BRANCH;
    }
    else
    {
        ss << "dev-" << TREDZONE_ENGINE_VERSION_BRANCH;
    }
    ss << ") "
#ifndef NDEBUG
       << "debug "
#else
       << "release "
#endif
#ifdef TREDZONE_PLATFORM_LINUX
       << "linux "
#elif defined(TREDZONE_PLATFORM_APPLE)
       << "apple "
#elif defined(TREDZONE_PLATFORM_WINDOWS)
       << "windows "
#endif
#if TREDZONE_COMPILER_ID == 1
       << "gcc" << (int)__GNUC__ << '.' << (int)__GNUC_MINOR__
#else
       << "COMPILER=" << (int)TREDZONE_COMPILER_ID
#endif
       << ' ';
    if (SDK_ARCHITECTURE == 1)
    {
        ss << "x86";
    }
    else
    {
        ss << "ARCHITECTURE=" << (int)SDK_ARCHITECTURE;
    }
    ss << ' ' << sizeof(void *) * 8 << "-bit" << std::ends;
    return ss.str();
}

void Engine::finish() noexcept
{
    nodeManager->shutdown();
    atomicSubAndFetch(&*regularActorsCoreCount, 1);
    nodeManager.reset();
}

const Engine::CoreSet &Engine::getCoreSet() const noexcept { return nodeManager->getCoreSet(); }

size_t Engine::getEventAllocatorPageSizeByte() const noexcept { return nodeManager->getEventAllocatorPageSize(); }

#ifndef NDEBUG
void Engine::debugActivateMemoryLeakBacktrace() noexcept
{
    AsyncNodeAllocator::debugActivateMemoryLeakBacktraceFlag = true;
}
#endif

struct AsyncEngine_start_NodeThread
{ // has to be declared out of Engine::start() to be used as a template parameter of
  // Engine::start::NodeThreadList (GCC compliance)
    const Actor::CoreId coreId;
    std::unique_ptr<AsyncNode::Thread> thread;
    CacheLineAlignedObject<AsyncNode> *node;
    AsyncEngine_start_NodeThread(const AsyncEngine_start_NodeThread &other) : coreId(other.coreId), node(0) {}
    AsyncEngine_start_NodeThread(Actor::CoreId pcoreId) : coreId(pcoreId), node(0) {}
    ~AsyncEngine_start_NodeThread()
    {
        if (node != 0)
        {
            assert(thread.get() != 0);
            thread->run(*node);
        }
    }
};

void Engine::start(const StartSequence &startSequence)
{
    struct NodeThreadList : std::list<AsyncEngine_start_NodeThread>
    {
        iterator find(CoreId coreId) noexcept
        {
            iterator ret = begin();
            for (; ret != end() && ret->coreId != coreId; ++ret)
            {
            }
            return ret;
        }
    };

    NodeThreadList nodeThreadList;
    StartSequence::StarterChain::const_iterator ilastService = startSequence.starterChain.end();
    for (StartSequence::StarterChain::const_iterator i = startSequence.starterChain.begin(),
                                                     endi = startSequence.starterChain.end();
         i != endi; ++i)
    {
        CoreId coreId = i->coreId;
        NodeThreadList::iterator inodeThread = nodeThreadList.find(coreId);
        if (inodeThread == nodeThreadList.end())
        {
            nodeThreadList.push_back(coreId);
            nodeThreadList.back().thread.reset(new AsyncNode::Thread(coreId, startSequence.isRedZoneCore(coreId),
                                                                     redZoneParam, threadStackSizeByte, threadStartHook,
                                                                     this, 0));
            cpuset_type savedThreadAffinity = threadGetAffinity();
            try
            {
                threadSetAffinity(coreId);
                nodeThreadList.back().node = new CacheLineAlignedObject<AsyncNode>(
                    AsyncNode::Init(*nodeManager.get(), coreId, customEventLoopFactory));
            }
            catch (...)
            {
                threadSetAffinity(savedThreadAffinity);
                throw;
            }
            threadSetAffinity(savedThreadAffinity);
        }
        if (i->isServiceFlag)
        {
            ilastService = i;
        }
    }
    Actor::ActorId previousServiceDestroyActorId;
    for (StartSequence::StarterChain::const_iterator i = startSequence.starterChain.begin(),
                                                     endi = startSequence.starterChain.end();
         i != endi; ++i)
    {
        CoreId coreId = i->coreId;
        NodeThreadList::iterator inodeThread = nodeThreadList.find(coreId);
        assert(inodeThread != nodeThreadList.end());
        assert(inodeThread->coreId == coreId);
        assert(inodeThread->node != 0);
        cpuset_type savedThreadAffinity = threadGetAffinity();
        try
        {
            threadSetAffinity(coreId);
            Actor::ActorId serviceDestroyActorId =
                i->onStart(*this, **inodeThread->node, previousServiceDestroyActorId, i == ilastService);
            if (i->isServiceFlag)
            {
                assert(serviceDestroyActorId != tredzone::null);
                previousServiceDestroyActorId = serviceDestroyActorId;
            }
        }
        catch (...)
        {
            threadSetAffinity(savedThreadAffinity);
            throw;
        }
        threadSetAffinity(savedThreadAffinity);
    }
    for (NodeThreadList::iterator i = nodeThreadList.begin(), endi = nodeThreadList.end(); i != endi; ++i)
    {
        assert(i->node != 0);
        cpuset_type savedThreadAffinity = threadGetAffinity();
        try
        {
            threadSetAffinity(i->coreId);
            (*i->node)->newAsyncActor<CoreActor>(
                CoreActor::Init(*this, i->coreId, startSequence.isRedZoneCore(i->coreId)));
        }
        catch (...)
        {
            threadSetAffinity(savedThreadAffinity);
            throw;
        }
        threadSetAffinity(savedThreadAffinity);
    }
}

void Engine::threadStartHook(void *engine)
{
    assert(Engine::currentEngineTLS.get() == 0);
    Engine::currentEngineTLS.set(static_cast<Engine *>(engine));
}

Actor::ActorId Engine::newCore(CoreId coreId, bool isRedZone, NewCoreStarter &newCoreStarter)
{
    AsyncNode::Thread thread(coreId, isRedZone, redZoneParam, threadStackSizeByte, threadStartHook, this, 0);
    Actor::ActorId ret;
    CacheLineAlignedObject<AsyncNode> *node = 0;
    cpuset_type savedThreadAffinity = threadGetAffinity();
    try
    {
        threadSetAffinity(coreId);
        node =
            new CacheLineAlignedObject<AsyncNode>(AsyncNode::Init(*nodeManager.get(), coreId, customEventLoopFactory));
        (*node)->newAsyncActor<CoreActor>(CoreActor::Init(*this, coreId, isRedZone));
        ret = newCoreStarter.start(**node);
    }
    catch (...)
    {
        threadSetAffinity(savedThreadAffinity);
        if (node != 0)
        {
            (*node)->stop();
            thread.run(*node);
        }
        throw;
    }
    threadSetAffinity(savedThreadAffinity);
    assert(node != 0);
    thread.run(*node);
    return ret;
}

Engine::CoreSet::CoreSet() noexcept : coreCount(0) {}

void Engine::CoreSet::set(CoreId coreId)
{
    size_t i = 0;
    for (; i < coreCount && cores[i] != coreId; ++i)
    {
    }
    if (i == coreCount)
    {
        if (coreCount == (size_t)Actor::MAX_NODE_COUNT)
        {
            throw TooManyCoresException();
        }
        ++coreCount;
        cores[i] = coreId;
    }
}

Engine::CoreSet::NodeId Engine::CoreSet::index(CoreId coreId) const
{
    size_t i = 0;
    for (; i < coreCount && cores[i] != coreId; ++i)
    {
    }
    if (i == coreCount)
    {
        throw UndefinedCoreException();
    }
    return (NodeId)i;
}

Engine::CoreId Engine::CoreSet::at(NodeId nodeId) const
{
    if (nodeId >= coreCount)
    {
        throw UndefinedCoreException();
    }
    return cores[nodeId];
}

Engine::FullCoreSet::FullCoreSet()
{
    size_t n = cpuGetCount();
    if (n > (size_t)Actor::MAX_NODE_COUNT)
    {
        throw TooManyCoresException();
    }
    for (size_t i = 0; i < n; ++i)
    {
        set((CoreId)i);
    }
}

/**
 * throw (std::bad_alloc)
 */
Engine::StartSequence::StartSequence(const CoreSet &pcoreSet, int)
    : coreSet(pcoreSet), asyncNodeAllocator(new AsyncNodeAllocator), asyncExceptionHandler(0),
      asyncEngineCustomCoreActorFactory(0), asyncEngineCustomEventLoopFactory(0),
      eventAllocatorPageSizeByte(DEFAULT_EVENT_ALLOCATOR_PAGE_SIZE), threadStackSizeByte(0)
{
    std::stringstream s;
    s << (uint64_t)getPID() << '-' << getTSC() << std::ends;
    engineSuffix = s.str();
}

Engine::StartSequence::~StartSequence() noexcept
{
    while (!starterChain.empty())
    {
        delete starterChain.pop_front();
    }
}

Actor::AllocatorBase Engine::StartSequence::getAllocator() const noexcept
{
    return Actor::AllocatorBase(*asyncNodeAllocator);
}

void Engine::StartSequence::setRedZoneParam(const ThreadRealTimeParam &predZoneParam) noexcept
{
    redZoneParam = predZoneParam;
}

const ThreadRealTimeParam &Engine::StartSequence::getRedZoneParam() const noexcept { return redZoneParam; }

/**
 * throw (std::bad_alloc)
 */
void Engine::StartSequence::setRedZoneCore(CoreId coreId)
{
    if (!isRedZoneCore(coreId))
    {
        redZoneCoreIdList.push_back(coreId);
    }
}

void Engine::StartSequence::setBlueZoneCore(CoreId coreId) noexcept { redZoneCoreIdList.remove(coreId); }

bool Engine::StartSequence::isRedZoneCore(CoreId coreId) const noexcept
{
    RedZoneCoreIdList::const_iterator i = redZoneCoreIdList.begin(), endi = redZoneCoreIdList.end();
    for (; i != endi && *i != coreId; ++i)
    {
    }
    return i != endi;
}

void Engine::StartSequence::setAsyncExceptionHandler(AsyncExceptionHandler &pasyncExceptionHandler) noexcept
{
    asyncExceptionHandler = &pasyncExceptionHandler;
}

void Engine::StartSequence::setAsyncEngineCustomCoreActorFactory(
    AsyncEngineCustomCoreActorFactory &pasyncEngineCustomCoreActorFactory) noexcept
{
    asyncEngineCustomCoreActorFactory = &pasyncEngineCustomCoreActorFactory;
}

void Engine::StartSequence::setAsyncEngineCustomEventLoopFactory(
    AsyncEngineCustomEventLoopFactory &pasyncEngineCustomEventLoopFactory) noexcept
{
    asyncEngineCustomEventLoopFactory = &pasyncEngineCustomEventLoopFactory;
}

void Engine::StartSequence::setEventAllocatorPageSizeByte(size_t peventAllocatorPageSizeByte) noexcept
{
    eventAllocatorPageSizeByte = peventAllocatorPageSizeByte;
}

void Engine::StartSequence::setThreadStackSizeByte(size_t pthreadStackSizeByte) noexcept
{
    threadStackSizeByte = pthreadStackSizeByte;
}

AsyncExceptionHandler *Engine::StartSequence::getAsyncExceptionHandler() const noexcept
{
    return asyncExceptionHandler;
}

AsyncEngineCustomCoreActorFactory *Engine::StartSequence::getAsyncEngineCustomCoreActorFactory() const noexcept
{
    return asyncEngineCustomCoreActorFactory;
}

AsyncEngineCustomEventLoopFactory *Engine::StartSequence::getAsyncEngineCustomEventLoopFactory() const noexcept
{
    return asyncEngineCustomEventLoopFactory;
}

size_t Engine::StartSequence::getEventAllocatorPageSizeByte() const noexcept { return eventAllocatorPageSizeByte; }

size_t Engine::StartSequence::getThreadStackSizeByte() const noexcept { return threadStackSizeByte; }

/**
 * throw (CoreSet::TooManyCoresException)
 */
Engine::CoreSet Engine::StartSequence::getCoreSet() const
{
    CoreSet ret = coreSet;
    for (StarterChain::const_iterator i = starterChain.begin(), endi = starterChain.end(); i != endi; ++i)
    {
        ret.set(i->coreId);
    }
    return ret;
}

void Engine::StartSequence::setEngineName(const char *pengineName) { engineName = pengineName; }

const char *Engine::StartSequence::getEngineName() const noexcept { return engineName.c_str(); }

void Engine::StartSequence::setEngineSuffix(const char *pengineSuffix) { engineSuffix = pengineSuffix; }

const char *Engine::StartSequence::getEngineSuffix() const noexcept { return engineSuffix.c_str(); }
}