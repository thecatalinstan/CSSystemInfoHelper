//
//  CRSystemInfoHelper.h
//  CriolloApp
//
//  Created by Cătălin Stan on 05/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double CRSystemInfoHelperVersionNumber;
FOUNDATION_EXPORT const unsigned char CRSystemInfoHelperVersionString[];

NS_ASSUME_NONNULL_BEGIN

@interface CRSystemInfoHelper : NSObject

@property (nonatomic, readonly, strong) NSString * IPAddress;
@property (nonatomic, readonly, strong) NSDictionary<NSString *, NSString *> * AllIPAddresses;

+ (instancetype)sharedHelper;


//- (NSDictionary<NSString *, NSString *>* )systemInfo;
//
//- (NSString *)systemInfoString;
//- (NSString *)systemVersionString;
//
//- (NSString *)processName;
//- (NSString *)processRunningTime;
//
//- (NSNumber *)memoryInfo:(NSError * _Nullable __autoreleasing *)error;
//
//- (NSString *)criolloVersion;
//- (NSString *)bundleVersion;
//
//- (NSString *)requestsServed;
//- (void)addRequest;

@end
NS_ASSUME_NONNULL_END