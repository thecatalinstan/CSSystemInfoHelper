//
//  CSSystemInfoHelper.m
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 05/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import <CSSystemInfoHelper/CSSystemInfoHelper.h>

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <mach/mach.h>
//#import <stdio.h>
#import <sys/utsname.h>

NSString * const CSSystemInfoKeySysname = @"CSSystemInfoSysname";
NSString * const CSSystemInfoKeyNodename = @"CSSystemInfoNodename";
NSString * const CSSystemInfoKeyRelease = @"CSSystemInfoRelease";
NSString * const CSSystemInfoKeyVersion = @"CSSystemInfoVersion";
NSString * const CSSystemInfoKeyMachine = @"CSSystemInfoMachine";

__attribute__((objc_direct_members))
@interface CSSystemInfoHelper ()
@end

@implementation CSSystemInfoHelper

static CSSystemInfoHelper* sharedHelper;

+ (void)initialize {
    sharedHelper = [[CSSystemInfoHelper alloc] init];
}

+ (instancetype)sharedHelper {
    return sharedHelper;
}

- (NSDictionary<NSString *,NSString *> *)AllIPAddresses {
    static NSMutableDictionary<NSString *, NSString *> * allIPAddresses;
    if (!allIPAddresses) {
        allIPAddresses = [NSMutableDictionary dictionaryWithCapacity:4];
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
    return allIPAddresses;
}

- (NSString *)IPAddress {
    static NSString *IPAddress;
    if (!IPAddress) {
        IPAddress = self.AllIPAddresses[@"en0"];
    }
    return IPAddress;
}

- (NSDictionary<CSSystemInfoKey, NSString *> *)systemInfo {
    static NSDictionary<CSSystemInfoKey, NSString *> * systemInfo;
    if (!systemInfo) {
        struct utsname unameStruct;
        if (uname(&unameStruct) != 0) {
            @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithUTF8String:strerror(errno)] userInfo:nil];
        }
        
        systemInfo = @{
            CSSystemInfoKeySysname: @(unameStruct.sysname),
            CSSystemInfoKeyNodename: @(unameStruct.nodename),
            CSSystemInfoKeyRelease: @(unameStruct.release),
            CSSystemInfoKeyVersion: @(unameStruct.version),
            CSSystemInfoKeyMachine: @(unameStruct.machine)
        };
    }
    return systemInfo;
}

- (NSString *)systemInfoString {
    static NSString *systemInfoString;
    if (!systemInfoString) {
        systemInfoString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                            self.systemInfo[CSSystemInfoKeySysname],
                            self.systemInfo[CSSystemInfoKeyNodename],
                            self.systemInfo[CSSystemInfoKeyRelease],
                            self.systemInfo[CSSystemInfoKeyVersion],
                            self.systemInfo[CSSystemInfoKeyMachine]];
    }
    return systemInfoString;
}

- (NSString *)systemVersionString {
    static NSString* systemVersionString;
    if (!systemVersionString) {
        systemVersionString = [NSString stringWithFormat:@"%@ %@ %@",
                               self.systemInfo[CSSystemInfoKeySysname],
                               self.systemInfo[CSSystemInfoKeyRelease],
                               self.systemInfo[CSSystemInfoKeyMachine]];
    }
    return systemVersionString;
}

- (vm_size_t)memoryUsage {
    //task_vm_info
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    if(kerr != KERN_SUCCESS) {
        @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithUTF8String:mach_error_string(kerr)] userInfo:nil];
    }
    return info.resident_size;
}

- (NSString *)memoryUsageString {
    return [NSByteCountFormatter stringFromByteCount:self.memoryUsage countStyle:NSByteCountFormatterCountStyleMemory];
}

#if TARGET_OS_OSX
- (NSString *)platformUUID {
    static NSString* platformUUID;
    if (!platformUUID) {
        io_registry_entry_t ioRegistryRoot = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/");
        CFStringRef uuidCf = (CFStringRef) IORegistryEntryCreateCFProperty(ioRegistryRoot, CFSTR(kIOPlatformUUIDKey), kCFAllocatorDefault, 0);
        IOObjectRelease(ioRegistryRoot);
        platformUUID = CFBridgingRelease(uuidCf);
    }
    return platformUUID;
}
#endif

@end
