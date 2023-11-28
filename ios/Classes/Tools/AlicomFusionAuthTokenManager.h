//
//  AlicomFusionAuthTokenManager.h
//  AlicomFusionAuthDemo
//
//  Created by 彦克 on 2023/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlicomFusionAuthTokenManager : NSObject

@property(nonatomic, copy) NSString * _Nullable authTokenStr;

+ (instancetype)shareInstance;

+ (void)getAuthToken:(void(^)(NSString *tokenStr, NSString *errorMsg))complete;
+ (NSString *)updateAuthToken;
+ (void)logout;

@end

NS_ASSUME_NONNULL_END
