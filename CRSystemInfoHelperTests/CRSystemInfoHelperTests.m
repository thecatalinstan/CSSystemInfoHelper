//
//  CRSystemInfoHelperTests.m
//  CRSystemInfoHelperTests
//
//  Created by Cătălin Stan on 09/04/16.
//  Copyright © 2016 Criollo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CRSystemInfoHelper.h"

@interface CRSystemInfoHelperTests : XCTestCase

@end

@implementation CRSystemInfoHelperTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSharedHelper {
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper]);
}

- (void)testSharedHelperSigleton {
    CRSystemInfoHelper* helper1 = [CRSystemInfoHelper sharedHelper];
    CRSystemInfoHelper* helper2 = [CRSystemInfoHelper sharedHelper];
    XCTAssertEqual(helper1.hash, helper2.hash);
}

- (void)testAllIPAddresses {
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].AllIPAddresses);
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].AllIPAddresses.count, 0);
}

- (void)testIPAddress {
    XCTAssertNoThrow([CRSystemInfoHelper sharedHelper].IPAddress);
}

- (void)testSystemInfo {
    XCTAssertNoThrow([CRSystemInfoHelper sharedHelper].systemInfo);

    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoSysnameKey], @"The key CRSystemInfoSysnameKey is not pressent");
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoNodenameKey], @"The key CRSystemInfoNodenameKey is not pressent");
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoReleaseKey], @"The key CRSystemInfoReleaseKey is not pressent");
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoVersionKey], @"The key CRSystemInfoVersionKey is not pressent");
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoMachineKey], @"The key CRSystemInfoMachineKey is not pressent");

    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoSysnameKey].length, 0, @"The key CRSystemInfoSysnameKey is empty");
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoNodenameKey].length, 0, @"The key CRSystemInfoNodenameKey is empty");
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoReleaseKey].length, 0, @"The key CRSystemInfoReleaseKey is empty");
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoVersionKey].length, 0, @"The key CRSystemInfoVersionKey is empty");
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].systemInfo[CRSystemInfoMachineKey].length, 0, @"The key CRSystemInfoMachineKey is empty");
}

- (void)testSystemInfoString {
    XCTAssertNoThrow([CRSystemInfoHelper sharedHelper].systemInfoString);
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].systemInfoString);
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].systemInfoString.length, 0);
}

- (void)testSystemVersionString {
    XCTAssertNoThrow([CRSystemInfoHelper sharedHelper].systemVersionString);
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].systemVersionString);
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].systemVersionString.length, 0);
}

- (void)testMemoryUsage {
    XCTAssertNoThrow([CRSystemInfoHelper sharedHelper].memoryUsage);
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].memoryUsage, 0);
}

- (void)testMemoryUsageString {
    XCTAssertNoThrow([CRSystemInfoHelper sharedHelper].memoryUsageString);
    XCTAssertNotNil([CRSystemInfoHelper sharedHelper].memoryUsageString);
    XCTAssertGreaterThan([CRSystemInfoHelper sharedHelper].memoryUsageString.length, 0);
}

@end
