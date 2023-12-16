#import "FusionAuthPlugin.h"
#import "AlicomFusionManager.h"
#import "AlicomFusionUtil.h"
#import "FusionAuthCommon.h"
#import "NSDictionary+Utils.h"

@interface FusionAuthPlugin()<UIApplicationDelegate>
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation FusionAuthPlugin{
  FusionAuthCommon * common;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FusionAuthPlugin* instance = [[FusionAuthPlugin alloc] init];
  
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"fusion_auth"
            binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:instance channel:channel];
  [FusionAuthCommon shareInstance].methodChannel = channel;
  
  // 测试联网
  [instance httpAuthority];
}

#pragma mark - 测试联网阿里授权必须
-(void)httpAuthority{
  NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];//此处修改为自己公司的服务器地址
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *dataTask = [session 
    dataTaskWithRequest:request
      completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"联网成功！");
        } else {
          NSLog(@"联网失败！");
        }
      }
  ];
  [dataTask resume];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if (self->common == nil) {
    self->common = [FusionAuthCommon shareInstance];
  }
  self->common.Result = result;
  
  if ([@"getVersion" isEqualToString:call.method]) {
    NSString *version = [[AlicomFusionManager shareInstance] getSDKVersion];
    NSDictionary *dict = @{ 
      @"resultCode": @"999999",
      @"resultMsg": [
        NSString
        stringWithFormat: @"插件启动成功, 原生SDK版本: %@", version
      ]
     };
    [self->common showResultMsg: dict msg: @""];
  } else if ([@"initSdk" isEqualToString:call.method]) {
    // 初始化设置公共参数
    self->common.CONFIG = call.arguments;
    // 是否是快速模式
    [FusionAuthCommon shareInstance].DEBUG_MODE = [self->common.CONFIG boolValueForKey: @"debugMode" defaultValue: NO];
    // 是否打印日志
    [AlicomFusionLog logEnable: [self->common.CONFIG boolValueForKey: @"templateId" defaultValue: NO]];
    // 设置场景ID
    [FusionAuthCommon shareInstance].TEMLATEID = [self->common.CONFIG stringValueForKey: @"templateId" defaultValue: @"100001"];
    // 快速模式下的token
    [FusionAuthCommon shareInstance].TOKEN = [self->common.CONFIG stringValueForKey: @"token" defaultValue: @""];
    // schemeCode设置
    [FusionAuthCommon shareInstance].SCHEME_CODE = [self->common.CONFIG stringValueForKey: @"schemeCode" defaultValue: @""];
    // 是否是延迟登录，该模式下只初始化SDK
    if (![self->common.CONFIG boolValueForKey: @"isDelay" defaultValue: NO]) {
      // 不是延迟登录的情况下直接执行登录
      [self startLogin];
    }
  } else if ([@"login" isEqualToString:call.method]) {
    self->common.DEBUG_MODE = true;
    // 开始登录
    [self startLogin];
  } else if ([@"updateToken" isEqualToString:call.method]) {
    [[AlicomFusionManager shareInstance] updateToken: [call.arguments stringValueForKey: @"token" defaultValue: @""]];
  } else if ([@"dispose" isEqualToString:call.method]) {
    [[AlicomFusionManager shareInstance] destory];
  } else  {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark - 公共的登录函数
-(void) startLogin{
  if ([AlicomFusionManager shareInstance].isActive){
//    [[AlicomFusionManager shareInstance] continueScane];
    [[AlicomFusionManager shareInstance] stopScene];
  }
  [[AlicomFusionManager shareInstance] start];
}
@end
