//
//  CSSystemInfoHelperTests.m
//  CSSystemInfoHelperTests
//
//  Created by Cătălin Stan on 09/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CSSystemInfoHelper/CSSystemInfoHelper.h>

@interface CSSystemInfoHelperTests : XCTestCase

@end

@implementation CSSystemInfoHelperTests

- (void)test_sharedHelper_ShouldNotBeNil {
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper]);
}

- (void)test_sharedHelper_IsSigleton {
    CSSystemInfoHelper* helper1 = [CSSystemInfoHelper sharedHelper];
    CSSystemInfoHelper* helper2 = [CSSystemInfoHelper sharedHelper];
    XCTAssertEqual(helper1.hash, helper2.hash);
}

- (void)test_AllIPAddresses_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNotNil(helper.AllIPAddresses);
}

- (void)test_AllIPAddresses_ShouldContainAtLeastOneEntry {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertGreaterThan(helper.AllIPAddresses.count, 0);
}

- (void)test_IPAddress_DoesNotThrow {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNoThrow(helper.IPAddress);
}

- (void)test_IPAddress_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNotNil(helper.IPAddress);
}

- (void)test_SystemInfo_DoesNotThow {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNoThrow(helper.systemInfo);
}

- (void)test_SystemInfo_AllKeys_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];

    XCTAssertNotNil(helper.systemInfo[CSSystemInfoSysnameKey], @"The key CSSystemInfoSysnameKey is not pressent");
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoNodenameKey], @"The key CSSystemInfoNodenameKey is not pressent");
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoReleaseKey], @"The key CSSystemInfoReleaseKey is not pressent");
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoVersionKey], @"The key CSSystemInfoVersionKey is not pressent");
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoMachineKey], @"The key CSSystemInfoMachineKey is not pressent");
}

- (void)test_SystemInfo_AllKeys_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];

    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoSysnameKey].length, 0, @"The key CSSystemInfoSysnameKey is empty");
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoNodenameKey].length, 0, @"The key CSSystemInfoNodenameKey is empty");
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoReleaseKey].length, 0, @"The key CSSystemInfoReleaseKey is empty");
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoVersionKey].length, 0, @"The key CSSystemInfoVersionKey is empty");
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoMachineKey].length, 0, @"The key CSSystemInfoMachineKey is empty");
}

- (void)test_SystemInfoString_DoesNotThrow {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNoThrow(helper.systemInfoString);
}

- (void)test_SystemInfoString_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNotNil(helper.systemInfoString);
}

- (void)test_SystemInfoString_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertGreaterThan(helper.systemInfoString.length, 0);
}

- (void)test_SystemVersionString_DoesNotThrow {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNoThrow(helper.systemVersionString);
}

- (void)test_SystemVersionString_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNotNil(helper.systemVersionString);
}

- (void)test_SystemVersionString_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertGreaterThan(helper.systemVersionString.length, 0);
}

- (void)test_MemoryUsage_DoesNotThrow {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNoThrow(helper.memoryUsage);
}

- (void)test_MemoryUsage_IsGreaterThan0 {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertGreaterThan(helper.memoryUsage, 0);
}

- (void)test_MemoryUsageString_DoesNotThrow {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNoThrow(helper.memoryUsageString);
}

- (void)test_MemoryUsageString_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNotNil(helper.memoryUsageString);
}

- (void)test_MemoryUsageString_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertGreaterThan(helper.memoryUsageString.length, 0);
}

- (void)test_PlatformUUID_DoesNotThrow {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNoThrow(helper.platformUUID);
}

- (void)test_PlatformUUID_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertNotNil(helper.platformUUID);
}

- (void)test_PlatformUUID_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [CSSystemInfoHelper new];
    XCTAssertGreaterThan(helper.platformUUID.length, 0);
}

@end
