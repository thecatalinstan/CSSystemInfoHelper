//
//  MyClass.h
//  
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import <Foundation/Foundation.h>
#import "CSSystemInfoProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSSystemInfoProviderMock : NSObject <CSSystemInfoProviderProtocol>

+ (instancetype)failingProviderWithError:(NSError *_Nullable)error;
+ (instancetype)succeedingProviderWithNetworkInterfaces:(NSArray<CSNetworkInterface *> *)networkInterfaces;

@end

NS_ASSUME_NONNULL_END
