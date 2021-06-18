//
//  CSInterfaceAddress.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 17/06/2021.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>

NS_ASSUME_NONNULL_BEGIN

/// A container class for the attributes of a network interface as understood by
/// @c getaddrinfo(3) and related APIs
@interface CSNetworkInterface : NSObject

/// The name of the interface
@property (nonatomic, readonly, strong) NSString *name;

/// A string representation of the address (IPv4 or IPv6) of the interface
@property (nonatomic, readonly, strong) NSString *address;

/// The address family of the address, either @c AF_INET or @c AF_INET6, for
/// IPv4 or IPv6 respectively
@property (nonatomic, readonly) sa_family_t family;

/// A string representation of the address family
@property (nonatomic, readonly, strong) NSString *familyName;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
