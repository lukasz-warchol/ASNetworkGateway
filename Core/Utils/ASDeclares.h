#if TARGET_OS_IPHONE && defined(__IPHONE_5_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_5_0)
    #define AS_WEAK unsafe_unretained
    #define __AS_WEAK __unsafe_unretained
#elif TARGET_OS_MAC && defined(__MAC_10_7) && (__MAC_OS_X_VERSION_MAX_ALLOWED >= __MAC_10_7)
    #define AS_WEAK unsafe_unretained
    #define __AS_WEAK __unsafe_unretained
#else
    #define AS_WEAK unsafe_unretained
    #define __AS_WEAK __unsafe_unretained
#endif