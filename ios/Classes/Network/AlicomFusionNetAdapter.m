
#import "AlicomFusionNetAdapter.h"
#import "AlicomFusionNetManager.h"
#import "FusionAuthCommon.h"
#import "NSDictionary+Utils.h"

#define kTimeout 20.0


@implementation AlicomFusionNetAdapter

+ (void)getTokenRequestComplete:(AlicomFusionNetAdapterCompletion)complete {
  if ([FusionAuthCommon shareInstance].DEBUG_MODE) {
    
  } else {
    AlicomFusionNetGetTokenRequest *request = [[AlicomFusionNetGetTokenRequest alloc] init];
    NSDictionary *dict = [FusionAuthCommon shareInstance].CONFIG;
    
    request.action = [dict stringValueForKey: @"appServerHost" defaultValue: @""];
    request.schemeCode = [dict stringValueForKey: @"schemeCode" defaultValue: @""];
    request.durationSeconds = [dict numberValueForKey: @"tokenExpirTime" defaultValue: @kTimeout];
    
    NSString *paramterString = [request buildRequestString];
    
    [AlicomFusionNetManager getWithBaseUrl: [dict stringValueForKey: @"appServerHost" defaultValue: @""]
                           timeout: kTimeout
                       requestBody: paramterString
                          complete: ^(NSDictionary * _Nonnull responseDict, NSError * _Nullable error) {
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
}
+ (void)verifyTokenRequest:(NSString *)verifyToken
                  complete:(AlicomFusionNetAdapterCompletion)complete {
  if ([FusionAuthCommon shareInstance].DEBUG_MODE) {
    
  } else {
    AlicomFusionNetVerifyTokenRequest *request = [[AlicomFusionNetVerifyTokenRequest alloc] init];
    NSDictionary *dict = [FusionAuthCommon shareInstance].CONFIG;
    
    request.verifyToken = verifyToken;
    request.action = [dict stringValueForKey: @"verifyApi" defaultValue: @""];;
    request.schemeCode = [dict stringValueForKey: @"schemeCode" defaultValue: @""];;
    
    NSString *paramterString = [request buildRequestString];
    
    [AlicomFusionNetManager postWithBaseUrl: [dict stringValueForKey: @"appServerHost" defaultValue: @""]
                           timeout: kTimeout
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
}

@end
