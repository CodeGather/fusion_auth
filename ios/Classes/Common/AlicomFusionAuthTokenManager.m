//
//  AlicomFusionAuthTokenManager.m
//  AlicomFusionAuthDemo
//
//  Created by yanke on 2023/2/10.
//

#import "AlicomFusionAuthTokenManager.h"
#import "AlicomFusionNetAdapter.h"

static BOOL g_working_flag = NO;

@interface AlicomFusionAuthTokenManager ()
@property(nonatomic) dispatch_semaphore_t asema;
@end

@implementation AlicomFusionAuthTokenManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.asema=dispatch_semaphore_create(0);
    }
    return self;
}

+ (instancetype)shareInstance {
    static AlicomFusionAuthTokenManager *instance = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[AlicomFusionAuthTokenManager alloc] init];
        }
    });
    return instance;
}

+ (void)getAuthToken:(void(^)(NSString *tokenStr, NSString *errorMsg))complete{
    
    NSString *tokenStr = [AlicomFusionAuthTokenManager shareInstance].authTokenStr;
    
    if (g_working_flag||tokenStr.length > 0){
        return;
    }
    g_working_flag = YES;
    [AlicomFusionNetAdapter getTokenRequestComplete:^(NSString * _Nonnull data, NSError * _Nonnull error) {
        if (data&&!error){
            [AlicomFusionAuthTokenManager shareInstance].authTokenStr = data;
        }
        g_working_flag = NO;
        if (complete){
            complete(data, error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

+ (NSString *)updateAuthToken{
    if (g_working_flag){
        return nil;
    }
    g_working_flag = YES;
    [AlicomFusionNetAdapter getTokenRequestComplete:^(NSString * _Nonnull data, NSError * _Nonnull error) {
        if (data&&!error){
            [AlicomFusionAuthTokenManager shareInstance].authTokenStr = data;
        }
        // 使信号的信号量+1，这里的信号量本来为0，+1信号量为1(绿灯)
        dispatch_semaphore_signal([AlicomFusionAuthTokenManager shareInstance].asema);
        g_working_flag = NO;
    }];
    // 开启信号等待，设置等待时间为永久，直到信号的信号量大于等于1（绿灯）
    dispatch_semaphore_wait([AlicomFusionAuthTokenManager shareInstance].asema, DISPATCH_TIME_FOREVER);
    return [AlicomFusionAuthTokenManager shareInstance].authTokenStr;
}


+ (void)logout {
    [AlicomFusionAuthTokenManager shareInstance].authTokenStr = nil;
}


@end
