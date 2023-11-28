//
//  AlicomFusionLog.h
//  AlicomFusionAuthSDK
//
//  Created by shenchao12344 on 2023/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlicomFusionLog : NSObject
//是否打印log，默认开启
+ (void)logEnable:(BOOL)enable;
@end

NS_ASSUME_NONNULL_END
