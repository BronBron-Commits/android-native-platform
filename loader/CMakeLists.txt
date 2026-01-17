add_library(native_activity SHARED
    src/loader.cpp
)

target_include_directories(native_activity
    PRIVATE include
)

target_link_libraries(native_activity
    android
    log
    EGL
    GLESv2
)
