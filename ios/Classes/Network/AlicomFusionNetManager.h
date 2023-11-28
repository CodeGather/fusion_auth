
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const AlicomFusionNetManagerErrorDomain;

typedef void(^AlicomFusionNetMangaerComplete)(NSDictionary *responseDict, NSError * _Nullable error);

@interface AlicomFusionNetManager : NSObject

+ (void)postWithBaseUrl:(NSString *)baseUrl
                timeout:(NSTimeInterval)timeout
            requestBody:(NSString *)requestBody
               complete:(AlicomFusionNetMangaerComplete)complete;

+ (void)getWithBaseUrl:(NSString *)baseUrl
                timeout:(NSTimeInterval)timeout
            requestBody:(NSString *)requestBody
               complete:(AlicomFusionNetMangaerComplete)complete;

@end

NS_ASSUME_NONNULL_END
