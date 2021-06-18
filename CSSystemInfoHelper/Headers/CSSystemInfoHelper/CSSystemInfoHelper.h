//
//  CSSystemInfoHelper.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 05/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double CSSystemInfoHelperVersionNumber;
FOUNDATION_EXPORT const unsigned char CSSystemInfoHelperVersionString[];

#import <CSSystemInfoHelper/CSNetworkInterface.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * CSSystemInfoKey NS_TYPED_EXTENSIBLE_ENUM;

/// Name of the operating system implementation.
FOUNDATION_EXPORT CSSystemInfoKey const CSSystemInfoKeySysname;
/// Network name of this machine.
FOUNDATION_EXPORT CSSystemInfoKey const CSSystemInfoKeyNodename;
/// Release level of the operating system.
FOUNDATION_EXPORT CSSystemInfoKey const CSSystemInfoKeyRelease;
/// Version level of the operating system.
FOUNDATION_EXPORT CSSystemInfoKey const CSSystemInfoKeyVersion;
/// Machine hardware platform.
FOUNDATION_EXPORT CSSystemInfoKey const CSSystemInfoKeyMachine;

/// Constant returned when no IP address could be deternimed
FOUNDATION_EXPORT NSString * const CSSystemInfoHelperIPAddressNone DEPRECATED_ATTRIBUTE;

/// The CSSystemInfoHelper class provides easy-access to some useful system
/// information that would otherwise require some more elaborate code.
@interface CSSystemInfoHelper : NSObject

/// @name Accessing the shared helper instance

/// The shared helper instance
@property (class, nonatomic, readonly) CSSystemInfoHelper *sharedHelper;

/// @name Getting IP Addresses

/// An array of @c CSNetworkInterface objects representing all the IPv4 and IPv6
/// interfaces configured, in the order of discovery, as returned by @c getifaddrs(3)
/// @note Check the @c getifaddrs(3) manual page for more information.
@property (nonatomic, readonly, strong, nullable) NSArray<CSNetworkInterface *> *networkInterfaces;

/// @name Getting @c uname System Information

/// A dictionary containing the results of the @c uname(3) call.
@property (nonatomic, readonly, strong) NSDictionary<CSSystemInfoKey, NSString *> *systemInfo;

/// A concatenated string representation of all the values in `systemInfo`, in
/// the order listed in the @c uname(3) manual page.
@property (nonatomic, readonly, strong) NSString *systemInfoString;

/// A concatenated string representation of the OS version keys from
/// @c -systemInfo, in the following order: @c CSSystemInfoKeySysname,
/// @c CSSystemInfoKeyRelease, @c CSSystemInfoKeyMachine, separated by space.
@property (nonatomic, readonly, strong) NSString *systemVersionString;

/// @name Getting Memory Usage

/// Gets the resident memory size of the process, as reported by @c task_info
/// @see https://www.gnu.org/software/hurd/gnumach-doc/Task-Information.html
@property (nonatomic, readonly) vm_size_t memoryUsage;

/// A human-readable, formatted byte count string. from the value returned by
/// @c -memoryUsage
@property (nonatomic, readonly, copy) NSString *memoryUsageString;

/// Gets the physical memory footprint size of the process, as reported by
/// @c task_info
// @see https://www.gnu.org/software/hurd/gnumach-doc/Task-Information.html
@property (nonatomic, readonly) vm_size_t memoryPhysicalFootprint;

/// A human-readable, formatted byte count string. from the value returned by
/// @c -memoryPhysicalFootprint
@property (nonatomic, readonly, copy) NSString *memoryPhysicalFootprintString;

/// @name UUID of the current device

/// Get the UUID of the current device
/// @note This API is only available on macOS
@property (nonatomic, readonly, strong) NSString * platformUUID API_UNAVAILABLE(ios, tvos, watchos);

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

#pragma mark - Deprecated

/// @name Deprecated

/// A dictionary where the keys are interface names and the values are
/// the IP addresses associated with those interfaces.
/// @note Check the @c getifaddrs(3) manual page for more information.
@property (nonatomic, readonly, strong) NSDictionary<NSString *, NSString *> * AllIPAddresses DEPRECATED_MSG_ATTRIBUTE("Use 'networkInterfaces' instead.");

/// The IP Address of "en0".
/// @note This is a convenience method for `AllIPAddresses[@"en0"]`.
@property (nonatomic, readonly, strong) NSString *IPAddress DEPRECATED_MSG_ATTRIBUTE("Use 'networkInterfaces' instead.");

@end

NS_ASSUME_NONNULL_END
