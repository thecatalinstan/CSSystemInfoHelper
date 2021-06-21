//
//  CSSystemInfoTests.m
//  CSSystemInfoHelperTests
//
//  Created by Cătălin Stan on 21/06/2021.
//

#import <XCTest/XCTest.h>

#import "CSSystemInfo+Internal.h"

@interface CSSystemInfoTests : XCTestCase

@property (nonatomic, readonly) struct utsname randomUtsnameStruct;
@property (nonatomic, readonly) struct utsname emptyUtsnameStruct;

@end

@implementation CSSystemInfoTests

- (void)test_initWithStruct_withNonEmptyStruct_stringShouldNotBeNil {
    struct utsname utsnameStruct = self.randomUtsnameStruct;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithUtsnameStruct:&utsnameStruct];
    
    XCTAssertNotNil(info.string);
}

- (void)test_initWithStruct_withNonEmptyStruct_stringShouldContainConcatenatedComponents {
    struct utsname utsnameStruct = self.randomUtsnameStruct;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithUtsnameStruct:&utsnameStruct];
    NSArray<NSString *> *components = [info.string componentsSeparatedByString:@" "];
    
    XCTAssertEqual(0, strcmp(utsnameStruct.sysname, components[0].UTF8String));
    XCTAssertEqual(0, strcmp(utsnameStruct.nodename, components[1].UTF8String));
    XCTAssertEqual(0, strcmp(utsnameStruct.release, components[2].UTF8String));
    XCTAssertEqual(0, strcmp(utsnameStruct.version, components[3].UTF8String));
    XCTAssertEqual(0, strcmp(utsnameStruct.machine, components[4].UTF8String));
}

- (void)test_initWithStruct_withEmptyStruct_stringShouldNotBeNil {
    struct utsname utsnameStruct = self.emptyUtsnameStruct;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithUtsnameStruct:&utsnameStruct];
    
    XCTAssertNotNil(info.string);
}

- (void)test_initWithStruct_withEmptyStruct_stringShouldBeEmpty {
    struct utsname utsnameStruct = self.emptyUtsnameStruct;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithUtsnameStruct:&utsnameStruct];
    
    XCTAssertEqual(0, info.string.length);
}

- (void)test_initWithStrings_withNonEmptyStrings_stringShouldNotBeNil {
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithSysName:NSUUID.UUID.UUIDString
                                                      nodeName:NSUUID.UUID.UUIDString
                                                  releaseLevel:NSUUID.UUID.UUIDString
                                                  versionLevel:NSUUID.UUID.UUIDString
                                                       machine:NSUUID.UUID.UUIDString];
    
    XCTAssertNotNil(info.string);
}

- (void)test_initWithStrings_withNonEmptyStrings_stringShouldContainConcatenatedComponents {
    NSString *sysName = NSUUID.UUID.UUIDString;
    NSString *nodeName = NSUUID.UUID.UUIDString;
    NSString *releaseLevel = NSUUID.UUID.UUIDString;
    NSString *versionLevel = NSUUID.UUID.UUIDString;
    NSString *machine = NSUUID.UUID.UUIDString;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithSysName:sysName
                                                      nodeName:nodeName
                                                  releaseLevel:releaseLevel
                                                  versionLevel:versionLevel
                                                       machine:machine];
    NSArray<NSString *> *components = [info.string componentsSeparatedByString:@" "];
    
    XCTAssertEqualObjects(sysName, components[0]);
    XCTAssertEqualObjects(nodeName, components[1]);
    XCTAssertEqualObjects(releaseLevel, components[2]);
    XCTAssertEqualObjects(versionLevel, components[3]);
    XCTAssertEqualObjects(machine, components[4]);
}

- (void)test_initWithStrings_withEmptyStrings_stringShouldNotBeNil {
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithSysName:NSString.string
                                                      nodeName:NSString.string
                                                  releaseLevel:NSString.string
                                                  versionLevel:NSString.string
                                                       machine:NSString.string];
    
    XCTAssertNotNil(info.string);
}

- (void)test_initWithStrings_withEmptyStrings_stringShouldBeEmpty {
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithSysName:NSString.string
                                                      nodeName:NSString.string
                                                  releaseLevel:NSString.string
                                                  versionLevel:NSString.string
                                                       machine:NSString.string];
    
    XCTAssertEqual(0, info.string.length);
}

- (void)test_initWithStruct_withNonEmptyStruct_versionStringShouldNotBeNil {
    struct utsname utsnameStruct = self.randomUtsnameStruct;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithUtsnameStruct:&utsnameStruct];
    
    XCTAssertNotNil(info.versionString);
}

- (void)test_initWithStruct_withNonEmptyStruct_versionStringShouldContainConcatenatedComponents {
    struct utsname utsnameStruct = self.randomUtsnameStruct;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithUtsnameStruct:&utsnameStruct];
    NSArray<NSString *> *components = [info.versionString componentsSeparatedByString:@" "];
    
    XCTAssertEqual(0, strcmp(utsnameStruct.sysname, components[0].UTF8String));
    XCTAssertEqual(0, strcmp(utsnameStruct.release, components[1].UTF8String));
    XCTAssertEqual(0, strcmp(utsnameStruct.machine, components[2].UTF8String));
}

- (void)test_initWithStruct_withEmptyStruct_versionStringShouldNotBeNil {
    struct utsname utsnameStruct = self.emptyUtsnameStruct;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithUtsnameStruct:&utsnameStruct];
    
    XCTAssertNotNil(info.versionString);
}

- (void)test_initWithStruct_withEmptyStruct_versionStringShouldBeEmpty {
    struct utsname utsnameStruct = self.emptyUtsnameStruct;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithUtsnameStruct:&utsnameStruct];
    
    XCTAssertEqual(0, info.versionString.length);
}

- (void)test_initWithStrings_withNonEmptyStrings_versionStringShouldNotBeNil {
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithSysName:NSUUID.UUID.UUIDString
                                                      nodeName:NSUUID.UUID.UUIDString
                                                  releaseLevel:NSUUID.UUID.UUIDString
                                                  versionLevel:NSUUID.UUID.UUIDString
                                                       machine:NSUUID.UUID.UUIDString];
    
    XCTAssertNotNil(info.versionString);
}

- (void)test_initWithStrings_withNonEmptyStrings_versionStringShouldContainConcatenatedComponents {
    NSString *sysName = NSUUID.UUID.UUIDString;
    NSString *releaseLevel = NSUUID.UUID.UUIDString;
    NSString *machine = NSUUID.UUID.UUIDString;
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithSysName:sysName
                                                      nodeName:NSUUID.UUID.UUIDString
                                                  releaseLevel:releaseLevel
                                                  versionLevel:NSUUID.UUID.UUIDString
                                                       machine:machine];
    NSArray<NSString *> *components = [info.versionString componentsSeparatedByString:@" "];
    
    XCTAssertEqualObjects(sysName, components[0]);
    XCTAssertEqualObjects(releaseLevel, components[1]);
    XCTAssertEqualObjects(machine, components[2]);
}

- (void)test_initWithStrings_withEmptyStrings_versionStringShouldNotBeNil {
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithSysName:NSString.string
                                                      nodeName:NSString.string
                                                  releaseLevel:NSString.string
                                                  versionLevel:NSString.string
                                                       machine:NSString.string];
    
    XCTAssertNotNil(info.versionString);
}

- (void)test_initWithStrings_withEmptyStrings_versionStringShouldBeEmpty {
    CSSystemInfo *info = [[CSSystemInfo alloc] initWithSysName:NSString.string
                                                      nodeName:NSString.string
                                                  releaseLevel:NSString.string
                                                  versionLevel:NSString.string
                                                       machine:NSString.string];
    
    XCTAssertEqual(0, info.versionString.length);
}

#pragma mark - Private Helpers

- (struct utsname)randomUtsnameStruct {
    struct utsname utsnameStruct = {0};
    const char *sysname = NSUUID.UUID.UUIDString.UTF8String;
    memcpy(&utsnameStruct.sysname, sysname, MIN(strlen(sysname), _SYS_NAMELEN));
    const char *nodename = NSUUID.UUID.UUIDString.UTF8String;
    memcpy(&utsnameStruct.nodename, nodename, MIN(strlen(nodename), _SYS_NAMELEN));
    const char *release = NSUUID.UUID.UUIDString.UTF8String;
    memcpy(&utsnameStruct.release, release, MIN(strlen(release), _SYS_NAMELEN));
    const char *version = NSUUID.UUID.UUIDString.UTF8String;
    memcpy(&utsnameStruct.version, version, MIN(strlen(version), _SYS_NAMELEN));
    const char *machine = NSUUID.UUID.UUIDString.UTF8String;
    memcpy(&utsnameStruct.machine, machine, MIN(strlen(machine), _SYS_NAMELEN));
    return utsnameStruct;
}

- (struct utsname)emptyUtsnameStruct {
    return (struct utsname){0};
}

@end
