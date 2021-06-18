//
//  CSSystemInfoHelperTests.m
//  CSSystemInfoHelperTests
//
//  Created by Cătălin Stan on 09/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CSSystemInfoProviderMock.h"
#import "CSSystemInfoHelper+Internal.h"

@interface CSSystemInfoHelperTests : XCTestCase

@end

@implementation CSSystemInfoHelperTests

#pragma mark - sharedHelper

- (void)test_sharedHelper_ShouldNotBeNil {
    XCTAssertNotNil([CSSystemInfoHelper sharedHelper]);
}

- (void)test_sharedHelper_IsSigleton {
    CSSystemInfoHelper* helper1 = [CSSystemInfoHelper sharedHelper];
    CSSystemInfoHelper* helper2 = [CSSystemInfoHelper sharedHelper];
    XCTAssertEqual(helper1.hash, helper2.hash);
}

#pragma mark - networkInterfaces

- (void)test_networkInterfaces_withFailingSystemInfoProvider_ShouldBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNil(helper.networkInterfaces);
}

- (void)test_networkInterfaces_withSucceedingSystemInfoProvider_ShouldReturnProvidedInterfaces {
    NSArray<CSNetworkInterface *> *expectedInterfaces = [NSArray array];
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:expectedInterfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(expectedInterfaces, helper.networkInterfaces);
}

#pragma mark - systemInfo

- (void)test_SystemInfo_DoesNotThow {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertNoThrow(helper.systemInfo);
}

- (void)test_SystemInfo_AllKeys_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoKeySysname], @"The key CSSystemInfoKeySysname is not pressent");
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoKeyNodename], @"The key CSSystemInfoKeyNodename is not pressent");
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoKeyRelease], @"The key CSSystemInfoKeyRelease is not pressent");
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoKeyVersion], @"The key CSSystemInfoKeyVersion is not pressent");
    XCTAssertNotNil(helper.systemInfo[CSSystemInfoKeyMachine], @"The key CSSystemInfoKeyMachine is not pressent");
}

- (void)test_SystemInfo_AllKeys_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoKeySysname].length, 0, @"The key CSSystemInfoKeySysname is empty");
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoKeyNodename].length, 0, @"The key CSSystemInfoKeyNodename is empty");
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoKeyRelease].length, 0, @"The key CSSystemInfoKeyRelease is empty");
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoKeyVersion].length, 0, @"The key CSSystemInfoKeyVersion is empty");
    XCTAssertGreaterThan(helper.systemInfo[CSSystemInfoKeyMachine].length, 0, @"The key CSSystemInfoKeyMachine is empty");
}

#pragma mark - systemInfoString

- (void)test_SystemInfoString_DoesNotThrow {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertNoThrow(helper.systemInfoString);
}

- (void)test_SystemInfoString_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertNotNil(helper.systemInfoString);
}

- (void)test_SystemInfoString_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertGreaterThan(helper.systemInfoString.length, 0);
}

#pragma mark - systemVersionString

- (void)test_SystemVersionString_DoesNotThrow {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertNoThrow(helper.systemVersionString);
}

- (void)test_SystemVersionString_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertNotNil(helper.systemVersionString);
}

- (void)test_SystemVersionString_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertGreaterThan(helper.systemVersionString.length, 0);
}

#pragma mark - memoryUsage

- (void)test_memoryUsage_withFailingSystemInfoProvider_ShouldBeZero {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryUsage, 0);
}

- (void)test_memoryUsage_withFailingSystemInfoProviderThatReturnsValue_ShouldBeZero {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithResidentSize:&residentSize error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryUsage, 0);
}

- (void)test_memoryUsage_withSucceedingSystemInfoProvider_ShouldReturnProvidedValue {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithResidentSize:&residentSize];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryUsage, residentSize);
}

#pragma mark - memoryUsageString

- (void)test_memoryUsageString_withFailingSystemInfoProvider_DoesNotThrow {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNoThrow(helper.memoryUsageString);
}

- (void)test_memoryUsageString_withFailingSystemInfoProvider_ShouldNotBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.memoryUsageString);
}

- (void)test_memoryUsageString_withFailingSystemInfoProvider_ShouldNotBeEmpty {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertGreaterThan(helper.memoryUsageString.length, 0);
}

- (void)test_memoryUsageString_withFailingSystemInfoProvider_ShouldEvnaluateTo0 {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryUsageString.integerValue, 0);
}

- (void)test_memoryUsageString_withFailingSystemInfoProviderThatReturnsValue_DoesNotThrow {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithResidentSize:&residentSize error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNoThrow(helper.memoryUsageString);
}

- (void)test_memoryUsageString_withFailingSystemInfoProviderThatReturnsValue_ShouldNotBeNil {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithResidentSize:&residentSize error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.memoryUsageString);
}

- (void)test_memoryUsageString_withFailingSystemInfoProviderThatReturnsValue_ShouldNotBeEmpty {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithResidentSize:&residentSize error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertGreaterThan(helper.memoryUsageString.length, 0);
}

- (void)test_memoryUsageString_withFailingSystemInfoProviderThatReturnsValue_ShouldEvnaluateTo0 {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithResidentSize:&residentSize error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryUsageString.integerValue, 0);
}

- (void)test_memoryUsageString_withSucceedingSystemInfoProvider_DoesNotThrow {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithResidentSize:&residentSize];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNoThrow(helper.memoryUsageString);
}

- (void)test_memoryUsageString_withSucceedingSystemInfoProvider_ShouldNotBeNil {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithResidentSize:&residentSize];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.memoryUsageString);
}

- (void)test_memoryUsageString_withSucceedingSystemInfoProvider_ShouldNotBeEmpty {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithResidentSize:&residentSize];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertGreaterThan(helper.memoryUsageString.length, 0);
}

- (void)test_memoryUsageString_withSucceedingSystemInfoProvider_ShouldReturnFormattedProvidedValue {
    vm_size_t residentSize = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithResidentSize:&residentSize];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    NSString *expectedString = [helper formatByteCount:residentSize];
    
    XCTAssertEqualObjects(helper.memoryUsageString, expectedString);
}

#pragma mark - memoryPhysicalFootprint

- (void)test_memoryPhysicalFootprint_withFailingSystemInfoProvider_ShouldBeZero {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryPhysicalFootprint, 0);
}

- (void)test_memoryPhysicalFootprint_withFailingSystemInfoProviderThatReturnsValue_ShouldBeZero {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithPhysFootprint:&physFootprint error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryPhysicalFootprint, 0);
}

- (void)test_memoryPhysicalFootprint_withSucceedingSystemInfoProvider_ShouldReturnProvidedValue {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithPhysFootprint:&physFootprint];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryPhysicalFootprint, physFootprint);
}

#pragma mark - memoryPhysicalFootprintString

- (void)test_memoryPhysicalFootprintString_withFailingSystemInfoProvider_DoesNotThrow {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNoThrow(helper.memoryPhysicalFootprintString);
}

- (void)test_memoryPhysicalFootprintString_withFailingSystemInfoProvider_ShouldNotBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.memoryPhysicalFootprintString);
}

- (void)test_memoryPhysicalFootprintString_withFailingSystemInfoProvider_ShouldNotBeEmpty {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertGreaterThan(helper.memoryPhysicalFootprintString.length, 0);
}

- (void)test_memoryPhysicalFootprintString_withFailingSystemInfoProvider_ShouldEvnaluateTo0 {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryPhysicalFootprintString.integerValue, 0);
}

- (void)test_memoryPhysicalFootprintString_withFailingSystemInfoProviderThatReturnsValue_DoesNotThrow {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithPhysFootprint:&physFootprint error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNoThrow(helper.memoryPhysicalFootprintString);
}

- (void)test_memoryPhysicalFootprintString_withFailingSystemInfoProviderThatReturnsValue_ShouldNotBeNil {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithPhysFootprint:&physFootprint error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.memoryPhysicalFootprintString);
}

- (void)test_memoryPhysicalFootprintString_withFailingSystemInfoProviderThatReturnsValue_ShouldNotBeEmpty {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithPhysFootprint:&physFootprint error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertGreaterThan(helper.memoryPhysicalFootprintString.length, 0);
}

- (void)test_memoryPhysicalFootprintString_withFailingSystemInfoProviderThatReturnsValue_ShouldEvnaluateTo0 {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithPhysFootprint:&physFootprint error:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.memoryPhysicalFootprintString.integerValue, 0);
}

- (void)test_memoryPhysicalFootprintString_withSucceedingSystemInfoProvider_DoesNotThrow {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithPhysFootprint:&physFootprint];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNoThrow(helper.memoryPhysicalFootprintString);
}

- (void)test_memoryPhysicalFootprintString_withSucceedingSystemInfoProvider_ShouldNotBeNil {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithPhysFootprint:&physFootprint];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.memoryPhysicalFootprintString);
}

- (void)test_memoryPhysicalFootprintString_withSucceedingSystemInfoProvider_ShouldNotBeEmpty {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithPhysFootprint:&physFootprint];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertGreaterThan(helper.memoryPhysicalFootprintString.length, 0);
}

- (void)test_memoryPhysicalFootprintString_withSucceedingSystemInfoProvider_ShouldReturnFormattedProvidedValue {
    vm_size_t physFootprint = arc4random();
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithPhysFootprint:&physFootprint];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    NSString *expectedString = [helper formatByteCount:physFootprint];
    
    XCTAssertEqualObjects(helper.memoryPhysicalFootprintString, expectedString);
}

#pragma mark - platformUUID

#if TARGET_OS_OSX
- (void)test_PlatformUUID_DoesNotThrow {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertNoThrow(helper.platformUUID);
}

- (void)test_PlatformUUID_ShouldNotBeNil {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertNotNil(helper.platformUUID);
}

- (void)test_PlatformUUID_ShouldNotBeEmpty {
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:nil];
    XCTAssertGreaterThan(helper.platformUUID.length, 0);
}
#endif

@end
