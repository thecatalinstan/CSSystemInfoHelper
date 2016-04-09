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

- (void)testPerformanceAllIPAddressesFirstRun {
    [self measureBlock:^{
        NSDictionary* addrs = [CRSystemInfoHelper sharedHelper].AllIPAddresses;
        addrs = nil;
    }];
}

- (void)testPerformanceAllIPAddressesSecondRun {
    [self measureBlock:^{
        NSDictionary* addrs = [CRSystemInfoHelper sharedHelper].AllIPAddresses;
        addrs = nil;
    }];
}

- (void)testIPAddress {
    XCTAssertNoThrow([CRSystemInfoHelper sharedHelper].IPAddress);
}

@end
