//
//  AlicomFusionAuthToken.h
//  AlicomFusionAuthSDK
//
//  Created by shenchao12344 on 2022/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/* 鉴权token */
@interface AlicomFusionAuthToken : NSObject

@property (nonatomic, copy, readonly) NSString *authToken;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTokenStr:(NSString *)tokenStr;


@end

NS_ASSUME_NONNULL_END
