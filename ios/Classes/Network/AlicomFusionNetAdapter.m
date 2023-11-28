
#import "AlicomFusionNetAdapter.h"
#import "AlicomFusionNetManager.h"

#define kTimeout 20.0


@implementation AlicomFusionNetAdapter

#if DEMO_DEBUG_MODE == 1
+ (void)getTokenRequestComplete:(AlicomFusionNetAdapterCompletion)complete {
}
+ (void)verifyTokenRequest:(NSString *)verifyToken
                  complete:(AlicomFusionNetAdapterCompletion)complete {
}
#elif DEMO_DEBUG_MODE == 2
+ (void)getTokenRequestComplete:(AlicomFusionNetAdapterCompletion)complete {
    AlicomFusionNetGetTokenRequest *request = [[AlicomFusionNetGetTokenRequest alloc] init];
    request.action = DEMO_AUTHTOKEN_API;
    request.schemeCode = DEMO_SCHEME_CODE;
    request.durationSeconds = @(DEMO_TOKEN_EXPIR_TIME);
    
    NSString *paramterString = [request buildRequestString];
    
    [AlicomFusionNetManager getWithBaseUrl:DEMO_APP_SERVER_HOST
                           timeout:kTimeout
                       requestBody:paramterString
                          complete:^(NSDictionary * _Nonnull responseDict, NSError * _Nullable error) {
        if (error&&complete){
            complete(nil,error);
            return;
        }
        if ([responseDict.allKeys containsObject:@"Model"]){
            complete(responseDict[@"Model"],nil);
        }else{
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:responseDict[@"Code"] forKey:NSLocalizedDescriptionKey];
            NSError *temError = [NSError errorWithDomain:AlicomFusionNetManagerErrorDomain code:-1 userInfo:userInfo];
            complete(nil,temError);
        }
    }];
}

+ (void)verifyTokenRequest:(NSString *)verifyToken
                  complete:(AlicomFusionNetAdapterCompletion)complete {
    AlicomFusionNetVerifyTokenRequest *request = [[AlicomFusionNetVerifyTokenRequest alloc] init];
    request.verifyToken = verifyToken;
    request.action = DEMO_VERIFY_API;
    request.schemeCode = DEMO_SCHEME_CODE;
    
    NSString *paramterString = [request buildRequestString];
    
    [AlicomFusionNetManager postWithBaseUrl:DEMO_APP_SERVER_HOST
                           timeout:kTimeout
                       requestBody:paramterString
                          complete:^(NSDictionary * _Nonnull responseDict, NSError * _Nullable error) {
        if (error&&complete){
            complete(nil,error);
            return;
        }
        if ([responseDict.allKeys containsObject:@"Data"]){
            complete(responseDict[@"Data"],nil);
        } else if ([responseDict.allKeys containsObject:@"Model"]) {
            complete(responseDict[@"Model"],nil);
        } else{
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:responseDict[@"Code"] forKey:NSLocalizedDescriptionKey];
            NSError *temError = [NSError errorWithDomain:AlicomFusionNetManagerErrorDomain code:-1 userInfo:userInfo];
            complete(nil,temError);
        }
    }];
}
#endif /* DEMO_DEBUG_MODE */

@end
