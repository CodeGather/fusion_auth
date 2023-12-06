#import "FusionAuthPlugin.h"
#import "AlicomFusionManager.h"
#import "AlicomFusionUtil.h"
#import "FusionAuthCommon.h"

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
+(void)httpAuthority{
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
  
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"init" isEqualToString:call.method]) {
    // 初始化设置公共参数
    self->common.CONFIG = call.arguments;
    [AlicomFusionLog logEnable:NO];
    [FusionAuthCommon shareInstance].TEMLATEID = @"100001";
    if ([AlicomFusionManager shareInstance].isActive){
      [[AlicomFusionManager shareInstance]
       startSceneWithTemplateId:[FusionAuthCommon shareInstance].TEMLATEID
                 viewController:[AlicomFusionUtil findCurrentViewController]
      ];
    } else {
      [FusionAuthCommon shareInstance].TOKEN = @"eyJhY2Nlc3NLZXlJZCI6IlNUUy5OVXhScEhqb1VWVkp5aHRiU1ZuaWdqYVluIiwiYWNjZXNzS2V5U2VjcmV0IjoiOW50Qmd5ZDYybm03dzk0d3VSbXdNYm41dFJmYUprNmNyTHNHcTkyQWNIY2QiLCJiaXpUb2tlbiI6ImpVRkMzb3g1dER1Ui9SQkdDdklkRkFaNWZtTWI5TnMrY2MrbU5XNWNoaDlZVFBNYzFVdUxJSTM3Q0dUTG1LdVhaemNGOGI5ZzIxSmU2Mjl4MHFyTUpsZ2x5UUxMTkhWMGdQT0tYN1NsYjFBeFVvVXIzQ29qbU9yWnZrZjhsR3hlcHRud3V5citYZDBUMGd3Nml5YWVDZGdlYmdySFd4N2dtWEo5WWExamY5bzBTRXJWVi9OWENjeDRWdHRGTTNqZUFST3FFYkxyc01ISC81bFVqMzl3VldHOXZZa3lsb0xaVzlzckNhNjJvSjlLWm03VUJoanY2bjc2WVJ3aFp0aUEvdmZiNGJFeEtqei9VUGlmdE4rMW1RPT0iLCJ1bWVuZ0FwcEtleSI6IjY1NmRjNWYzYjJmNmZhMDBiYThjYWIyZiIsInN0c1Rva2VuIjoiQ0FJU3p3UjFxNkZ0NUIyeWZTaklyNWJOR2NyOGg3QjA0WlNoZTA3RmhsTURZdVpMaGFUeWpEejJJSDlGZEhsdEFld1dzdmcxbm01Vzdmc2ZsclphUUpSSVhsZnFjTkJ4NlpKKzdCK2hSSkxNdmVXdDdJRWZoWWVmSG15ZVU3OVpUblY1T3JlWGRzalVYOXZ3UWNPdTlFWXFzMCtURjFpTFcxaWlMdWZZNi9wT1pjZ1dXUStWZENkUEFNd3NTQ0pwdE00ZE13bVlWNU9xS1FXNHJXZk1LMEJxdHdGZzZ4dDQ4ci90N2NDQXpSRGNnVmJtNCtRUjNiU1RSS0twZE01eEpweHlmczZvMWVodERNcjczVFZYOWdKQitkVWk3djVOOGl5VnVjcUdVUnNEb1VlSUx2SFY5ZHNxTndONkk3TXhGcWhKNmZQN2svTjV0YXY5dnR5dmswNFZaYmtORDNxT0hObjduSldkUTZUclJHaFFGOXZTUDNES3phcE1YL3VSbWdnNFlIVWRHUnBYY3Q0NlVCRlpBZ0F0VFRlbzBNYkZnbHpiZWdHNEdaV2QxS1kvM2FGNXpISHY4cmo1SzBtWFJhN0wvaXNFQVpvblVsc1dPZ1FYMDMzS2Rha2FmZ3BRRVM5ckZxNlRWdGRJWVJaU2w2N3l2QVBEZlNwc3d4TWJzK3ptWWVpRWxMMEVhSUw1ZDQ5YTBiRVFiNGxjc25jN1pGUHhWNmlwam13VWRXcHNJLzFhd2JIcklzMkc5YktmMGN1T2V1L0JETXNNdDFOWFdqZlhvU3VDZDM1S05pejI0S2RVQ3p5aTl0L1cwYmJIL3I1NURRSXEvYW8vTnd5ZWRzdDNwRkVVaU1uYnJUYnJxYisvQWk3d3JqdGtwb0NIcHRBUnRuRUpKS24wMzdXZzJSZkZwMkdWYktVRG44UGFaWFppV3h6ZmVRWWluNkhDMWk5ZiswQmR6enZ1WlVoRXRnbUxvbSs3ZDhBQXlmS1czWEpEQks1T2hlVGZVenFtOTMxaEZNbUUrYXdNWGU1eWkybUJoZ2wrRVdvYWdBRW9hQW5zOXlxUEt4UFpLL1cxR0VYRUk1SGhBN1lPR0hmdHJZc2FoeE13aFNjeDRLNkJSU2tCamxldEhBMURUU3RsSVBJeWFmVXRWbmMxN3NEcGtmVXpHeW5aZlEvY3YrQUl6V0ZSOUhoS3Z6WlhBbTNRQm5LMDJiNlppVk9ZZzBnR2RYSVBnUkp6amQ3REpkTFJJQllMMm01MC9KTnpEc3dYWi9JOTRxN2kzaUFBIiwiZXhwaXJlZFRpbWUiOjE3MDE3ODYzMzAyOTd9";
      [FusionAuthCommon shareInstance].SCHEME_CODE = @"FA000000004690134613";
      [FusionAuthCommon shareInstance].DEBUG_MODE = true;
      [[AlicomFusionManager shareInstance] start];
      
      [self->common.methodChannel invokeMethod:@"onEvent" arguments:@"2222"];
    }
  } else if ([@"login" isEqualToString:call.method]) {
    self->common.DEBUG_MODE = true;
    [[AlicomFusionManager shareInstance] start];
    
//    if ([self checkLogin]){
//        AlicomFusionSettingViewController *VC = [[AlicomFusionSettingViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }else{
//        if ([AlicomFusionManager shareInstance].isActive){
//            [[AlicomFusionManager shareInstance] startSceneWithTemplateId:LOGIN_TEMPLATEID viewController:self];
//        }else{
//            [[AlicomFusionManager shareInstance] start];
//            [AlicomFusionToastTool showToastMsg:@"token鉴权未完成" time:2];
//        }
//    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
