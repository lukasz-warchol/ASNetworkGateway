#ifdef __IPHONE_5_0
#define WEAK weak
#define __WEAK __weak
#else
#define WEAK unsafe_unretained
#define __WEAK __unsafe_unretained
#endif
