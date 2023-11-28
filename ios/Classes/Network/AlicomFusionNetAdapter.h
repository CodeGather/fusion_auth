
#import <Foundation/Foundation.h>
#import "AlicomFusionNetRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^AlicomFusionNetAdapterCompletion)(id _Nullable data, NSError * _Nullable error);

@interface AlicomFusionNetAdapter : NSObject

+ (void)getTokenRequestComplete:(AlicomFusionNetAdapterCompletion)complete;

+ (void)verifyTokenRequest:(NSString *)verifyToken
                  complete:(AlicomFusionNetAdapterCompletion)complete;

@end

NS_ASSUME_NONNULL_END
