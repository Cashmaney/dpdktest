cmake_minimum_required(VERSION 3.8)
project(dpdktest)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/)

## prints all environment variables - useful for debugging the compilation
#execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "environment")
find_package(dpdk REQUIRED)

set(SOURCE_FILES main.c)
add_executable(dpdktest ${SOURCE_FILES})

include_directories(${DPDK_INCLUDE_DIR})
add_definitions(-mssse3 -mavx2 -mavx -D__STDC_LIMIT_MACROS)
target_link_libraries(dpdktest ${DPDK_LIBRARIES})
target_link_libraries(dpdktest pthread dl rt)


