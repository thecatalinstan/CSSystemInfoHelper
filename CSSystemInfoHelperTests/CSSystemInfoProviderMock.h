//
//  CSSystemInfoProviderMock.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import <Foundation/Foundation.h>
#import "CSSystemInfoProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSSystemInfoProviderMock : NSObject <CSSystemInfoProviderProtocol>

+ (instancetype)failingProviderWithError:(NSError *_Nullable)error;
+ (instancetype)failingProviderWithResidentSize:(vm_size_t * _Nullable)residentSize error:(NSError *_Nullable)error;
+ (instancetype)failingProviderWithPhysFootprint:(vm_size_t * _Nullable)physFootprint error:(NSError *_Nullable)error;

+ (instancetype)succeedingProviderWithNetworkInterfaces:(NSArray<CSNetworkInterface *> *)networkInterfaces;
+ (instancetype)succeedingProviderWithResidentSize:(vm_size_t *)residentSize;
+ (instancetype)succeedingProviderWithPhysFootprint:(vm_size_t *)physFootprint;

@end

NS_ASSUME_NONNULL_END
