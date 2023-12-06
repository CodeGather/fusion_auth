//
//  AlicomFusionDemoUtil.m
//  AlicomFusionAuthDemo
//
//  Created by shenchao12344 on 2023/2/28.
//
#import <Flutter/Flutter.h>
#import "AlicomFusionUtil.h"


@implementation AlicomFusionUtil
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size isRoundedCorner:(BOOL )isRounded radius:(CGFloat)radius {
    
    if (size.width <=0 || size.height <= 0) {
        // iOS17 xcode15废弃UIGraphicsBeginImageContext  UIGraphicsBeginImageContextWithOptions UIGraphicsEndImageContext UIGraphicsGetImageFromCurrentImageContext
        // width height小于等于0时会crash
        // 正确的做法是使用下述函数生成图片，鉴于本方法调用数较多且分散，暂时只对width height的小于等于0的情况做适配
        if (@available(iOS 10.0, *)) {
            UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:CGSizeMake(300, 0)];
            UIImage *colorImage = [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                
            }];
            return colorImage;
        }
        return [[UIImage alloc] init];
    }
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (isRounded) {
        if (radius < 0) {
            radius = 0;
        }
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
        CGContextAddPath(context, path.CGPath);
        CGContextClip(context);
        [image drawInRect:rect];
        CGContextDrawPath(context, kCGPathFillStroke);
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return image;
}

+ (CGFloat)getStatusBarHeight {
    CGFloat height = 20.0f;
    BOOL isStatusBarHidden = NO;
    CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
    if (statusFrame.size.height == CGRectZero.size.height) {
        isStatusBarHidden = YES;
        height = 0.0f;
    }
    UIWindow *window = nil;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(connectedScenes)]) {
                NSArray *connectedScenes = [[UIApplication sharedApplication] performSelector:@selector(connectedScenes)];
                for (id wScene in connectedScenes) {
                    if ([wScene respondsToSelector:@selector(activationState)]) {
                        NSInteger state = [wScene performSelector:@selector(activationState)];
                        if (state == 0) {
                            NSArray *windows = [wScene performSelector:@selector(windows)];
                            if (windows.count > 0) {
                                window = windows.firstObject;
                            }
                            break;
                        }
                    }
                }
            }
        }
        if (!window) {
            window = [UIApplication sharedApplication].keyWindow;
        }
        if (window && [window respondsToSelector:@selector(safeAreaInsets)]) {
            height = window.safeAreaInsets.top;
        }
        if (height < 0.1 && !isStatusBarHidden) {
            height = statusFrame.size.height;
        }
    }
    return height;
}

#pragma mark  ======获取flutterVc========
+(FlutterViewController *)flutterVC{
  UIViewController * viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  if ([viewController isKindOfClass: [FlutterViewController class]]) {
    return (FlutterViewController *)viewController;
  } else {
    return (FlutterViewController *)[self findCurrentViewController];
  }
}
+ (UIViewController *)getRootViewController {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return window.rootViewController;
}

#pragma mark  ======在view上添加UIViewController========
+ (UIViewController *)findCurrentViewController{
  UIWindow *window = [[UIApplication sharedApplication].delegate window];
  UIViewController *topViewController = [window rootViewController];
  while (true) {
      if (topViewController.presentedViewController) {
          topViewController = topViewController.presentedViewController;
      } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
          topViewController = [(UINavigationController *)topViewController topViewController];
      } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
          UITabBarController *tab = (UITabBarController *)topViewController;
          topViewController = tab.selectedViewController;
      } else {
          break;
      }
  }
  /// 强制全屏
  topViewController.modalPresentationStyle = UIModalPresentationFullScreen;
  return topViewController;
}


#pragma mark  assets -> 自定义图片view
+ (UIImageView *)customView: (NSString *)path
                   selector:(SEL)selector
                     target: (id) target
                      index: (int) index
{
  UIImage * image = [self changeUriPathToImage: path];
  
  /// 自定义布局 图片不支持圆角，如需圆角请使用圆角图片
  UIImageView *imageView = [[UIImageView alloc]init];
  imageView.image = image;
  imageView.tag = index;
  imageView.frame = CGRectMake( 0, 0, 50, 50 );
  /// 设置控件背景颜色
  /// imageView.backgroundColor = [UIColor orangeColor];
  imageView.clipsToBounds = YES;
  /// imageView.contentMode = UIViewContentModeScaleAspectFill;
  imageView.contentMode = UIViewContentModeScaleToFill;
  /// imageView.contentMode = UIViewContentModeScaleAspectFit;
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
  
  [imageView addGestureRecognizer:tapGesture];
  imageView.userInteractionEnabled = YES;
  
  return imageView;
}

#pragma mark  assets -> 转换成真实路径
+ (NSString *) changeUriToPath:(NSString *) key{
  NSString* keyPath = [[self flutterVC] lookupKeyForAsset: key];
  NSString* path = [[NSBundle mainBundle] pathForResource: keyPath ofType:nil];
  return path;
}

#pragma mark  assets -> 真实路径转成UIImage
+ (UIImage *) changeUriPathToImage:(NSString *) key{
  if (key == nil || [key isEqual: @""]) return nil;
  // NSLog(@"路径为：%@", key);
  NSString* path = [self changeUriToPath: key];
  UIImage * image = [UIImage imageWithContentsOfFile: path];
  return image;
}

@end
