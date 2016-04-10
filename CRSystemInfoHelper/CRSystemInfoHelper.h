//
//  CRSystemInfoHelper.h
//  CRSystemInfoHelper
//
//  Created by Cătălin Stan on 05/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double CRSystemInfoHelperVersionNumber;
FOUNDATION_EXPORT const unsigned char CRSystemInfoHelperVersionString[];

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const CRSystemInfoSysnameKey;
FOUNDATION_EXPORT NSString * const CRSystemInfoNodenameKey;
FOUNDATION_EXPORT NSString * const CRSystemInfoReleaseKey;
FOUNDATION_EXPORT NSString * const CRSystemInfoVersionKey;
FOUNDATION_EXPORT NSString * const CRSystemInfoMachineKey;

@interface CRSystemInfoHelper : NSObject

+ (instancetype)sharedHelper;

@property (nonatomic, readonly, strong) NSDictionary<NSString *, NSString *> * AllIPAddresses;
@property (nonatomic, readonly, strong) NSString * IPAddress;

@property (nonatomic, readonly, strong) NSDictionary<NSString *, NSString *> * systemInfo;
@property (nonatomic, readonly, strong) NSString * systemInfoString;
@property (nonatomic, readonly, strong) NSString * systemVersionString;

@property (nonatomic, readonly) vm_size_t memoryUsage;
@property (nonatomic, readonly, strong) NSString * memoryUsageString;

@end

NS_ASSUME_NONNULL_END