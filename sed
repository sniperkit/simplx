Python version: 3.7
usage: build.py [-h]
                [--toolchain {default,cxx11,android-ndk-r10e-api-8-armeabi-v7a,android-ndk-r10e-api-16-armeabi-v7a-neon,android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35,android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid,android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid-sections,android-ndk-r10e-api-16-x86,android-ndk-r10e-api-16-x86-hid,android-ndk-r10e-api-16-x86-hid-sections,android-ndk-r10e-api-19-armeabi-v7a-neon,android-ndk-r10e-api-19-armeabi-v7a-neon-c11,android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections,android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections-lto,android-ndk-r10e-api-19-armeabi-v7a-neon-clang-libcxx,android-ndk-r10e-api-21-armeabi-v7a,android-ndk-r10e-api-21-armeabi-v7a-neon,android-ndk-r10e-api-21-armeabi-v7a-neon-hid-sections,android-ndk-r10e-api-21-armeabi-v7a-neon-clang-35,android-ndk-r10e-api-21-armeabi-v7a-neon-clang-libcxx,android-ndk-r10e-api-21-armeabi-clang-libcxx,android-ndk-r10e-api-21-armeabi,android-ndk-r10e-api-21-arm64-v8a,android-ndk-r10e-api-21-arm64-v8a-gcc-49,android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid,android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid-sections,android-ndk-r10e-api-21-arm64-v8a-clang-35,android-ndk-r10e-api-21-x86,android-ndk-r10e-api-21-x86-clang-libcxx,android-ndk-r10e-api-21-x86-64,android-ndk-r10e-api-21-x86-64-hid,android-ndk-r10e-api-21-x86-64-hid-sections,android-ndk-r10e-api-21-mips,android-ndk-r10e-api-21-mips64,android-ndk-r10e-api-21-mips-clang-libcxx,android-ndk-r11c-api-8-armeabi-v7a,android-ndk-r11c-api-16-armeabi,android-ndk-r11c-api-16-armeabi-cxx14,android-ndk-r11c-api-16-armeabi-v7a,android-ndk-r11c-api-16-armeabi-v7a-cxx14,android-ndk-r11c-api-16-armeabi-v7a-neon,android-ndk-r11c-api-16-armeabi-v7a-neon-cxx14,android-ndk-r11c-api-16-armeabi-v7a-neon-clang-35,android-ndk-r11c-api-16-armeabi-v7a-neon-clang-35-hid,android-ndk-r11c-api-16-x86,android-ndk-r11c-api-16-x86-hid,android-ndk-r11c-api-19-armeabi-v7a-neon,android-ndk-r11c-api-21-armeabi-v7a,android-ndk-r11c-api-21-armeabi-v7a-neon,android-ndk-r11c-api-21-armeabi-v7a-neon-clang-35,android-ndk-r11c-api-21-armeabi,android-ndk-r11c-api-21-arm64-v8a,android-ndk-r11c-api-21-arm64-v8a-gcc-49,android-ndk-r11c-api-21-arm64-v8a-gcc-49-hid,android-ndk-r11c-api-21-arm64-v8a-clang-35,android-ndk-r11c-api-21-x86,android-ndk-r11c-api-21-x86-64,android-ndk-r11c-api-21-x86-64-hid,android-ndk-r11c-api-21-mips,android-ndk-r11c-api-21-mips64,android-ndk-r12b-api-19-armeabi-v7a-neon,android-ndk-r13b-api-19-armeabi-v7a-neon,android-ndk-r14-api-16-armeabi-v7a-neon-clang-hid-sections-lto,android-ndk-r14-api-19-armeabi-v7a-neon-c11,android-ndk-r14-api-19-armeabi-v7a-neon-clang,android-ndk-r14-api-19-armeabi-v7a-neon-clang-libcxx,android-ndk-r14-api-21-arm64-v8a-neon-clang-libcxx,android-ndk-r14-api-19-armeabi-v7a-neon-hid-sections-lto,android-ndk-r14-api-21-arm64-v8a-clang-hid-sections-lto,android-ndk-r14-api-21-x86-64,android-ndk-r14b-api-21-armeabi-clang-libcxx,android-ndk-r14b-api-21-armeabi-v7a-neon-clang-libcxx,android-ndk-r14b-api-21-mips-clang-libcxx,android-ndk-r14b-api-21-x86-clang-libcxx,android-ndk-r15c-api-16-armeabi-v7a-neon-clang-libcxx,android-ndk-r15c-api-16-armeabi-v7a-clang-libcxx,android-ndk-r15c-api-16-armeabi-clang-libcxx,android-ndk-r15c-api-16-mips-clang-libcxx,android-ndk-r15c-api-16-x86-clang-libcxx,android-ndk-r15c-api-21-arm64-v8a-neon-clang-libcxx,android-ndk-r15c-api-21-arm64-v8a-clang-libcxx,android-ndk-r15c-api-21-armeabi-v7a-neon-clang-libcxx,android-ndk-r15c-api-21-armeabi-clang-libcxx,android-ndk-r15c-api-21-mips-clang-libcxx,android-ndk-r15c-api-21-x86-clang-libcxx,android-ndk-r15c-api-21-x86-64-clang-libcxx,android-ndk-r15c-api-24-armeabi-v7a-neon-clang-libcxx,android-ndk-r16b-api-16-armeabi-v7a-clang-libcxx14,android-ndk-r16b-api-16-armeabi-v7a-thumb-clang-libcxx14,android-ndk-r16b-api-16-x86-clang-libcxx14,android-ndk-r16b-api-19-gcc-49-armeabi-v7a-neon-libcxx-hid-sections-lto,android-ndk-r16b-api-21-armeabi-clang-libcxx,android-ndk-r16b-api-21-armeabi-clang-libcxx14,android-ndk-r16b-api-21-armeabi-v7a-clang-libcxx,android-ndk-r16b-api-21-armeabi-v7a-clang-libcxx14,android-ndk-r16b-api-21-arm64-v8a-neon-clang-libcxx,android-ndk-r16b-api-21-arm64-v8a-neon-clang-libcxx14,android-ndk-r16b-api-21-armeabi-v7a-neon-clang-libcxx,android-ndk-r16b-api-21-armeabi-v7a-neon-clang-libcxx14,android-ndk-r16b-api-21-x86-clang-libcxx,android-ndk-r16b-api-21-x86-64-clang-libcxx,android-ndk-r16b-api-24-arm64-v8a-clang-libcxx14,android-ndk-r16b-api-24-armeabi-v7a-neon-clang-libcxx,android-ndk-r16b-api-24-armeabi-v7a-neon-clang-libcxx14,android-ndk-r17-api-24-arm64-v8a-clang-libcxx14,android-ndk-r17-api-21-arm64-v8a-neon-clang-libcxx14,android-ndk-r17-api-16-armeabi-v7a-clang-libcxx14,android-ndk-r17-api-16-x86-clang-libcxx14,android-ndk-r17-api-21-x86-64-clang-libcxx14,android-ndk-r17-api-19-armeabi-v7a-neon-hid-sections,android-ndk-r17-api-19-armeabi-v7a-neon-clang-libcxx,emscripten-cxx11,raspberrypi1-cxx11-pic,raspberrypi1-cxx11-pic-static-std,raspberrypi2-cxx11,raspberrypi2-cxx11-pic,raspberrypi3-gcc-pic-hid-sections,raspberrypi3-cxx11,ios,ios-11-4-dep-9-3-arm64,ios-11-4-dep-9-3-arm64-armv7,ios-11-4-dep-9-4-arm64,ios-11-3-dep-9-0-arm64,ios-11-4-dep-9-0-device-bitcode-cxx11,ios-11-3-dep-9-0-device-bitcode-cxx11,ios-11-2-dep-9-0-device-bitcode-cxx11,ios-11-2-dep-9-3-arm64-armv7,ios-11-3-dep-9-3-arm64-armv7,ios-11-1-dep-9-0-bitcode-cxx11,ios-11-1-dep-9-0-device-bitcode-cxx11,ios-11-0-dep-9-0-bitcode-cxx11,ios-11-0-dep-9-0-device-bitcode-cxx11,ios-11-0,ios-10-3,ios-10-3-dep-8-0-bitcode,ios-10-3-dep-9-0-bitcode,ios-10-3-dep-9-3-i386-armv7,ios-10-3-dep-9-3-x86-64-arm64,ios-10-3-lto,ios-10-3-armv7,ios-10-3-arm64,ios-10-2,ios-10-2-dep-9-3-armv7,ios-10-2-dep-9-3-arm64,ios-10-1,ios-10-1-arm64,ios-10-1-arm64-dep-8-0-hid-sections,ios-10-1-armv7,ios-10-1-dep-8-0-hid-sections,ios-10-1-dep-8-0-libcxx-hid-sections,ios-10-1-dep-8-0-libcxx-hid-sections-lto,ios-10-1-wo-armv7s,ios-10-0,ios-10-0-arm64,ios-10-0-arm64-dep-8-0-hid-sections,ios-10-0-armv7,ios-10-0-dep-8-0-hid-sections,ios-10-0-wo-armv7s,ios-9-3,ios-9-3-arm64,ios-9-3-armv7,ios-9-3-wo-armv7s,ios-9-2,ios-9-2-arm64,ios-9-2-armv7,ios-9-2-hid,ios-9-2-hid-sections,ios-9-1-armv7,ios-9-1-arm64,ios-9-1-dep-7-0-armv7,ios-9-1-hid,ios-9-1-dep-8-0-hid,ios-9-1,ios-9-0,ios-9-0-armv7,ios-9-0-i386-armv7,ios-9-0-wo-armv7s,ios-9-0-dep-7-0-armv7,ios-8-4,ios-8-4-arm64,ios-8-4-armv7,ios-8-4-armv7s,ios-8-4-hid,ios-8-2,ios-8-2-i386-arm64,ios-8-2-arm64,ios-8-2-arm64-hid,ios-8-2-cxx98,ios-8-1,ios-8-0,ios-7-1,ios-7-0,ios-nocodesign,ios-nocodesign-arm64,ios-nocodesign-armv7,ios-nocodesign-hid-sections,ios-nocodesign-wo-armv7s,ios-nocodesign-8-4,ios-nocodesign-8-1,ios-nocodesign-9-1,ios-nocodesign-9-1-arm64,ios-nocodesign-9-1-armv7,ios-nocodesign-9-2,ios-nocodesign-9-2-arm64,ios-nocodesign-9-2-armv7,ios-nocodesign-9-3,ios-nocodesign-9-3-device,ios-nocodesign-9-3-device-hid-sections,ios-nocodesign-9-3-arm64,ios-nocodesign-9-3-armv7,ios-nocodesign-9-3-wo-armv7s,ios-nocodesign-10-0,ios-nocodesign-10-0-arm64,ios-nocodesign-10-0-armv7,ios-nocodesign-10-0-wo-armv7s,ios-nocodesign-10-1,ios-nocodesign-10-1-arm64,ios-nocodesign-10-1-armv7,ios-nocodesign-10-1-wo-armv7s,ios-nocodesign-10-1-arm64-dep-9-0-device-libcxx-hid-sections-lto,ios-nocodesign-10-1-arm64-dep-9-0-device-libcxx-hid-sections,ios-nocodesign-10-1-dep-8-0-libcxx-hid-sections-lto,ios-nocodesign-10-1-dep-8-0-device-libcxx-hid-sections-lto,ios-nocodesign-10-1-dep-9-0-device-libcxx-hid-sections-lto,ios-nocodesign-10-2,ios-nocodesign-10-3,ios-nocodesign-10-3-cxx14,ios-nocodesign-10-3-arm64-dep-9-0-device-libcxx-hid-sections,ios-nocodesign-10-3-dep-9-0-bitcode,ios-nocodesign-10-3-wo-armv7s,ios-nocodesign-10-3-arm64,ios-nocodesign-10-3-armv7,ios-nocodesign-11-0,ios-nocodesign-11-0-dep-9-0-bitcode-cxx11,ios-nocodesign-11-0-arm64-dep-9-0-device-libcxx-hid-sections,ios-nocodesign-11-1,ios-nocodesign-11-1-dep-9-0-wo-armv7s-bitcode-cxx11,ios-nocodesign-11-1-dep-9-0-bitcode-cxx11,ios-nocodesign-11-2-dep-8-0-wo-armv7s-bitcode-cxx11,ios-nocodesign-11-2-dep-9-0-bitcode-cxx11,ios-nocodesign-11-2-dep-9-3,ios-nocodesign-11-2-dep-9-3-armv7,ios-nocodesign-11-2-dep-9-3-arm64,ios-nocodesign-11-2-dep-9-3-arm64-armv7,ios-nocodesign-11-2-dep-9-3-i386-armv7,ios-nocodesign-11-2,ios-nocodesign-11-3-dep-9-3,ios-nocodesign-11-3-dep-9-3-armv7,ios-nocodesign-11-3-dep-9-3-arm64,ios-nocodesign-11-3-dep-9-0-bitcode-cxx11,ios-nocodesign-11-4-dep-9-0-bitcode-cxx11,ios-nocodesign-dep-9-0-cxx14,xcode,xcode-cxx98,xcode-nocxx,xcode-gcc,xcode-hid-sections,xcode-sections,osx-10-7,osx-10-8,osx-10-9,osx-10-10,osx-10-11,osx-10-11-hid-sections,osx-10-11-hid-sections-lto,osx-10-11-lto,osx-10-12,osx-10-12-hid-sections,osx-10-12-lto,osx-10-12-cxx98,osx-10-10-dep-10-7,osx-10-12-dep-10-10,osx-10-12-dep-10-10-lto,osx-10-10-dep-10-9-make,osx-10-11-make,osx-10-12-make,osx-10-12-ninja,osx-10-11-sanitize-address,osx-10-12-sanitize-address,osx-10-12-sanitize-address-hid-sections,osx-10-13,osx-10-13-dep-10-10,osx-10-13-make-cxx14,osx-10-13-cxx14,osx-10-13-i386-cxx14,linux-gcc-x64,analyze,analyze-cxx17,clang-5,clang-5-cxx14,clang-5-cxx17,clang-cxx17,clang-cxx14,clang-cxx14-pic,clang-lto,clang-libstdcxx,clang-omp,clang-fpic,clang-fpic-hid-sections,clang-fpic-static-std,gcc,gcc-static,gcc-static-std,gcc-musl,gcc-32bit,gcc-32bit-pic,gcc-hid,gcc-hid-fpic,gcc-gold,gcc-pic,gcc-c11,gcc-cxx14-c11,gcc-cxx17-c11,gcc-4-8,gcc-4-8-c11,gcc-4-8-pic,gcc-4-8-pic-hid-sections,gcc-pic-hid-sections,gcc-pic-hid-sections-lto,gcc-5-pic-hid-sections-lto,gcc-5-pic-hid-sections,gcc-5,gcc-5-cxx14-c11,gcc-6-32bit-cxx14,gcc-7,gcc-7-cxx14,gcc-7-cxx14-pic,gcc-7-cxx17,gcc-7-pic-hid-sections-lto,gcc-cxx98,gcc-lto,libcxx,libcxx14,libcxx-no-sdk,libcxx-hid,libcxx-hid-fpic,libcxx-fpic-hid-sections,libcxx-hid-sections,sanitize-address,sanitize-address-cxx17,arm-openwrt-linux-muslgnueabi,openbsd-egcc-cxx11-static-std}]
                [--config CONFIG] [--keep-going] [--config-all CONFIG_ALL]
                [--home HOME] [--output OUTPUT] [--cache CACHE] [--test]
                [--test-xml TEST_XML]
                [--pack [{7Z,IFW,NSIS,NSIS64,STGZ,TBZ2,TGZ,TXZ,TZ,ZIP,Bundle,DragNDrop,OSXX11,PackageMaker}]]
                [--archive ARCHIVE] [--nobuild] [--open]
                [--verbosity-level {silent,normal,full} | --verbose]
                [--install] [--ios-multiarch] [--ios-combined] [--framework]
                [--framework-device] [--framework-lib FRAMEWORK_LIB] [--strip]
                [--identity IDENTITY] [--plist PLIST] [--clear] [--reconfig]
                [--fwd [FWD [FWD ...]]] [--iossim] [--jobs JOBS]
                [--target TARGET] [--discard DISCARD] [--tail TAIL]
                [--timeout TIMEOUT] [--cmake CMAKE] [--cpack CPACK]
                [--ctest CTEST]

Script for building. Available toolchains:

  default
  cxx11
  android-ndk-r10e-api-8-armeabi-v7a
  android-ndk-r10e-api-16-armeabi-v7a-neon
  android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35
  android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid
  android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid-sections
  android-ndk-r10e-api-16-x86
  android-ndk-r10e-api-16-x86-hid
  android-ndk-r10e-api-16-x86-hid-sections
  android-ndk-r10e-api-19-armeabi-v7a-neon
  android-ndk-r10e-api-19-armeabi-v7a-neon-c11
  android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections
  android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections-lto
  android-ndk-r10e-api-19-armeabi-v7a-neon-clang-libcxx
  android-ndk-r10e-api-21-armeabi-v7a
  android-ndk-r10e-api-21-armeabi-v7a-neon
  android-ndk-r10e-api-21-armeabi-v7a-neon-hid-sections
  android-ndk-r10e-api-21-armeabi-v7a-neon-clang-35
  android-ndk-r10e-api-21-armeabi-v7a-neon-clang-libcxx
  android-ndk-r10e-api-21-armeabi-clang-libcxx
  android-ndk-r10e-api-21-armeabi
  android-ndk-r10e-api-21-arm64-v8a
  android-ndk-r10e-api-21-arm64-v8a-gcc-49
  android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid
  android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid-sections
  android-ndk-r10e-api-21-arm64-v8a-clang-35
  android-ndk-r10e-api-21-x86
  android-ndk-r10e-api-21-x86-clang-libcxx
  android-ndk-r10e-api-21-x86-64
  android-ndk-r10e-api-21-x86-64-hid
  android-ndk-r10e-api-21-x86-64-hid-sections
  android-ndk-r10e-api-21-mips
  android-ndk-r10e-api-21-mips64
  android-ndk-r10e-api-21-mips-clang-libcxx
  android-ndk-r11c-api-8-armeabi-v7a
  android-ndk-r11c-api-16-armeabi
  android-ndk-r11c-api-16-armeabi-cxx14
  android-ndk-r11c-api-16-armeabi-v7a
  android-ndk-r11c-api-16-armeabi-v7a-cxx14
  android-ndk-r11c-api-16-armeabi-v7a-neon
  android-ndk-r11c-api-16-armeabi-v7a-neon-cxx14
  android-ndk-r11c-api-16-armeabi-v7a-neon-clang-35
  android-ndk-r11c-api-16-armeabi-v7a-neon-clang-35-hid
  android-ndk-r11c-api-16-x86
  android-ndk-r11c-api-16-x86-hid
  android-ndk-r11c-api-19-armeabi-v7a-neon
  android-ndk-r11c-api-21-armeabi-v7a
  android-ndk-r11c-api-21-armeabi-v7a-neon
  android-ndk-r11c-api-21-armeabi-v7a-neon-clang-35
  android-ndk-r11c-api-21-armeabi
  android-ndk-r11c-api-21-arm64-v8a
  android-ndk-r11c-api-21-arm64-v8a-gcc-49
  android-ndk-r11c-api-21-arm64-v8a-gcc-49-hid
  android-ndk-r11c-api-21-arm64-v8a-clang-35
  android-ndk-r11c-api-21-x86
  android-ndk-r11c-api-21-x86-64
  android-ndk-r11c-api-21-x86-64-hid
  android-ndk-r11c-api-21-mips
  android-ndk-r11c-api-21-mips64
  android-ndk-r12b-api-19-armeabi-v7a-neon
  android-ndk-r13b-api-19-armeabi-v7a-neon
  android-ndk-r14-api-16-armeabi-v7a-neon-clang-hid-sections-lto
  android-ndk-r14-api-19-armeabi-v7a-neon-c11
  android-ndk-r14-api-19-armeabi-v7a-neon-clang
  android-ndk-r14-api-19-armeabi-v7a-neon-clang-libcxx
  android-ndk-r14-api-21-arm64-v8a-neon-clang-libcxx
  android-ndk-r14-api-19-armeabi-v7a-neon-hid-sections-lto
  android-ndk-r14-api-21-arm64-v8a-clang-hid-sections-lto
  android-ndk-r14-api-21-x86-64
  android-ndk-r14b-api-21-armeabi-clang-libcxx
  android-ndk-r14b-api-21-armeabi-v7a-neon-clang-libcxx
  android-ndk-r14b-api-21-mips-clang-libcxx
  android-ndk-r14b-api-21-x86-clang-libcxx
  android-ndk-r15c-api-16-armeabi-v7a-neon-clang-libcxx
  android-ndk-r15c-api-16-armeabi-v7a-clang-libcxx
  android-ndk-r15c-api-16-armeabi-clang-libcxx
  android-ndk-r15c-api-16-mips-clang-libcxx
  android-ndk-r15c-api-16-x86-clang-libcxx
  android-ndk-r15c-api-21-arm64-v8a-neon-clang-libcxx
  android-ndk-r15c-api-21-arm64-v8a-clang-libcxx
  android-ndk-r15c-api-21-armeabi-v7a-neon-clang-libcxx
  android-ndk-r15c-api-21-armeabi-clang-libcxx
  android-ndk-r15c-api-21-mips-clang-libcxx
  android-ndk-r15c-api-21-x86-clang-libcxx
  android-ndk-r15c-api-21-x86-64-clang-libcxx
  android-ndk-r15c-api-24-armeabi-v7a-neon-clang-libcxx
  android-ndk-r16b-api-16-armeabi-v7a-clang-libcxx14
  android-ndk-r16b-api-16-armeabi-v7a-thumb-clang-libcxx14
  android-ndk-r16b-api-16-x86-clang-libcxx14
  android-ndk-r16b-api-19-gcc-49-armeabi-v7a-neon-libcxx-hid-sections-lto
  android-ndk-r16b-api-21-armeabi-clang-libcxx
  android-ndk-r16b-api-21-armeabi-clang-libcxx14
  android-ndk-r16b-api-21-armeabi-v7a-clang-libcxx
  android-ndk-r16b-api-21-armeabi-v7a-clang-libcxx14
  android-ndk-r16b-api-21-arm64-v8a-neon-clang-libcxx
  android-ndk-r16b-api-21-arm64-v8a-neon-clang-libcxx14
  android-ndk-r16b-api-21-armeabi-v7a-neon-clang-libcxx
  android-ndk-r16b-api-21-armeabi-v7a-neon-clang-libcxx14
  android-ndk-r16b-api-21-x86-clang-libcxx
  android-ndk-r16b-api-21-x86-64-clang-libcxx
  android-ndk-r16b-api-24-arm64-v8a-clang-libcxx14
  android-ndk-r16b-api-24-armeabi-v7a-neon-clang-libcxx
  android-ndk-r16b-api-24-armeabi-v7a-neon-clang-libcxx14
  android-ndk-r17-api-24-arm64-v8a-clang-libcxx14
  android-ndk-r17-api-21-arm64-v8a-neon-clang-libcxx14
  android-ndk-r17-api-16-armeabi-v7a-clang-libcxx14
  android-ndk-r17-api-16-x86-clang-libcxx14
  android-ndk-r17-api-21-x86-64-clang-libcxx14
  android-ndk-r17-api-19-armeabi-v7a-neon-hid-sections
  android-ndk-r17-api-19-armeabi-v7a-neon-clang-libcxx
  emscripten-cxx11
  raspberrypi1-cxx11-pic
  raspberrypi1-cxx11-pic-static-std
  raspberrypi2-cxx11
  raspberrypi2-cxx11-pic
  raspberrypi3-gcc-pic-hid-sections
  raspberrypi3-cxx11
  ios
  ios-11-4-dep-9-3-arm64
  ios-11-4-dep-9-3-arm64-armv7
  ios-11-4-dep-9-4-arm64
  ios-11-3-dep-9-0-arm64
  ios-11-4-dep-9-0-device-bitcode-cxx11
  ios-11-3-dep-9-0-device-bitcode-cxx11
  ios-11-2-dep-9-0-device-bitcode-cxx11
  ios-11-2-dep-9-3-arm64-armv7
  ios-11-3-dep-9-3-arm64-armv7
  ios-11-1-dep-9-0-bitcode-cxx11
  ios-11-1-dep-9-0-device-bitcode-cxx11
  ios-11-0-dep-9-0-bitcode-cxx11
  ios-11-0-dep-9-0-device-bitcode-cxx11
  ios-11-0
  ios-10-3
  ios-10-3-dep-8-0-bitcode
  ios-10-3-dep-9-0-bitcode
  ios-10-3-dep-9-3-i386-armv7
  ios-10-3-dep-9-3-x86-64-arm64
  ios-10-3-lto
  ios-10-3-armv7
  ios-10-3-arm64
  ios-10-2
  ios-10-2-dep-9-3-armv7
  ios-10-2-dep-9-3-arm64
  ios-10-1
  ios-10-1-arm64
  ios-10-1-arm64-dep-8-0-hid-sections
  ios-10-1-armv7
  ios-10-1-dep-8-0-hid-sections
  ios-10-1-dep-8-0-libcxx-hid-sections
  ios-10-1-dep-8-0-libcxx-hid-sections-lto
  ios-10-1-wo-armv7s
  ios-10-0
  ios-10-0-arm64
  ios-10-0-arm64-dep-8-0-hid-sections
  ios-10-0-armv7
  ios-10-0-dep-8-0-hid-sections
  ios-10-0-wo-armv7s
  ios-9-3
  ios-9-3-arm64
  ios-9-3-armv7
  ios-9-3-wo-armv7s
  ios-9-2
  ios-9-2-arm64
  ios-9-2-armv7
  ios-9-2-hid
  ios-9-2-hid-sections
  ios-9-1-armv7
  ios-9-1-arm64
  ios-9-1-dep-7-0-armv7
  ios-9-1-hid
  ios-9-1-dep-8-0-hid
  ios-9-1
  ios-9-0
  ios-9-0-armv7
  ios-9-0-i386-armv7
  ios-9-0-wo-armv7s
  ios-9-0-dep-7-0-armv7
  ios-8-4
  ios-8-4-arm64
  ios-8-4-armv7
  ios-8-4-armv7s
  ios-8-4-hid
  ios-8-2
  ios-8-2-i386-arm64
  ios-8-2-arm64
  ios-8-2-arm64-hid
  ios-8-2-cxx98
  ios-8-1
  ios-8-0
  ios-7-1
  ios-7-0
  ios-nocodesign
  ios-nocodesign-arm64
  ios-nocodesign-armv7
  ios-nocodesign-hid-sections
  ios-nocodesign-wo-armv7s
  ios-nocodesign-8-4
  ios-nocodesign-8-1
  ios-nocodesign-9-1
  ios-nocodesign-9-1-arm64
  ios-nocodesign-9-1-armv7
  ios-nocodesign-9-2
  ios-nocodesign-9-2-arm64
  ios-nocodesign-9-2-armv7
  ios-nocodesign-9-3
  ios-nocodesign-9-3-device
  ios-nocodesign-9-3-device-hid-sections
  ios-nocodesign-9-3-arm64
  ios-nocodesign-9-3-armv7
  ios-nocodesign-9-3-wo-armv7s
  ios-nocodesign-10-0
  ios-nocodesign-10-0-arm64
  ios-nocodesign-10-0-armv7
  ios-nocodesign-10-0-wo-armv7s
  ios-nocodesign-10-1
  ios-nocodesign-10-1-arm64
  ios-nocodesign-10-1-armv7
  ios-nocodesign-10-1-wo-armv7s
  ios-nocodesign-10-1-arm64-dep-9-0-device-libcxx-hid-sections-lto
  ios-nocodesign-10-1-arm64-dep-9-0-device-libcxx-hid-sections
  ios-nocodesign-10-1-dep-8-0-libcxx-hid-sections-lto
  ios-nocodesign-10-1-dep-8-0-device-libcxx-hid-sections-lto
  ios-nocodesign-10-1-dep-9-0-device-libcxx-hid-sections-lto
  ios-nocodesign-10-2
  ios-nocodesign-10-3
  ios-nocodesign-10-3-cxx14
  ios-nocodesign-10-3-arm64-dep-9-0-device-libcxx-hid-sections
  ios-nocodesign-10-3-dep-9-0-bitcode
  ios-nocodesign-10-3-wo-armv7s
  ios-nocodesign-10-3-arm64
  ios-nocodesign-10-3-armv7
  ios-nocodesign-11-0
  ios-nocodesign-11-0-dep-9-0-bitcode-cxx11
  ios-nocodesign-11-0-arm64-dep-9-0-device-libcxx-hid-sections
  ios-nocodesign-11-1
  ios-nocodesign-11-1-dep-9-0-wo-armv7s-bitcode-cxx11
  ios-nocodesign-11-1-dep-9-0-bitcode-cxx11
  ios-nocodesign-11-2-dep-8-0-wo-armv7s-bitcode-cxx11
  ios-nocodesign-11-2-dep-9-0-bitcode-cxx11
  ios-nocodesign-11-2-dep-9-3
  ios-nocodesign-11-2-dep-9-3-armv7
  ios-nocodesign-11-2-dep-9-3-arm64
  ios-nocodesign-11-2-dep-9-3-arm64-armv7
  ios-nocodesign-11-2-dep-9-3-i386-armv7
  ios-nocodesign-11-2
  ios-nocodesign-11-3-dep-9-3
  ios-nocodesign-11-3-dep-9-3-armv7
  ios-nocodesign-11-3-dep-9-3-arm64
  ios-nocodesign-11-3-dep-9-0-bitcode-cxx11
  ios-nocodesign-11-4-dep-9-0-bitcode-cxx11
  ios-nocodesign-dep-9-0-cxx14
  xcode
  xcode-cxx98
  xcode-nocxx
  xcode-gcc
  xcode-hid-sections
  xcode-sections
  osx-10-7
  osx-10-8
  osx-10-9
  osx-10-10
  osx-10-11
  osx-10-11-hid-sections
  osx-10-11-hid-sections-lto
  osx-10-11-lto
  osx-10-12
  osx-10-12-hid-sections
  osx-10-12-lto
  osx-10-12-cxx98
  osx-10-10-dep-10-7
  osx-10-12-dep-10-10
  osx-10-12-dep-10-10-lto
  osx-10-10-dep-10-9-make
  osx-10-11-make
  osx-10-12-make
  osx-10-12-ninja
  osx-10-11-sanitize-address
  osx-10-12-sanitize-address
  osx-10-12-sanitize-address-hid-sections
  osx-10-13
  osx-10-13-dep-10-10
  osx-10-13-make-cxx14
  osx-10-13-cxx14
  osx-10-13-i386-cxx14
  linux-gcc-x64
  analyze
  analyze-cxx17
  clang-5
  clang-5-cxx14
  clang-5-cxx17
  clang-cxx17
  clang-cxx14
  clang-cxx14-pic
  clang-lto
  clang-libstdcxx
  clang-omp
  clang-fpic
  clang-fpic-hid-sections
  clang-fpic-static-std
  gcc
  gcc-static
  gcc-static-std
  gcc-musl
  gcc-32bit
  gcc-32bit-pic
  gcc-hid
  gcc-hid-fpic
  gcc-gold
  gcc-pic
  gcc-c11
  gcc-cxx14-c11
  gcc-cxx17-c11
  gcc-4-8
  gcc-4-8-c11
  gcc-4-8-pic
  gcc-4-8-pic-hid-sections
  gcc-pic-hid-sections
  gcc-pic-hid-sections-lto
  gcc-5-pic-hid-sections-lto
  gcc-5-pic-hid-sections
  gcc-5
  gcc-5-cxx14-c11
  gcc-6-32bit-cxx14
  gcc-7
  gcc-7-cxx14
  gcc-7-cxx14-pic
  gcc-7-cxx17
  gcc-7-pic-hid-sections-lto
  gcc-cxx98
  gcc-lto
  libcxx
  libcxx14
  libcxx-no-sdk
  libcxx-hid
  libcxx-hid-fpic
  libcxx-fpic-hid-sections
  libcxx-hid-sections
  sanitize-address
  sanitize-address-cxx17
  arm-openwrt-linux-muslgnueabi
  openbsd-egcc-cxx11-static-std

optional arguments:
  -h, --help            show this help message and exit
  --toolchain {default,cxx11,android-ndk-r10e-api-8-armeabi-v7a,android-ndk-r10e-api-16-armeabi-v7a-neon,android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35,android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid,android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid-sections,android-ndk-r10e-api-16-x86,android-ndk-r10e-api-16-x86-hid,android-ndk-r10e-api-16-x86-hid-sections,android-ndk-r10e-api-19-armeabi-v7a-neon,android-ndk-r10e-api-19-armeabi-v7a-neon-c11,android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections,android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections-lto,android-ndk-r10e-api-19-armeabi-v7a-neon-clang-libcxx,android-ndk-r10e-api-21-armeabi-v7a,android-ndk-r10e-api-21-armeabi-v7a-neon,android-ndk-r10e-api-21-armeabi-v7a-neon-hid-sections,android-ndk-r10e-api-21-armeabi-v7a-neon-clang-35,android-ndk-r10e-api-21-armeabi-v7a-neon-clang-libcxx,android-ndk-r10e-api-21-armeabi-clang-libcxx,android-ndk-r10e-api-21-armeabi,android-ndk-r10e-api-21-arm64-v8a,android-ndk-r10e-api-21-arm64-v8a-gcc-49,android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid,android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid-sections,android-ndk-r10e-api-21-arm64-v8a-clang-35,android-ndk-r10e-api-21-x86,android-ndk-r10e-api-21-x86-clang-libcxx,android-ndk-r10e-api-21-x86-64,android-ndk-r10e-api-21-x86-64-hid,android-ndk-r10e-api-21-x86-64-hid-sections,android-ndk-r10e-api-21-mips,android-ndk-r10e-api-21-mips64,android-ndk-r10e-api-21-mips-clang-libcxx,android-ndk-r11c-api-8-armeabi-v7a,android-ndk-r11c-api-16-armeabi,android-ndk-r11c-api-16-armeabi-cxx14,android-ndk-r11c-api-16-armeabi-v7a,android-ndk-r11c-api-16-armeabi-v7a-cxx14,android-ndk-r11c-api-16-armeabi-v7a-neon,android-ndk-r11c-api-16-armeabi-v7a-neon-cxx14,android-ndk-r11c-api-16-armeabi-v7a-neon-clang-35,android-ndk-r11c-api-16-armeabi-v7a-neon-clang-35-hid,android-ndk-r11c-api-16-x86,android-ndk-r11c-api-16-x86-hid,android-ndk-r11c-api-19-armeabi-v7a-neon,android-ndk-r11c-api-21-armeabi-v7a,android-ndk-r11c-api-21-armeabi-v7a-neon,android-ndk-r11c-api-21-armeabi-v7a-neon-clang-35,android-ndk-r11c-api-21-armeabi,android-ndk-r11c-api-21-arm64-v8a,android-ndk-r11c-api-21-arm64-v8a-gcc-49,android-ndk-r11c-api-21-arm64-v8a-gcc-49-hid,android-ndk-r11c-api-21-arm64-v8a-clang-35,android-ndk-r11c-api-21-x86,android-ndk-r11c-api-21-x86-64,android-ndk-r11c-api-21-x86-64-hid,android-ndk-r11c-api-21-mips,android-ndk-r11c-api-21-mips64,android-ndk-r12b-api-19-armeabi-v7a-neon,android-ndk-r13b-api-19-armeabi-v7a-neon,android-ndk-r14-api-16-armeabi-v7a-neon-clang-hid-sections-lto,android-ndk-r14-api-19-armeabi-v7a-neon-c11,android-ndk-r14-api-19-armeabi-v7a-neon-clang,android-ndk-r14-api-19-armeabi-v7a-neon-clang-libcxx,android-ndk-r14-api-21-arm64-v8a-neon-clang-libcxx,android-ndk-r14-api-19-armeabi-v7a-neon-hid-sections-lto,android-ndk-r14-api-21-arm64-v8a-clang-hid-sections-lto,android-ndk-r14-api-21-x86-64,android-ndk-r14b-api-21-armeabi-clang-libcxx,android-ndk-r14b-api-21-armeabi-v7a-neon-clang-libcxx,android-ndk-r14b-api-21-mips-clang-libcxx,android-ndk-r14b-api-21-x86-clang-libcxx,android-ndk-r15c-api-16-armeabi-v7a-neon-clang-libcxx,android-ndk-r15c-api-16-armeabi-v7a-clang-libcxx,android-ndk-r15c-api-16-armeabi-clang-libcxx,android-ndk-r15c-api-16-mips-clang-libcxx,android-ndk-r15c-api-16-x86-clang-libcxx,android-ndk-r15c-api-21-arm64-v8a-neon-clang-libcxx,android-ndk-r15c-api-21-arm64-v8a-clang-libcxx,android-ndk-r15c-api-21-armeabi-v7a-neon-clang-libcxx,android-ndk-r15c-api-21-armeabi-clang-libcxx,android-ndk-r15c-api-21-mips-clang-libcxx,android-ndk-r15c-api-21-x86-clang-libcxx,android-ndk-r15c-api-21-x86-64-clang-libcxx,android-ndk-r15c-api-24-armeabi-v7a-neon-clang-libcxx,android-ndk-r16b-api-16-armeabi-v7a-clang-libcxx14,android-ndk-r16b-api-16-armeabi-v7a-thumb-clang-libcxx14,android-ndk-r16b-api-16-x86-clang-libcxx14,android-ndk-r16b-api-19-gcc-49-armeabi-v7a-neon-libcxx-hid-sections-lto,android-ndk-r16b-api-21-armeabi-clang-libcxx,android-ndk-r16b-api-21-armeabi-clang-libcxx14,android-ndk-r16b-api-21-armeabi-v7a-clang-libcxx,android-ndk-r16b-api-21-armeabi-v7a-clang-libcxx14,android-ndk-r16b-api-21-arm64-v8a-neon-clang-libcxx,android-ndk-r16b-api-21-arm64-v8a-neon-clang-libcxx14,android-ndk-r16b-api-21-armeabi-v7a-neon-clang-libcxx,android-ndk-r16b-api-21-armeabi-v7a-neon-clang-libcxx14,android-ndk-r16b-api-21-x86-clang-libcxx,android-ndk-r16b-api-21-x86-64-clang-libcxx,android-ndk-r16b-api-24-arm64-v8a-clang-libcxx14,android-ndk-r16b-api-24-armeabi-v7a-neon-clang-libcxx,android-ndk-r16b-api-24-armeabi-v7a-neon-clang-libcxx14,android-ndk-r17-api-24-arm64-v8a-clang-libcxx14,android-ndk-r17-api-21-arm64-v8a-neon-clang-libcxx14,android-ndk-r17-api-16-armeabi-v7a-clang-libcxx14,android-ndk-r17-api-16-x86-clang-libcxx14,android-ndk-r17-api-21-x86-64-clang-libcxx14,android-ndk-r17-api-19-armeabi-v7a-neon-hid-sections,android-ndk-r17-api-19-armeabi-v7a-neon-clang-libcxx,emscripten-cxx11,raspberrypi1-cxx11-pic,raspberrypi1-cxx11-pic-static-std,raspberrypi2-cxx11,raspberrypi2-cxx11-pic,raspberrypi3-gcc-pic-hid-sections,raspberrypi3-cxx11,ios,ios-11-4-dep-9-3-arm64,ios-11-4-dep-9-3-arm64-armv7,ios-11-4-dep-9-4-arm64,ios-11-3-dep-9-0-arm64,ios-11-4-dep-9-0-device-bitcode-cxx11,ios-11-3-dep-9-0-device-bitcode-cxx11,ios-11-2-dep-9-0-device-bitcode-cxx11,ios-11-2-dep-9-3-arm64-armv7,ios-11-3-dep-9-3-arm64-armv7,ios-11-1-dep-9-0-bitcode-cxx11,ios-11-1-dep-9-0-device-bitcode-cxx11,ios-11-0-dep-9-0-bitcode-cxx11,ios-11-0-dep-9-0-device-bitcode-cxx11,ios-11-0,ios-10-3,ios-10-3-dep-8-0-bitcode,ios-10-3-dep-9-0-bitcode,ios-10-3-dep-9-3-i386-armv7,ios-10-3-dep-9-3-x86-64-arm64,ios-10-3-lto,ios-10-3-armv7,ios-10-3-arm64,ios-10-2,ios-10-2-dep-9-3-armv7,ios-10-2-dep-9-3-arm64,ios-10-1,ios-10-1-arm64,ios-10-1-arm64-dep-8-0-hid-sections,ios-10-1-armv7,ios-10-1-dep-8-0-hid-sections,ios-10-1-dep-8-0-libcxx-hid-sections,ios-10-1-dep-8-0-libcxx-hid-sections-lto,ios-10-1-wo-armv7s,ios-10-0,ios-10-0-arm64,ios-10-0-arm64-dep-8-0-hid-sections,ios-10-0-armv7,ios-10-0-dep-8-0-hid-sections,ios-10-0-wo-armv7s,ios-9-3,ios-9-3-arm64,ios-9-3-armv7,ios-9-3-wo-armv7s,ios-9-2,ios-9-2-arm64,ios-9-2-armv7,ios-9-2-hid,ios-9-2-hid-sections,ios-9-1-armv7,ios-9-1-arm64,ios-9-1-dep-7-0-armv7,ios-9-1-hid,ios-9-1-dep-8-0-hid,ios-9-1,ios-9-0,ios-9-0-armv7,ios-9-0-i386-armv7,ios-9-0-wo-armv7s,ios-9-0-dep-7-0-armv7,ios-8-4,ios-8-4-arm64,ios-8-4-armv7,ios-8-4-armv7s,ios-8-4-hid,ios-8-2,ios-8-2-i386-arm64,ios-8-2-arm64,ios-8-2-arm64-hid,ios-8-2-cxx98,ios-8-1,ios-8-0,ios-7-1,ios-7-0,ios-nocodesign,ios-nocodesign-arm64,ios-nocodesign-armv7,ios-nocodesign-hid-sections,ios-nocodesign-wo-armv7s,ios-nocodesign-8-4,ios-nocodesign-8-1,ios-nocodesign-9-1,ios-nocodesign-9-1-arm64,ios-nocodesign-9-1-armv7,ios-nocodesign-9-2,ios-nocodesign-9-2-arm64,ios-nocodesign-9-2-armv7,ios-nocodesign-9-3,ios-nocodesign-9-3-device,ios-nocodesign-9-3-device-hid-sections,ios-nocodesign-9-3-arm64,ios-nocodesign-9-3-armv7,ios-nocodesign-9-3-wo-armv7s,ios-nocodesign-10-0,ios-nocodesign-10-0-arm64,ios-nocodesign-10-0-armv7,ios-nocodesign-10-0-wo-armv7s,ios-nocodesign-10-1,ios-nocodesign-10-1-arm64,ios-nocodesign-10-1-armv7,ios-nocodesign-10-1-wo-armv7s,ios-nocodesign-10-1-arm64-dep-9-0-device-libcxx-hid-sections-lto,ios-nocodesign-10-1-arm64-dep-9-0-device-libcxx-hid-sections,ios-nocodesign-10-1-dep-8-0-libcxx-hid-sections-lto,ios-nocodesign-10-1-dep-8-0-device-libcxx-hid-sections-lto,ios-nocodesign-10-1-dep-9-0-device-libcxx-hid-sections-lto,ios-nocodesign-10-2,ios-nocodesign-10-3,ios-nocodesign-10-3-cxx14,ios-nocodesign-10-3-arm64-dep-9-0-device-libcxx-hid-sections,ios-nocodesign-10-3-dep-9-0-bitcode,ios-nocodesign-10-3-wo-armv7s,ios-nocodesign-10-3-arm64,ios-nocodesign-10-3-armv7,ios-nocodesign-11-0,ios-nocodesign-11-0-dep-9-0-bitcode-cxx11,ios-nocodesign-11-0-arm64-dep-9-0-device-libcxx-hid-sections,ios-nocodesign-11-1,ios-nocodesign-11-1-dep-9-0-wo-armv7s-bitcode-cxx11,ios-nocodesign-11-1-dep-9-0-bitcode-cxx11,ios-nocodesign-11-2-dep-8-0-wo-armv7s-bitcode-cxx11,ios-nocodesign-11-2-dep-9-0-bitcode-cxx11,ios-nocodesign-11-2-dep-9-3,ios-nocodesign-11-2-dep-9-3-armv7,ios-nocodesign-11-2-dep-9-3-arm64,ios-nocodesign-11-2-dep-9-3-arm64-armv7,ios-nocodesign-11-2-dep-9-3-i386-armv7,ios-nocodesign-11-2,ios-nocodesign-11-3-dep-9-3,ios-nocodesign-11-3-dep-9-3-armv7,ios-nocodesign-11-3-dep-9-3-arm64,ios-nocodesign-11-3-dep-9-0-bitcode-cxx11,ios-nocodesign-11-4-dep-9-0-bitcode-cxx11,ios-nocodesign-dep-9-0-cxx14,xcode,xcode-cxx98,xcode-nocxx,xcode-gcc,xcode-hid-sections,xcode-sections,osx-10-7,osx-10-8,osx-10-9,osx-10-10,osx-10-11,osx-10-11-hid-sections,osx-10-11-hid-sections-lto,osx-10-11-lto,osx-10-12,osx-10-12-hid-sections,osx-10-12-lto,osx-10-12-cxx98,osx-10-10-dep-10-7,osx-10-12-dep-10-10,osx-10-12-dep-10-10-lto,osx-10-10-dep-10-9-make,osx-10-11-make,osx-10-12-make,osx-10-12-ninja,osx-10-11-sanitize-address,osx-10-12-sanitize-address,osx-10-12-sanitize-address-hid-sections,osx-10-13,osx-10-13-dep-10-10,osx-10-13-make-cxx14,osx-10-13-cxx14,osx-10-13-i386-cxx14,linux-gcc-x64,analyze,analyze-cxx17,clang-5,clang-5-cxx14,clang-5-cxx17,clang-cxx17,clang-cxx14,clang-cxx14-pic,clang-lto,clang-libstdcxx,clang-omp,clang-fpic,clang-fpic-hid-sections,clang-fpic-static-std,gcc,gcc-static,gcc-static-std,gcc-musl,gcc-32bit,gcc-32bit-pic,gcc-hid,gcc-hid-fpic,gcc-gold,gcc-pic,gcc-c11,gcc-cxx14-c11,gcc-cxx17-c11,gcc-4-8,gcc-4-8-c11,gcc-4-8-pic,gcc-4-8-pic-hid-sections,gcc-pic-hid-sections,gcc-pic-hid-sections-lto,gcc-5-pic-hid-sections-lto,gcc-5-pic-hid-sections,gcc-5,gcc-5-cxx14-c11,gcc-6-32bit-cxx14,gcc-7,gcc-7-cxx14,gcc-7-cxx14-pic,gcc-7-cxx17,gcc-7-pic-hid-sections-lto,gcc-cxx98,gcc-lto,libcxx,libcxx14,libcxx-no-sdk,libcxx-hid,libcxx-hid-fpic,libcxx-fpic-hid-sections,libcxx-hid-sections,sanitize-address,sanitize-address-cxx17,arm-openwrt-linux-muslgnueabi,openbsd-egcc-cxx11-static-std}
                        CMake generator/toolchain
  --config CONFIG       CMake build type (Release, Debug, ...)
  --keep-going          Continue as much as possible after an error. see make
                        -k
  --config-all CONFIG_ALL
                        CMake build type for project and hunter packages:
                        --config <type> --fwd
                        HUNTER_CONFIGURATION_TYPES=<type>
  --home HOME           Project home directory (directory with CMakeLists.txt)
  --output OUTPUT       Project build directory (i.e., cmake -B)
  --cache CACHE         CMake -C <initial-cache> = Pre-load a script to
                        populate the cache.
  --test                Run ctest after build
  --test-xml TEST_XML   Save ctest output to xml
  --pack [{7Z,IFW,NSIS,NSIS64,STGZ,TBZ2,TGZ,TXZ,TZ,ZIP,Bundle,DragNDrop,OSXX11,PackageMaker}]
                        Run cpack after build
  --archive ARCHIVE     Create an archive of locally installed files
  --nobuild             Do not build (only generate)
  --open                Open generated project (for IDE)
  --verbosity-level {silent,normal,full}
                        Verbosity level
  --verbose             Full verbose output
  --install             Run install (local directory)
  --ios-multiarch       Build multi-architecture binary (effectively add
                        CMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO)
  --ios-combined        Combine iOS simulator and device libraries on install
                        (effectively add CMAKE_IOS_INSTALL_COMBINED=YES)
  --framework           Create framework
  --framework-device    Create framework for device (exclude simulator
                        architectures)
  --framework-lib FRAMEWORK_LIB
                        Regular expression for the source library used for
                        --framework
  --strip               Run strip/install cmake targets
  --identity IDENTITY   Specify code signing identity for --framework
  --plist PLIST         User specified Info.plist file for --framework
  --clear               Remove build and install dirs before build
  --reconfig            Run configure even if CMakeCache.txt exists. Used to
                        add new args.
  --fwd [FWD [FWD ...]]
                        Arguments to cmake without '-D', like:
                        BOOST_ROOT=/some/path
  --iossim              Build for ios i386 simulator
  --jobs JOBS           Number of concurrent build operations
  --target TARGET       Target to build for the 'cmake --build' command
  --discard DISCARD     Option to reduce output. Discard every N lines of
                        execution messages (note that full log is still
                        available in log.txt)
  --tail TAIL           Print last N lines if build failed
  --timeout TIMEOUT     Timeout for CTest
  --cmake CMAKE         CMake binary (cmake or cmake3)
  --cpack CPACK         CPack binary (cpack or cpack3)
  --ctest CTEST         CTest binary (ctest or ctest3)
