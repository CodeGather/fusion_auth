//
//  AlicomFusionDemoUtil.h
//  AlicomFusionAuthDemo
//
//  Created by shenchao12344 on 2023/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlicomFusionUtil : NSObject
+ (UIViewController *)findCurrentViewController;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size isRoundedCorner:(BOOL )isRounded radius:(CGFloat)radius;
+ (CGFloat)getStatusBarHeight;
+ (UIImage *) changeUriPathToImage:key;
@end

NS_ASSUME_NONNULL_END
