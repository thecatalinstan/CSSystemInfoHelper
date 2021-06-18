//
//  CSSystemInfoProvider.m
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import "CSSystemInfoProvider.h"

#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>

#import "CSNetworkInterface+Internal.h"
#import "Errors.h"

@implementation CSSystemInfoProvider

+ (CSSystemInfoProvider *)sharedProvider {
    static CSSystemInfoProvider *sharedProvider;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProvider = [CSSystemInfoProvider new];
    });
    return sharedProvider;
}

- (CSNetworkInterface *)interfaceAddressWithAddr:(struct ifaddrs *)addr error:(NSError *__autoreleasing  _Nullable *)error {
    struct sockaddr *ifa_addr = addr->ifa_addr;
    sa_family_t family = ifa_addr->sa_family;
    socklen_t len = INET_ADDRSTRLEN;
    void *src = &(((struct sockaddr_in *)ifa_addr)->sin_addr);
    if (family != AF_INET) {
        len = INET6_ADDRSTRLEN;
        src = &(((struct sockaddr_in6 *)ifa_addr)->sin6_addr);
    }
    
    char buf[len / sizeof(char)];
    if (!inet_ntop(family, src, buf, len)) {
        if (error) {
            NSString *reason;
            if (errno == EAFNOSUPPORT) {
                reason = [NSString stringWithFormat:@"Interface '%s' has unsupported address family %d", addr->ifa_name, family];
            }
            *error = NSPosixError(errno, reason, nil);
        }
        return nil;
    }
    
    return [[CSNetworkInterface alloc] initWithName:@(addr->ifa_name) address:@(buf) family:family];
}

#pragma mark - CSSystemInfoProviderProtocol

- (NSArray<CSNetworkInterface *> *)queryNetworkInterfaces:(NSError *__autoreleasing *)error {
    NSMutableArray<CSNetworkInterface *> *result = [NSMutableArray arrayWithCapacity:6]; // lo0, en0, en1 (IPv4, IPv6)
    struct ifaddrs *interfaces = NULL;
    if (getifaddrs(&interfaces)) {
        if (error) {
            *error = NSPosixError(errno, nil, nil);
        }
        return nil;
    }
    
    struct ifaddrs *addr = interfaces;
    do {
        NSError *err;
        CSNetworkInterface *address;
        if (!(address = [self interfaceAddressWithAddr:addr error:&err])) {
            if (err.code != EAFNOSUPPORT || err.domain != NSPOSIXErrorDomain) {
                freeifaddrs(interfaces);
                return nil;
            }
            
            continue;
        }
        
        [result addObject:address];
    } while ((addr = addr->ifa_next));
    
    freeifaddrs(interfaces);
    return result;
}

@end
