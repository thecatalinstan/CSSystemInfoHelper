//
//  CSSystemInfoProviderMock.m
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import "CSSystemInfoProviderMock.h"
#import "CSNetworkInterface+Internal.h"

@interface CSSystemInfoProviderMock ()

@property BOOL shouldSucceed;
@property NSError *error;
@property NSArray<CSNetworkInterface *> *networkInterfaces;
@property vm_size_t *residentSize;

@end

@implementation CSSystemInfoProviderMock

+ (instancetype)failingProviderWithError:(NSError *)error {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = NO;
    provider.error = error;
    return provider;
}

+ (instancetype)failingProviderWithResidentSize:(vm_size_t *)residentSize error:(NSError *)error {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = NO;
    provider.error = error;
    provider.residentSize = residentSize;
    return provider;
}

+ (instancetype)succeedingProviderWithNetworkInterfaces:(NSArray<CSNetworkInterface *> *)networkInterfaces {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = YES;
    provider.networkInterfaces = networkInterfaces;
    return provider;
}

+ (instancetype)succeedingProviderWithResidentSize:(vm_size_t *)residentSize {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = YES;
    provider.residentSize = residentSize;
    return provider;
}

#pragma mark - CSSystemInfoProviderProtocol

- (nullable NSArray<CSNetworkInterface *> *)queryNetworkInterfaces:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    if (!self.shouldSucceed) {
        if (error) {
            *error = self.error;
        }
        return nil;
    }

    return self.networkInterfaces;
}

- (BOOL)getResidentSize:(nonnull vm_size_t *)residentSize error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    if (self.residentSize) {
        *residentSize = *(self.residentSize);
    }
    
    if (!self.shouldSucceed) {
        if (error) {
            *error = self.error;
        }
        return NO;
    }

    return YES;
}


@end
