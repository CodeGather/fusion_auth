//
//  AliAuthEnum.好的.h
//  Pods
//
//  Created by Yau on 2022/5/19.
//
#import <Foundation/Foundation.h>


@interface FusionAuthEnum : NSObject
+ (NSDictionary *)initData;
@end
// FOUNDATION_EXPORT NSString * const StatusAll;

typedef NS_ENUM(NSUInteger, PNSBuildModelStyle) {
    //全屏
    PNSBuildModelStylePortrait,
    PNSBuildModelStyleLandscape,
    //PNSBuildModelStyleAutorotate,
    
    //弹窗
    PNSBuildModelStyleAlertPortrait,
    PNSBuildModelStyleAlertLandscape,
    // PNSBuildModelStyleAlertAutorotate,
    
    //底部弹窗
    PNSBuildModelStyleSheetPortrait,
    
    //DIY 动画
    PNSDIYAlertPortraitFade,
    PNSDIYAlertPortraitDropDown,
//    PNSDIYAlertPortraitBounce,
//    PNSDIYPortraitFade,
//    PNSDIYPortraitScale,
  
    PNSBuildModelStyleGifBackground,
    //other
    PNSBuildModelStyleVideoBackground,
    PNSBuildModelStylePicBackground,
};

