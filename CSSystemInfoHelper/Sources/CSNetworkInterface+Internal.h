//
//  CSInterfaceAddress+Internal.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 17/06/2021.
//

#import <CSSystemInfoHelper/CSNetworkInterface.h>

#import <sys/socket.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSNetworkInterface ()

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                      family:(sa_family_t)family
NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
