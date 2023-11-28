//
//  AlicomFusionToastTool.m
//  AlicomFusionAuthDemo
//
//  Created by yanke on 2023/2/7.
//

#import "AlicomFusionToastTool.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation AlicomFusionToastTool

+ (void)showToastMsg:(NSString *)msg time:(NSTimeInterval)time {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:14.f];
    hud.detailsLabel.text = (msg);
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)showLoading{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)hideLoading{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
