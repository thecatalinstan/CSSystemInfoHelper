//
//  CSSystemInfoProviderTests.m
//  CSSystemInfoHelperTests
//
//  Created by Cătălin Stan on 21/06/2021.
//

#import <XCTest/XCTest.h>

#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

#import "CSSystemInfoProvider.h"
#import "CSNetworkInterface+Internal.h"

@interface CSSystemInfoProviderTests : XCTestCase

@end

@implementation CSSystemInfoProviderTests

- (void)test_interfaceAddressWithAddr_withEmptyAddr_shouldReturnNil {
    struct sockaddr ifa_addr = {0};
    struct ifaddrs addr = {.ifa_addr = &ifa_addr};
    
    XCTAssertNil([CSSystemInfoProvider.new interfaceAddressWithAddr:&addr error:nil]);
}

- (void)test_interfaceAddressWithAddr_withEmptyAddr_shouldReturnUnsupportedAddressError {
    struct sockaddr ifa_addr = {0};
    struct ifaddrs addr = {.ifa_addr = &ifa_addr};
    
    NSError *error;
    (void)[CSSystemInfoProvider.new interfaceAddressWithAddr:&addr error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertEqual(NSPOSIXErrorDomain, error.domain);
    XCTAssertEqual(EAFNOSUPPORT, error.code);
}

- (void)test_interfaceAddressWithAddr_withIPv4Addr_shouldNotReturnNil {
    const char *ifa_name = [NSUUID.UUID.UUIDString cStringUsingEncoding:NSASCIIStringEncoding];
    struct sockaddr_in ifa_addr = {.sin_family = AF_INET, .sin_addr = (struct in_addr) {arc4random()}};
    struct ifaddrs addr = {
        .ifa_name = (char *)ifa_name,
        .ifa_addr = (struct sockaddr *)&ifa_addr,
    };
    
    XCTAssertNotNil([CSSystemInfoProvider.new interfaceAddressWithAddr:&addr error:nil]);
}

- (void)test_interfaceAddressWithAddr_withIPv4Addr_shouldNotReturnError {
    const char *ifa_name = [NSUUID.UUID.UUIDString cStringUsingEncoding:NSASCIIStringEncoding];
    struct sockaddr_in ifa_addr = {.sin_family = AF_INET, .sin_addr = (struct in_addr) {arc4random()}};
    struct ifaddrs addr = {
        .ifa_name = (char *)ifa_name,
        .ifa_addr = (struct sockaddr *)&ifa_addr,
    };
    
    NSError *error;
    (void)[CSSystemInfoProvider.new interfaceAddressWithAddr:&addr error:&error];
    
    XCTAssertNil(error);
}

- (void)test_interfaceAddressWithAddr_withIPv4Addr_shouldNotReturnInterfaceWithEqualValues {
    NSString *expectedName = NSUUID.UUID.UUIDString;
    const char *ifa_name = [expectedName cStringUsingEncoding:NSASCIIStringEncoding];
    struct sockaddr_in ifa_addr = {.sin_family = AF_INET, .sin_addr = (struct in_addr) {arc4random()}};
    struct ifaddrs addr = {
        .ifa_name = (char *)ifa_name,
        .ifa_addr = (struct sockaddr *)&ifa_addr,
    };
    char buf[INET_ADDRSTRLEN];
    XCTAssertTrue(NULL != inet_ntop(ifa_addr.sin_family, &(ifa_addr.sin_addr), buf, INET_ADDRSTRLEN));
    NSString *expectedAddress = @(buf);
    
    CSNetworkInterface *interface = [CSSystemInfoProvider.new interfaceAddressWithAddr:&addr error:nil];
    
    XCTAssertEqualObjects(expectedName, interface.name);
    XCTAssertEqualObjects(expectedAddress, interface.address);
    XCTAssertEqual(AF_INET, interface.family);
}

- (void)test_interfaceAddressWithAddr_withIPv6Addr_shouldNotReturnNil {
    const char *ifa_name = [NSUUID.UUID.UUIDString cStringUsingEncoding:NSASCIIStringEncoding];
    struct sockaddr_in6 ifa_addr = {
        .sin6_family = AF_INET6,
        .sin6_addr = {{.__u6_addr32 = { arc4random(),arc4random(),arc4random(),arc4random()}}}
    };
    struct ifaddrs addr = {
        .ifa_name = (char *)ifa_name,
        .ifa_addr = (struct sockaddr *)&ifa_addr,
    };
    
    XCTAssertNotNil([CSSystemInfoProvider.new interfaceAddressWithAddr:&addr error:nil]);
}

- (void)test_interfaceAddressWithAddr_withIPv6Addr_shouldNotReturnError {
    const char *ifa_name = [NSUUID.UUID.UUIDString cStringUsingEncoding:NSASCIIStringEncoding];
    struct sockaddr_in6 ifa_addr = {
        .sin6_family = AF_INET6,
        .sin6_addr = {{.__u6_addr32 = { arc4random(),arc4random(),arc4random(),arc4random()}}}
    };
    struct ifaddrs addr = {
        .ifa_name = (char *)ifa_name,
        .ifa_addr = (struct sockaddr *)&ifa_addr,
    };
    
    NSError *error;
    (void)[CSSystemInfoProvider.new interfaceAddressWithAddr:&addr error:&error];
    
    XCTAssertNil(error);
}

- (void)test_interfaceAddressWithAddr_withIPv6Addr_shouldNotReturnInterfaceWithEqualValues {
    NSString *expectedName = NSUUID.UUID.UUIDString;
    const char *ifa_name = [expectedName cStringUsingEncoding:NSASCIIStringEncoding];
    struct sockaddr_in6 ifa_addr = {
        .sin6_family = AF_INET6,
        .sin6_addr = {{.__u6_addr32 = { arc4random(),arc4random(),arc4random(),arc4random()}}}
    };
    struct ifaddrs addr = {
        .ifa_name = (char *)ifa_name,
        .ifa_addr = (struct sockaddr *)&ifa_addr,
    };
    char buf[INET6_ADDRSTRLEN];
    XCTAssertTrue(NULL != inet_ntop(ifa_addr.sin6_family, &(ifa_addr.sin6_addr), buf, INET6_ADDRSTRLEN));
    NSString *expectedAddress = @(buf);
    
    CSNetworkInterface *interface = [CSSystemInfoProvider.new interfaceAddressWithAddr:&addr error:nil];
    
    XCTAssertEqualObjects(expectedName, interface.name);
    XCTAssertEqualObjects(expectedAddress, interface.address);
    XCTAssertEqual(AF_INET6, interface.family);
}

@end
