//
//  AlicomFusionVerifyCodeInputView.h
//  AlicomFusionAuthSDK
//
//  Created by shenchao12344 on 2022/12/28.
//

#import <UIKit/UIKit.h>
#import "AlicomFusionVerifyCodeAreaView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlicomFusionVerifyCodeInputView : UIView
///验证码文字
@property (strong, nonatomic) NSString *codeText;

///设置验证码位数 默认 4 位
@property (nonatomic) NSInteger codeCount;

///验证码数字之间的间距 默认 35
@property (nonatomic) CGFloat codeSpace;
///输入框
@property (strong, nonatomic) UITextField *textField;
///格子数组
@property (nonatomic,strong) NSMutableArray <AlicomFusionVerifyCodeAreaView *> *arrayTextFidld;
///记录上一次的字符串
@property (strong, nonatomic) NSString *lastString;
///放置小格子
@property (strong, nonatomic) UIView *contentView;

@end

NS_ASSUME_NONNULL_END
