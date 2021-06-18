//
//  CSSystemInfoHelperDeprecatedTests.m
//  CSSystemInfoHelperTests
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import <XCTest/XCTest.h>

#import <sys/socket.h>

#import "CSSystemInfoProviderMock.h"
#import "CSNetworkInterface+Internal.h"
#import "CSSystemInfoHelper+Internal.h"

@interface CSSystemInfoHelperDeprecatedTests : XCTestCase

@property (nonatomic, readonly) NSArray<CSNetworkInterface *> *randomIPv4Interfaces;
@property (nonatomic, readonly) NSArray<CSNetworkInterface *> *randomIPv6Interfaces;
@property (nonatomic, readonly) NSArray<CSNetworkInterface *> *randomInterfaces;

@property (nonatomic, readonly) CSNetworkInterface *defaultIPv4NetworkInterface;
@property (nonatomic, readonly) CSNetworkInterface *randomIPv4Interface;

@end

@implementation CSSystemInfoHelperDeprecatedTests


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"

- (void)test_AllIPAddresses_withFailingSystemInfoProvider_ShouldNotBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.AllIPAddresses);
}

- (void)test_AllIPAddresses_withFailingSystemInfoProvider_ShouldContainZeroObjects {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(0, helper.AllIPAddresses.count);
}

- (void)test_AllIPAddresses_withNoNetworkInterfaces_ShouldNotBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:NSArray.array];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];

    XCTAssertNotNil(helper.AllIPAddresses);
}

- (void)test_AllIPAddresses_withNoNetworkInterfaces_ShouldContainZeroObjects {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:NSArray.array];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(0, helper.AllIPAddresses.count);
}

- (void)test_AllIPAddresses_withNoIPv4NetworkInterfaces_ShouldNotBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:self.randomIPv6Interfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];

    XCTAssertNotNil(helper.AllIPAddresses);
}

- (void)test_AllIPAddresses_withNoIPv4NetworkInterfaces_ShouldContainZeroObjects {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:self.randomIPv6Interfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];

    XCTAssertEqual(0, helper.AllIPAddresses.count);
}

- (void)test_AllIPAddresses_withIPv4NetworkInterfaces_ShouldContainAllInterfaces {
    NSArray<CSNetworkInterface *> *expectedInterfaces = self.randomIPv4Interfaces;
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:expectedInterfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];

    NSDictionary<NSString *, NSString *> *result = helper.AllIPAddresses;
    for (CSNetworkInterface *interface in expectedInterfaces) {
        XCTAssertNotNil(result[interface.name]);
        XCTAssertEqual(result[interface.name], interface.address);
    }
}

- (void)test_AllIPAddresses_withIPv4NetworkInterfaces_ShouldContainSameNumberOfInterfaces {
    NSArray<CSNetworkInterface *> *expectedInterfaces = self.randomIPv4Interfaces;
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:expectedInterfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];

    XCTAssertEqual(expectedInterfaces.count, helper.AllIPAddresses.count);
}

- (void)test_AllIPAddresses_withMixedNetworkInterfaces_ShouldContainAllIPv4Interfaces {
    NSArray<CSNetworkInterface *> *interfaces = self.randomInterfaces;
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:interfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    NSArray<CSNetworkInterface *> *expectedInterfaces = [interfaces filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(CSNetworkInterface *_Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject.family == AF_INET;
    }]];
    
    NSDictionary<NSString *, NSString *> *result = helper.AllIPAddresses;
    for (CSNetworkInterface *interface in expectedInterfaces) {
        XCTAssertNotNil(result[interface.name]);
        XCTAssertEqual(result[interface.name], interface.address);
    }
}

- (void)test_AllIPAddresses_withMixedNetworkInterfaces_ShouldContainSameNumberOfInterfaces {
    NSArray<CSNetworkInterface *> *interfaces = self.randomInterfaces;
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:interfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    NSArray<CSNetworkInterface *> *expectedInterfaces = [interfaces filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(CSNetworkInterface *_Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject.family == AF_INET;
    }]];
    
    XCTAssertEqual(expectedInterfaces.count, helper.AllIPAddresses.count);
}


- (void)test_IPAddress_withFailingSystemInfoProvider_ShouldNotBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.IPAddress);
}

- (void)test_IPAddress_withFailingSystemInfoProvider_ShouldReturnIPAddressNone {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock failingProviderWithError:nil];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.IPAddress, CSSystemInfoHelperIPAddressNone);
}

- (void)test_IPAddress_withNoNetworkInterfaces_ShouldNotBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:@[]];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.IPAddress);
}

- (void)test_IPAddress_withNoNetworkInterfaces_ShouldReturnIPAddressNone {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:@[]];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.IPAddress, CSSystemInfoHelperIPAddressNone);
}

- (void)test_IPAddress_withNoIPv4NetworkInterfaces_ShouldNotBeNil {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:self.randomIPv6Interfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertNotNil(helper.IPAddress);
}

- (void)test_IPAddress_withNoIPv4NetworkInterfaces_ShouldReturnIPAddressNone {
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:self.randomIPv6Interfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.IPAddress, CSSystemInfoHelperIPAddressNone);
}

- (void)test_IPAddress_withDefaultNetworkInterface_ShouldReturnDefaultInterface {
    CSNetworkInterface *expectedInterface = self.defaultIPv4NetworkInterface;
    NSArray<CSNetworkInterface *> *interfaces = self.randomInterfaces;
    interfaces = [interfaces arrayByAddingObject:expectedInterface];
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:interfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.IPAddress, expectedInterface.address);
}

- (void)test_IPAddress_withNoDefaultNetworkInterface_ShouldReturnFirstInterface {
    NSArray<CSNetworkInterface *> *interfaces = self.randomIPv4Interfaces;
    CSSystemInfoProviderMock *provider = [CSSystemInfoProviderMock succeedingProviderWithNetworkInterfaces:interfaces];
    CSSystemInfoHelper *helper = [[CSSystemInfoHelper alloc] initWithSystemInfoProvider:provider];
    
    XCTAssertEqual(helper.IPAddress, interfaces.firstObject.address);
}

#pragma mark - Private Helpers

- (NSArray<CSNetworkInterface *> *)randomInterfaces:(sa_family_t)family {
    NSUInteger count = 16;
    NSMutableArray<CSNetworkInterface *> *result = [NSMutableArray arrayWithCapacity:count];
    for(NSUInteger i = 0; i < count; i++) {
        [result addObject:[self randomInterface:family]];
    }
    return result;
}
- (NSArray<CSNetworkInterface *> *)randomInterfaces {
    return [self randomInterfaces:AF_UNSPEC];
}
- (NSArray<CSNetworkInterface *> *)randomIPv6Interfaces {
    return [self randomInterfaces:AF_INET6];
}
- (NSArray<CSNetworkInterface *> *)randomIPv4Interfaces {
    return [self randomInterfaces:AF_INET];
}

- (CSNetworkInterface *)defaultIPv4NetworkInterface {
    return [[CSNetworkInterface alloc] initWithName:CSSystemInfoHelperDefaultInterface address:NSUUID.UUID.UUIDString family:AF_INET];
}

- (CSNetworkInterface *)randomIPv4Interface {
    return [self randomInterface:AF_INET];
}

- (CSNetworkInterface *)randomInterface:(sa_family_t)family {
    sa_family_t f = family != AF_UNSPEC ? family : (arc4random() % 2 == 0 ? AF_INET : AF_INET6);
    return [[CSNetworkInterface alloc] initWithName:NSUUID.UUID.UUIDString address:NSUUID.UUID.UUIDString family:f];
}

#pragma clang diagnostic pop
@end
