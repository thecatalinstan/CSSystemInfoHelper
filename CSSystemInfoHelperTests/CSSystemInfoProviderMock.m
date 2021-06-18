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
@property CSSystemInfo *systemInfo;
@property vm_size_t *residentSize;
@property vm_size_t *physFootprint;

@end

@implementation CSSystemInfoProviderMock

+ (instancetype)failingProviderWithError:(NSError *)error {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = NO;
    provider.error = error;
    return provider;
}

+ (instancetype)failingProviderWithNetworkInterfaces:(NSArray<CSNetworkInterface *> *)networkInterfaces error:(NSError *)error {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = NO;
    provider.error = error;
    provider.networkInterfaces = networkInterfaces;
    return provider;
}

+ (instancetype)failingProviderWithSystemInfo:(CSSystemInfo *)systemInfo error:(NSError *)error {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = NO;
    provider.error = error;
    provider.systemInfo = systemInfo;
    return provider;
}

+ (instancetype)failingProviderWithResidentSize:(vm_size_t *)residentSize error:(NSError *)error {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = NO;
    provider.error = error;
    provider.residentSize = residentSize;
    return provider;
}

+ (instancetype)failingProviderWithPhysFootprint:(vm_size_t *)physFootprint error:(NSError *)error {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = NO;
    provider.error = error;
    provider.physFootprint = physFootprint;
    return provider;

}

+ (instancetype)succeedingProviderWithNetworkInterfaces:(NSArray<CSNetworkInterface *> *)networkInterfaces {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = YES;
    provider.networkInterfaces = networkInterfaces;
    return provider;
}

+ (instancetype)succeedingProviderWithSystemInfo:(CSSystemInfo *)systemInfo {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = YES;
    provider.systemInfo = systemInfo;
    return provider;
}

+ (instancetype)succeedingProviderWithResidentSize:(vm_size_t *)residentSize {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = YES;
    provider.residentSize = residentSize;
    return provider;
}

+ (instancetype)succeedingProviderWithPhysFootprint:(vm_size_t *)physFootprint {
    CSSystemInfoProviderMock * provider = [CSSystemInfoProviderMock new];
    provider.shouldSucceed = YES;
    provider.physFootprint = physFootprint;
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

- (nullable CSSystemInfo *)quertSystemInfo:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    if (!self.shouldSucceed) {
        if (error) {
            *error = self.error;
        }
        return nil;
    }

    return self.systemInfo;
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

-(BOOL)getPhysFootprint:(vm_size_t *)physFootprint error:(NSError *__autoreleasing  _Nullable *)error {
    if (self.physFootprint) {
        *physFootprint = *(self.physFootprint);
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
