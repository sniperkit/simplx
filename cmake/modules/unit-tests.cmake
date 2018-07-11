
########################
##      UNIT TESTS
########################

# helper function
# function to add a unit test. Must be defined BEFORE add_subdirectory()
function(trz_add_test test_name source_file depedency)
    add_executable(${test_name} ${source_file})
    trz_target_link_libraries(${test_name} "${depedency}" )
    add_test(${test_name} ${test_name})     # add_test(TEST_NAME CMAKE_REF)
endfunction()
