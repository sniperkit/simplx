
# set link dependencies
function(trz_target_link_libraries test_name depedency)
  target_link_libraries(${test_name} ${depedency} ${CMAKE_THREAD_LIBS_INIT} PRIVATE GTest::gtest_main)
endfunction()
