cmake_minimum_required(VERSION 3.22)

project(android_native_platform
    LANGUAGES C CXX
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include(cmake/options.cmake)

add_subdirectory(core)
add_subdirectory(loader)
