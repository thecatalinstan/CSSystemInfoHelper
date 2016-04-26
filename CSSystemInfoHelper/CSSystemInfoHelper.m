//
//  CSSystemInfoHelper.m
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 05/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import "CSSystemInfoHelper.h"

#import <stdio.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/utsname.h>
#import <mach/mach.h>

NSString * const CSSystemInfoSysnameKey = @"CSSystemInfoSysname";
NSString * const CSSystemInfoNodenameKey = @"CSSystemInfoNodename";
NSString * const CSSystemInfoReleaseKey = @"CSSystemInfoRelease";
NSString * const CSSystemInfoVersionKey = @"CSSystemInfoVersion";
NSString * const CSSystemInfoMachineKey = @"CSSystemInfoMachine";

@interface CSSystemInfoHelper ()

@property (nonatomic, readonly, strong) dispatch_queue_t isolationQueue;

@end

@implementation CSSystemInfoHelper

static CSSystemInfoHelper* sharedHelper;
static NSMutableDictionary<NSString *, NSString *> * allIPAddresses;

+ (void)load {
    sharedHelper = [[CSSystemInfoHelper alloc] init];
    allIPAddresses = [NSMutableDictionary dictionary];

    struct ifaddrs * interfaces = NULL;
    struct ifaddrs * addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        addr = interfaces;
        while(addr != NULL) {
            if(addr->ifa_addr->sa_family == AF_INET) {
                allIPAddresses[[NSString stringWithUTF8String:addr->ifa_name]] = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)addr->ifa_addr)->sin_addr)];
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
}

+ (instancetype)sharedHelper {
    return sharedHelper;
}

- (instancetype)init {
    self  = [super init];
    if ( self != nil ) {
        NSString* isolationQueueLabel = [NSString stringWithFormat:@"%@-isolationQueue-%@", NSStringFromClass(self.class), @(self.hash)];
        _isolationQueue = dispatch_queue_create(isolationQueueLabel.UTF8String, DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(_isolationQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0));
    }
    return self;
}

- (NSDictionary<NSString *,NSString *> *)AllIPAddresses {
    return allIPAddresses;
}

- (NSString *)IPAddress {
    return self.AllIPAddresses[@"en0"];
}

- (NSDictionary<NSString *,NSString *> *)systemInfo {
    static NSDictionary<NSString *, NSString *> * systemInfo;
    if ( systemInfo == nil ) {
        struct utsname unameStruct;
        if ( uname(&unameStruct) != 0 ) {
            @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithUTF8String:strerror(errno)] userInfo:nil];
            return nil;
        }
        systemInfo = @{CSSystemInfoSysnameKey: @(unameStruct.sysname), CSSystemInfoNodenameKey: @(unameStruct.nodename), CSSystemInfoReleaseKey: @(unameStruct.release), CSSystemInfoVersionKey: @(unameStruct.version), CSSystemInfoMachineKey: @(unameStruct.machine)};
    }
    return systemInfo;
}

- (NSString *)systemInfoString {
    static NSString* systemInfoString;
    if ( systemInfoString == nil ) {
        systemInfoString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", self.systemInfo[CSSystemInfoSysnameKey], self.systemInfo[CSSystemInfoNodenameKey], self.systemInfo[CSSystemInfoReleaseKey], self.systemInfo[CSSystemInfoVersionKey], self.systemInfo[CSSystemInfoMachineKey]];
    }
    return systemInfoString;
}

- (NSString *)systemVersionString {
    static NSString* systemVersionString;
    if ( systemVersionString == nil ) {
        systemVersionString = [NSString stringWithFormat:@"%@ %@ %@", self.systemInfo[CSSystemInfoSysnameKey], self.systemInfo[CSSystemInfoReleaseKey], self.systemInfo[CSSystemInfoMachineKey]];
    }
    return systemVersionString;
}

- (vm_size_t)memoryUsage {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    if( kerr != KERN_SUCCESS ) {
        @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithUTF8String:mach_error_string(kerr)] userInfo:nil];
    }
    return info.resident_size;
}

- (NSString *)memoryUsageString {
    return [NSByteCountFormatter stringFromByteCount:self.memoryUsage countStyle:NSByteCountFormatterCountStyleMemory];
}

@end
