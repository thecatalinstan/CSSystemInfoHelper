//
//  MyClass.m
//  
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import "CSSystemInfoProviderMock.h"
#import "CSNetworkInterface+Internal.h"

@interface CSSystemInfoProviderMock ()

@property BOOL shouldSucceed;
@property NSError *error;
@property NSArray<CSNetworkInterface *> *networkInterfaces;

@end

@implementation CSSystemInfoProviderMock

+ (instancetype)failingProviderWithError:(NSError *)error {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = NO;
    provider.error = error;
    return provider;
}

+ (instancetype)succeedingProviderWithNetworkInterfaces:(NSArray<CSNetworkInterface *> *)networkInterfaces {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = YES;
    provider.networkInterfaces = networkInterfaces;
    return provider;
}

- (nullable NSArray<CSNetworkInterface *> *)queryNetworkInterfaces:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    if (!self.shouldSucceed) {
        if (error) {
            *error = self.error;
        }
        return nil;
    }

    return self.networkInterfaces;
}

@end
