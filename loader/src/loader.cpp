#include <android/native_activity.h>
#include <android/log.h>

#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, "NativePlatform", __VA_ARGS__)

extern "C" void ANativeActivity_onCreate(
    ANativeActivity* activity,
    void* savedState,
    size_t savedStateSize)
{
    (void)savedState;
    (void)savedStateSize;

    LOGI("NativeActivity created");
}
