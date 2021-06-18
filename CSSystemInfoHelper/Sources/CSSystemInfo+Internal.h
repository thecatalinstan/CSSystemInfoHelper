//
//  CSSystemInfo+Internal.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import <CSSystemInfoHelper/CSSystemInfo.h>

#import <sys/utsname.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSSystemInfo ()

- (instancetype)initWithSysName:(NSString *)sysName
                       nodeName:(NSString *)nodeName
                   releaseLevel:(NSString *)releaseLevel
                   versionLevel:(NSString *)versionLevel
                        machine:(NSString *)machine
NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithUtsnameStruct:(struct utsname *)utsnameStruct;

@end

NS_ASSUME_NONNULL_END
