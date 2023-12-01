//
//  AlicomFusionToastTool.h
//  AlicomFusionAuthDemo
//
//  Created by yanke on 2023/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlicomFusionToastTool : NSObject

+ (void)showToastMsg:(NSString *)msg time:(NSTimeInterval)time;

+ (void)showLoading;
+ (void)hideLoading;

@end

NS_ASSUME_NONNULL_END
