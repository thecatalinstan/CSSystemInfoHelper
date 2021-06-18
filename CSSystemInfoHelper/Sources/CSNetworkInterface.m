//
//  CSInterfaceAddress.m
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 17/06/2021.
//

#import "CSNetworkInterface+Internal.h"

#include <sys/socket.h>

#import "Errors.h"

static const char * const af_consts[AF_MAX] = {
    "AF_UNSPEC",
    "AF_UNIX",
    "AF_INET",
    "AF_IMPLINK",
    "AF_PUP",
    "AF_CHAOS",
    "AF_NS",
    "AF_ISO",
    "AF_ECMA",
    "AF_DATAKIT",
    "AF_CCITT",
    "AF_SNA",
    "AF_DECnet",
    "AF_DLI",
    "AF_LAT",
    "AF_HYLINK",
    "AF_APPLETALK",
    "AF_ROUTE",
    "AF_LINK",
    "pseudo_AF_XTP",
    "AF_COIP",
    "AF_CNT",
    "pseudo_AF_RTIP",
    "AF_IPX",
    "AF_SIP",
    "pseudo_AF_PIP",
    "-",
    "AF_NDRV",
    "AF_ISDN",
    "pseudo_AF_KEY",
    "AF_INET6",
    "AF_NATM",
    "AF_SYSTEM",
    "AF_NETBIOS",
    "AF_PPP",
    "AF_HDRCMPLT",
    "AF_RESERVED_36",
    "AF_IEEE80211",
    "-",
    "AF_UTUN",
    "AF_VSOCK",
};
static const char * const af_descs[AF_MAX] = {
    "unspecified",
    "local to host (pipes)",
    "internetwork: UDP, TCP, etc.",
    "arpanet imp addresses",
    "pup protocols: e.g. BSP",
    "mit CHAOS protocols",
    "XEROX NS protocols",
    "ISO protocols",
    "European computer manufacturers",
    "datakit protocols",
    "CCITT protocols, X.25 etc",
    "IBM SNA",
    "DECnet",
    "DEC Direct data link interface",
    "LAT",
    "NSC Hyperchannel",
    "Apple Talk",
    "Internal Routing Protocol",
    "Link layer interface",
    "eXpress Transfer Protocol (no AF)",
    "connection-oriented IP, aka ST II",
    "Computer Network Technology",
    "Help Identify RTIP packets",
    "Novell Internet Protocol",
    "Simple Internet Protocol",
    "Help Identify PIP packets",
    "n/a",
    "Network Driver 'raw' access",
    "Integrated Services Digital Network",
    "Internal key-management function",
    "IPv6",
    "native ATM access",
    "Kernel event messages",
    "NetBIOS",
    "PPP communication protocol",
    "Used by BPF to not rewrite headers in interface output routine",
    "Reserved for internal usage",
    "IEEE 802.11 protocol",
    "n/a",
    "n/a",
    "VM Sockets",
};

NS_INLINE const char *af_const_str(sa_family_t af) {
    return af_consts[MIN(MAX(0, af), AF_MAX - 1)];
}

NS_INLINE const char *af_desc(sa_family_t af) {
    return af_descs[MIN(MAX(0, af), AF_MAX - 1)];
}

@implementation CSNetworkInterface

- (instancetype)initWithName:(NSString *)name address:(NSString *)address family:(sa_family_t)family {
    self = [super init];
    if (self) {
        _name = name;
        _address = address;
        _family = family;
        _familyName = @(af_const_str(_family));
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ name:%@ address:%@ family:%@ (%s)", super.description, _name, _address,_familyName, af_desc(_family)];
}

@end
