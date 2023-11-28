/**
 *  参数参考：https://yuque.antfin-inc.com/alibabacloud-openapi/pop-doc/gkcc7i
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - SmsPopRequest

@interface AlicomFusionNetRequest : NSObject
/// Format，返回消息的格式。取值：JSON
@property (nonatomic, copy) NSString *format;
/// Action，API名称【注：需要外面传入】
@property (nonatomic, copy) NSString *action;
#pragma mark - utils
- (NSMutableDictionary *)toDictionary;
- (NSString *)buildRequestString;
@end

#pragma mark - SmsPopGetTokenRequest

@interface AlicomFusionNetGetTokenRequest : AlicomFusionNetRequest
@property (nonatomic, copy) NSString *schemeCode;
@property (nonatomic, copy) NSString *bundleId;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, strong) NSNumber *durationSeconds;
@end


#pragma mark - SmsPopVerifyTokenRequest
@interface AlicomFusionNetVerifyTokenRequest : AlicomFusionNetRequest
@property (nonatomic, copy) NSString *schemeCode;
@property (nonatomic, copy) NSString *verifyToken;
@end

NS_ASSUME_NONNULL_END
