//
//  CSSystemInfoProvider.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>

@class CSNetworkInterface;

NS_ASSUME_NONNULL_BEGIN

@protocol CSSystemInfoProviderProtocol

- (nullable NSArray<CSNetworkInterface *> *)queryNetworkInterfaces:(NSError *__autoreleasing *)error NS_WARN_UNUSED_RESULT;

@end

@interface CSSystemInfoProvider : NSObject<CSSystemInfoProviderProtocol>

@property (class, nonatomic, readonly) CSSystemInfoProvider *sharedProvider;

- (nullable CSNetworkInterface *)interfaceAddressWithAddr:(struct ifaddrs *)addr error:(NSError *__autoreleasing *)error NS_WARN_UNUSED_RESULT;

@end

NS_ASSUME_NONNULL_END