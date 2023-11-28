
#import "AlicomFusionNetManager.h"

NSString * const AlicomFusionNetManagerErrorDomain = @"AlicomFusionNetManagerErrorDomain";

@implementation AlicomFusionNetManager

+ (void)postWithBaseUrl:(NSString *)baseUrl
                timeout:(NSTimeInterval)timeout
            requestBody:(NSString *)requestBody
               complete:(AlicomFusionNetMangaerComplete)complete {
    
    //1、URL 检查
    if (baseUrl.length == 0) {
        NSString *description = @"请求 URL 为空";
        NSError *err = [self buildRequestErrorWithCode:1 description:description];
        [self callback:complete responseDict:nil error:err];
        return;
    }
    
    //2、请求参数检查
    if (requestBody.length == 0) {
        NSString *description = @"请求参数为空";
        NSError *err = [self buildRequestErrorWithCode:2 description:description];
        [self callback:complete responseDict:nil error:err];
        return;
    }
    
    //3、发送请求
    NSData *content = [requestBody dataUsingEncoding:NSUTF8StringEncoding];
    NSString *contentLen = [NSString stringWithFormat:@"%lu",(unsigned long)content.length];
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = timeout;
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:contentLen forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:content];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = timeout;
    configuration.timeoutIntervalForResource = timeout;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData * _Nullable data,
                                    NSURLResponse * _Nullable response,
                                    NSError * _Nullable error) {
        if (error) {
            NSError *err = [self buildRequestErrorWithCode:3 description:error.localizedDescription];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        
        if (!data || data.length <= 0) {
            NSString *description = [NSString stringWithFormat:@"返回数据为空"];
            NSError *err = [self buildRequestErrorWithCode:4 description:description];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        
        NSError *jsonError = nil;
        id responseObj = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableLeaves
                                                           error:&jsonError];
        if (jsonError) {
            NSError *err = [self buildRequestErrorWithCode:5 description:jsonError.localizedDescription];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        
        if (![responseObj isKindOfClass:[NSDictionary class]]) {
            NSString *description = [NSString stringWithFormat:@"返回不是字典, obj = %@", responseObj];
            NSError *err = [self buildRequestErrorWithCode:6 description:description];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        if (![responseObj[@"Code"] isEqualToString:@"OK"]) {
            NSString *description = [NSString stringWithFormat:@"接口请求失败, Code = %@，Message= %@", responseObj[@"Code"], responseObj[@"Message"]];
            NSError *err = [self buildRequestErrorWithCode:7 description:description];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        [self callback:complete responseDict:responseObj error:nil];
    }] resume];
}

+ (void)getWithBaseUrl:(NSString *)baseUrl
                timeout:(NSTimeInterval)timeout
            requestBody:(NSString *)requestBody
              complete:(AlicomFusionNetMangaerComplete)complete{
    //1、URL 检查
    if (baseUrl.length == 0) {
        NSString *description = @"请求 URL 为空";
        NSError *err = [self buildRequestErrorWithCode:1 description:description];
        [self callback:complete responseDict:nil error:err];
        return;
    }
    
    //2、请求参数检查
    if (requestBody.length == 0) {
        NSString *description = @"请求参数为空";
        NSError *err = [self buildRequestErrorWithCode:2 description:description];
        [self callback:complete responseDict:nil error:err];
        return;
    }
    
    //3、发送请求
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",baseUrl,requestBody]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = timeout;
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = timeout;
    configuration.timeoutIntervalForResource = timeout;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData * _Nullable data,
                                    NSURLResponse * _Nullable response,
                                    NSError * _Nullable error) {
        if (error) {
            NSError *err = [self buildRequestErrorWithCode:3 description:error.localizedDescription];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        
        if (!data || data.length <= 0) {
            NSString *description = [NSString stringWithFormat:@"返回数据为空"];
            NSError *err = [self buildRequestErrorWithCode:4 description:description];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        
        NSError *jsonError = nil;
        id responseObj = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableLeaves
                                                           error:&jsonError];
        if (jsonError) {
            NSError *err = [self buildRequestErrorWithCode:5 description:jsonError.localizedDescription];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        
        if (![responseObj isKindOfClass:[NSDictionary class]]) {
            NSString *description = [NSString stringWithFormat:@"返回不是字典, obj = %@", responseObj];
            NSError *err = [self buildRequestErrorWithCode:6 description:description];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        if (![responseObj[@"Code"] isEqualToString:@"OK"]) {
            NSString *description = [NSString stringWithFormat:@"接口请求失败, Code = %@，Message= %@", responseObj[@"Code"], responseObj[@"Message"]];
            NSError *err = [self buildRequestErrorWithCode:7 description:description];
            [self callback:complete responseDict:nil error:err];
            return;
        }
        [self callback:complete responseDict:responseObj error:nil];
    }] resume];
}

#pragma mark - utils
+ (NSError *)buildRequestErrorWithCode:(NSInteger)code description:(NSString *)description {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:AlicomFusionNetManagerErrorDomain code:code userInfo:userInfo];
    return error;
}

+ (void)callback:(AlicomFusionNetMangaerComplete)complete
    responseDict:(nullable NSDictionary *)responseDict
           error:(nullable NSError *)error {
    if (complete) {
        complete(responseDict, error);
    }
}

@end
