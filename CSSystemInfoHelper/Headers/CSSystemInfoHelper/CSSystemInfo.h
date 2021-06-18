//
//  CSSystemInfo.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A container class for the @c utsname struct.
/// See the @c uname(3) manual page for more info.
@interface CSSystemInfo : NSObject

/// Name of the operating system implementation.
@property (nonatomic, readonly) NSString *sysName;

/// Network name of this machine.
@property (nonatomic, readonly) NSString *nodeName;

/// Release level of the operating system.
@property (nonatomic, readonly) NSString *releaseLevel;

/// Version level of the operating system.
@property (nonatomic, readonly) NSString *versionLevel;

/// Machine hardware platform.
@property (nonatomic, readonly) NSString *machine;

/// A concatenated string representation of all the properties in the order
/// listed in the @c uname(1) manual page.
@property (nonatomic, readonly, strong) NSString *string;

/// A concatenated string representation of the @c sysName, @c releaseLevel,
/// properties @c machine, separated by space.
@property (nonatomic, readonly, strong) NSString *versionString;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
