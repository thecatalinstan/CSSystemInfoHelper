//
//  CSSystemInfoHelper+Internal.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 18/06/2021.
//

#import <CSSystemInfoHelper/CSSystemInfoHelper.h>
#import "CSSystemInfoProvider.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const CSSystemInfoHelperDefaultInterface DEPRECATED_ATTRIBUTE;

@interface CSSystemInfoHelper ()

- (instancetype)initWithSystemInfoProvider:(id<CSSystemInfoProviderProtocol> _Nullable)systemInfoProvider NS_DESIGNATED_INITIALIZER;

- (NSString *)formatByteCount:(long long)byteCount;

@end

NS_ASSUME_NONNULL_END
