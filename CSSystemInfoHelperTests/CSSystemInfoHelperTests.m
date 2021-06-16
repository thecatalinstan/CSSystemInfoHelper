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

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSharedHelper {
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper]);
}

- (void)testSharedHelperSigleton {
    CSSystemInfoHelper* helper1 = [CSSystemInfoHelper sharedHelper];
    CSSystemInfoHelper* helper2 = [CSSystemInfoHelper sharedHelper];
    XCTAssertEqual(helper1.hash, helper2.hash);
}

- (void)testAllIPAddresses {
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].AllIPAddresses);
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].AllIPAddresses.count, 0);
}

- (void)testIPAddress {
    XCTAssertNoThrow([CSSystemInfoHelper sharedHelper].IPAddress);
}

- (void)testSystemInfo {
    XCTAssertNoThrow([CSSystemInfoHelper sharedHelper].systemInfo);

    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoSysnameKey], @"The key CSSystemInfoSysnameKey is not pressent");
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoNodenameKey], @"The key CSSystemInfoNodenameKey is not pressent");
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoReleaseKey], @"The key CSSystemInfoReleaseKey is not pressent");
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoVersionKey], @"The key CSSystemInfoVersionKey is not pressent");
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoMachineKey], @"The key CSSystemInfoMachineKey is not pressent");

    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoSysnameKey].length, 0, @"The key CSSystemInfoSysnameKey is empty");
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoNodenameKey].length, 0, @"The key CSSystemInfoNodenameKey is empty");
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoReleaseKey].length, 0, @"The key CSSystemInfoReleaseKey is empty");
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoVersionKey].length, 0, @"The key CSSystemInfoVersionKey is empty");
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].systemInfo[CSSystemInfoMachineKey].length, 0, @"The key CSSystemInfoMachineKey is empty");
}

- (void)testSystemInfoString {
    XCTAssertNoThrow([CSSystemInfoHelper sharedHelper].systemInfoString);
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].systemInfoString);
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].systemInfoString.length, 0);
}

- (void)testSystemVersionString {
    XCTAssertNoThrow([CSSystemInfoHelper sharedHelper].systemVersionString);
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].systemVersionString);
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].systemVersionString.length, 0);
}

- (void)testMemoryUsage {
    XCTAssertNoThrow([CSSystemInfoHelper sharedHelper].memoryUsage);
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].memoryUsage, 0);
}

- (void)testMemoryUsageString {
    XCTAssertNoThrow([CSSystemInfoHelper sharedHelper].memoryUsageString);
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].memoryUsageString);
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].memoryUsageString.length, 0);
}

- (void)testPlatformUUID {
    XCTAssertNoThrow([CSSystemInfoHelper sharedHelper].platformUUID);
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper].platformUUID);
    XCTAssertGreaterThan([CSSystemInfoHelper sharedHelper].platformUUID.length, 0);
}

@end
