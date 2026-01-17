if (CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    add_compile_options(
        -Wall
        -Wextra
        -Wpedantic
        -fno-exceptions
        -fno-rtti
        -fno-omit-frame-pointer
    )
endif()
