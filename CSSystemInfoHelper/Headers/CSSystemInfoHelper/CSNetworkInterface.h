//
//  CSInterfaceAddress.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 17/06/2021.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSNetworkInterface : NSObject

@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *address;

@property (nonatomic, readonly) sa_family_t family;
@property (nonatomic, readonly, strong) NSString *familyName;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
