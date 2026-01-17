add_library(core SHARED
    src/core.cpp
)

target_include_directories(core
    PUBLIC include
)
