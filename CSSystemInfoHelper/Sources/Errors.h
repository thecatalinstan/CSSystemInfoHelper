//
//  Errors.h
//  CSSystemInfoHelper
//
//  Created by Cătălin Stan on 17/06/2021.
//

#import <errno.h>
#import <Foundation/Foundation.h>
#import <mach/mach.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const CSMachErrorDomain;

NS_INLINE NSError *
NSErrorMake(NSErrorDomain domain,
            NSInteger code,
            NSString *_Nullable description,
            NSString *_Nullable reason,
            NSDictionary<NSErrorUserInfoKey, id> *_Nullable userInfo) {
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:userInfo.count + 2];
    info[NSLocalizedDescriptionKey] = description;
    info[NSLocalizedFailureReasonErrorKey] = reason;
    if (userInfo) {
        [info addEntriesFromDictionary:userInfo];
    }
    return [NSError errorWithDomain:domain code:code userInfo:info];
}

NS_INLINE NSError *
NSPosixError(int errnum, NSString *_Nullable reason, NSDictionary<NSErrorUserInfoKey, id> *_Nullable userInfo) {
    return NSErrorMake(NSPOSIXErrorDomain, (NSInteger)errnum, @(strerror(errnum)), reason, userInfo);
}

NS_INLINE NSError *
CSMachError(kern_return_t ret, NSString *_Nullable reason, NSDictionary<NSErrorUserInfoKey, id> *_Nullable userInfo) {
    return NSErrorMake(CSMachErrorDomain, (NSInteger)ret, @(mach_error_string(ret)), reason, userInfo);
}


NS_ASSUME_NONNULL_END

