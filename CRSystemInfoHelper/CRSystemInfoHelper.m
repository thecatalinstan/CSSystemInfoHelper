//
//  CRSystemInfoHelper.m
//  CRSystemInfoHelper
//
//  Created by Cătălin Stan on 05/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import "CRSystemInfoHelper.h"

#import <stdio.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/utsname.h>
#import <mach/mach.h>

NSString * const CRSystemInfoSysnameKey = @"CRSystemInfoSysname";
NSString * const CRSystemInfoNodenameKey = @"CRSystemInfoNodename";
NSString * const CRSystemInfoReleaseKey = @"CRSystemInfoRelease";
NSString * const CRSystemInfoVersionKey = @"CRSystemInfoVersion";
NSString * const CRSystemInfoMachineKey = @"CRSystemInfoMachine";

@interface CRSystemInfoHelper ()

@property (nonatomic, readonly, strong) dispatch_queue_t isolationQueue;

@end

@implementation CRSystemInfoHelper

+ (instancetype)sharedHelper {
    static CRSystemInfoHelper* sharedHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[CRSystemInfoHelper alloc] init];
    });
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
    static NSMutableDictionary<NSString *,NSString *> *allIPAddresses;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allIPAddresses = [NSMutableDictionary dictionary];

        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;
        success = getifaddrs(&interfaces);
        if (success == 0) {
            temp_addr = interfaces;
            while(temp_addr != NULL) {
                if(temp_addr->ifa_addr->sa_family == AF_INET) {
                    allIPAddresses[[NSString stringWithUTF8String:temp_addr->ifa_name]] = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
        freeifaddrs(interfaces);
    });
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
        systemInfo = @{CRSystemInfoSysnameKey: @(unameStruct.sysname), CRSystemInfoNodenameKey: @(unameStruct.nodename), CRSystemInfoReleaseKey: @(unameStruct.release), CRSystemInfoVersionKey: @(unameStruct.version), CRSystemInfoMachineKey: @(unameStruct.machine)};
    }
    return systemInfo;
}

- (NSString *)systemInfoString {
    static NSString* systemInfoString;
    if ( systemInfoString == nil ) {
        systemInfoString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", self.systemInfo[CRSystemInfoSysnameKey], self.systemInfo[CRSystemInfoNodenameKey], self.systemInfo[CRSystemInfoReleaseKey], self.systemInfo[CRSystemInfoVersionKey], self.systemInfo[CRSystemInfoMachineKey]];
    }
    return systemInfoString;
}

- (NSString *)systemVersionString {
    static NSString* systemVersionString;
    if ( systemVersionString == nil ) {
        systemVersionString = [NSString stringWithFormat:@"%@ %@ %@", self.systemInfo[CRSystemInfoSysnameKey], self.systemInfo[CRSystemInfoReleaseKey], self.systemInfo[CRSystemInfoMachineKey]];
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

//+ (NSTimeInterval *)processRunningTime {
//    NSTimeInterval processRunningTime = processStartTime.timeIntervalSinceNow;
//    NSString* processRunningTimeString;
//
//    static NSDateComponentsFormatter *formatter;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        formatter = [[NSDateComponentsFormatter alloc] init];
//        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
//        formatter.includesApproximationPhrase = YES;
//        formatter.includesTimeRemainingPhrase = NO;
//        formatter.allowedUnits = NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
//    });
//
//    processRunningTimeString = [formatter stringFromTimeInterval:fabs(processRunningTime)];
//    return processRunningTimeString.lowercaseString;
//}
//
//
//+ (void)addRequest {
//    dispatch_async(backgroundQueue, ^{
//        requestsServed++;
//    });
//}
//
//+ (NSString *)requestsServed {
//    static NSNumberFormatter* formatter;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        formatter = [[NSNumberFormatter alloc] init];
//        formatter.numberStyle = NSNumberFormatterDecimalStyle;
//        formatter.maximumFractionDigits = 1;
//    });
//    NSArray<NSString *> * units = @[@"", @"K", @"M", @"B", @"trillion", @"quadrillion", @"quintillion", @"quintillion", @"sextilion", @"septillion", @"octillion", @"nonillion", @"decillion", @"undecillion", @"duodecillion", @"tredecillion", @"quatttuor-decillion", @"quindecillion", @"sexdecillion", @"septen-decillion", @"octodecillion", @"novemdecillion", @"vigintillion"];
//
//    __block double requestCount = requestsServed;
//    //    __block double requestCount = INT64_MAX;
//    __block NSString *unit = @"";
//
//    if ( requestCount >= pow(1000, units.count) ) {
//        requestCount = requestCount / pow(1000, units.count - 1);
//        unit = units.lastObject;
//    } else {
//        [units enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            unit = obj;
//            if ( requestCount < pow(1000, idx + 1) ) {
//                requestCount = requestCount / pow(1000, idx);
//                *stop = YES;
//            }
//        }];
//    }
//
//    return [NSString stringWithFormat:@"about %@%@%@", [formatter stringFromNumber:@(requestCount)], unit.length > 0 ? @" " : @"", unit];
//}
//
//+ (NSString *)criolloVersion {
//    static NSString* criolloVersion;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSBundle *criolloBundle = [NSBundle bundleWithIdentifier:CRBundleIdentifier];
//        criolloVersion = [criolloBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//        if ( criolloVersion == nil ) {
//            criolloVersion = CRCriolloVersionFallback;
//        }
//    });
//    return criolloVersion;
//}
//
//+ (NSString *)bundleVersion {
//    static NSString* bundleVersion;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSBundle *bundle = [NSBundle mainBundle];
//        bundleVersion = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    });
//    return bundleVersion;
//}

@end
