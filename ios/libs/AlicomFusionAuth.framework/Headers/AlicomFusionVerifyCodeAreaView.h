//
//  AlicomFusionVerifyCodeAreaView.h
//  AlicomFusionAuthSDK
//
//  Created by shenchao12344 on 2022/12/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlicomFusionVerifyCodeAreaView : UIView
///文字
@property (nonatomic, strong) NSString *text;

///显示光标 默认关闭
@property (nonatomic) BOOL showCursor;
@end

NS_ASSUME_NONNULL_END
