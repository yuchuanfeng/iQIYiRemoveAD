#include "hookzz.h"
#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "fishhook.h"

#if defined(__LP64__)
typedef struct mach_header_64 mach_header_t;
typedef struct segment_command_64 segment_command_t;
typedef struct section_64 section_t;
typedef struct nlist_64 nlist_t;
#define LC_SEGMENT_ARCH_DEPENDENT LC_SEGMENT_64
#else
typedef struct mach_header mach_header_t;
typedef struct segment_command segment_command_t;
typedef struct section section_t;
typedef struct nlist nlist_t;
#define LC_SEGMENT_ARCH_DEPENDENT LC_SEGMENT
#endif

typedef void *zz_ptr_t;
typedef unsigned long zz_addr_t;

#if defined(__LP64__)
#define ZREG(n) general.regs.x##n
#else
#define ZREG(n) general.regs.r##n
#endif

char decollators[128]           = {0};
int filter_max                  = 0;
char *class_address_filters[20] = {0};

@interface HookZzDemo : NSObject

@end

@implementation HookZzDemo

+ (void)load {
//    char *class_name_filters[20] = {
//        "YYImage", "YYImageDecoder",
//    };
//
//    filter_max = sizeof(class_name_filters) / sizeof(char *);
//    int i;
//    for (i = 0; i < filter_max; i++) {
//        class_address_filters[i] = objc_getClass(class_name_filters[i]);
//    }

    [self hook_objc_msgSend];

    HookZzDemo *zz = [HookZzDemo new];
    [zz log_for_test];
}

- (void)log_for_test {
    NSLog(@"catch by HookZz");
}


void objc_msgSend_pre_call(RegState *rs, ThreadStackPublic *ts,  CallStackPublic *cs, const HookEntryInfo *info);

+ (void)hook_objc_msgSend {
    ZzWrap((void *)objc_msgSend, &objc_msgSend_pre_call, NULL);
}



void objc_msgSend_pre_call(RegState *rs, ThreadStackPublic *ts,  CallStackPublic *cs, const HookEntryInfo *info) {
    char *selector = (char *)rs->ZREG(1);
    id tmpObject = (id)rs->ZREG(0);
    Class tmpClass  = object_getClass(tmpObject);

    if (!tmpClass)
        return;
    const char *className               = class_getName(tmpClass);
    if (!strstr(className, "Ad")) {
        return;
    }
    
    memset(decollators, '-', 128);
    if (ts->call_stack_count * 3 >= 128)
        return;
    decollators[ts->call_stack_count * 3] = '\0';
    
    printf("[OCMethodMonitor|%ld] %s [%s %s]\n", ts->thread_id, decollators, className, selector);
}

//void ojbc_msgSend_post_call(RegState *rs, ThreadStackPublic *threadstack, CallStackPublic *callstack, const HookEntryInfo *info) {
//    NSLog(@"post call success.");
//}

@end


