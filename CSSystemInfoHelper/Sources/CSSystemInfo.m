//
//  CSSystemInfo.m
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import <CSSystemInfoHelper/CSSystemInfo.h>
#import "CSSystemInfo+Internal.h"

@implementation CSSystemInfo

- (instancetype)initWithUtsnameStruct:(struct utsname *)utsnameStruct {
    return [self initWithSysName:@(utsnameStruct->sysname)
                        nodeName:@(utsnameStruct->nodename)
                    releaseLevel:@(utsnameStruct->release)
                    versionLevel:@(utsnameStruct->version)
                         machine:@(utsnameStruct->machine)];
}

- (instancetype)initWithSysName:(NSString *)sysName
                       nodeName:(NSString *)nodeName
                   releaseLevel:(NSString *)releaseLevel
                   versionLevel:(NSString *)versionLevel
                        machine:(NSString *)machine {
    self = [super init];
    if (self) {
        _sysName = sysName;
        _nodeName = nodeName;
        _releaseLevel = releaseLevel;
        _versionLevel = versionLevel;
        _machine = machine;
        
        _string = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", _sysName, _nodeName, _releaseLevel, _versionLevel, _machine];
        _versionString = [NSString stringWithFormat:@"%@ %@ %@", _sysName, _releaseLevel, _machine];
    }
    return self;
}

@end
