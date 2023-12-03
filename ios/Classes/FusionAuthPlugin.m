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
      [FusionAuthCommon shareInstance].TOKEN = @"eyJhY2Nlc3NLZXlJZCI6IlNUUy5OVFlBQ1NyRFB6aUZ2bjlHTG91SHB5cnp2IiwiYWNjZXNzS2V5U2VjcmV0IjoiOURSTHVVWHFHYkN4WmtjM2l5YWgyTEI3dTEyV3NwZFRhZ2VuaUt2QUQ4VWUiLCJiaXpUb2tlbiI6ImpVRkMzb3g1dER1Ui9SQkdDdklkRkFaNWZtTWI5TnMrY2MrbU5XNWNoaDlZVFBNYzFVdUxJR1dyeXhINnV5cW5od1dRSW12ZEFyMEszY2RjSGcrWHR3RnpxeVVDSVhLK0lEQTNERFY2YlVDdlBQS01YNDE3Q1NQMXNRa2J3cW9LTDZDT1pQWnFQOHNRZjZDMUVpRE43akErQTVvSU5ORFJqK2NYTHhrZXBla3poYUl2LzhWMnFkMFR3bWloa1NRaFJDMXMrSFRBYi90bGc3UlVWRVZCS2NzeU9nQXpuN0J2eXJCcFNOZU1kMTJSSm9BMkNCUmhvOGtzck54Yk5hb3pCRzNPbjNCcWNhVT0iLCJ1bWVuZ0FwcEtleSI6IjY1MDgwMjhmYjJmNmZhMDBiYTU0YjVhNiIsInN0c1Rva2VuIjoiQ0FJU3p3UjFxNkZ0NUIyeWZTaklyNWZzQ3Zubm41dHh6YXV0ZEVpSW8wdzZlY2RjbHJmUmxEejJJSDlGZEhsdEFld1dzdmcxbm01Vzdmc2ZsclphUUpSSVhsZnFjTkJ4NlpKKzdCK2hSSkxNdmVXdDdJRWZoWWVmSG15ZVUvbEFBQ3g1T3JlWGRzalVYOXZ3UWNPdTlFWXFzMCtURjFpTFcxaWlMdWZZNi9wT1pjZ1dXUStWZENkUEFNd3NTQ0pwdE00ZE13bVlWNU9xS1FXNHJXZk1LMEJxdHdGZzZ4dDQ4ci90N2NDQXpSRGNnVmJtNCtRUjNiU1RSS0twZE01eEpweHlmczZvMWVodERNcjczVFZYOWdKQitkVWk3djVOOGl5VnVjcUdVUnNEb1VlSUx2SFY5ZHNxTndONkk3TXhGcWhKNmZQN2svTjV0YXY5dnR5dmswNFZaYmtORDMrQkhOajZuSldkUTZUclJHaFFGOXZTUDNES3phcE1YL3VSbWdnNFlIVWRHUnBYY3Q0NlVCRlpBZ0F0VFRlbzBNYkZnbHpiZWdHNEdaV2QxS1kvM2FGNXpISHY4cmo1SzBtWFJhN0wvaXNFQVpvblVsc1dPZ1FYMDMzS2Rha2FmZ3BRRVM5ckZxNlRWdGRJWVJaU2w2N3l2QVBEZlNwc3d4TWJzK3ptWWVpRWxMMEVhSUw1ZDQ5YTBiRVFiNGxjc25jN1pGUHhWNmlwam13VWRXcHNJLzFhd2JIcklzMkc5YktmMGN1T2V1L0JETXNNdDFOWFdqZlhvU3VDZDM1S05pejI0S2RVQ3p5aTl0L1cwYmJIL3I1NURRSXEvYW8vTnd5ZWRzdDNwRkVVaU1uYnJUYnJxYisvQWk3d3JqdGtwb0NIcHRBUnRuRUpKS24wMzdXZzJSZkZwMkdWYktVRG44UGFaWFppV3h6ZmVRWWluNkhDMWk5ZiswQmR6enZ1WlVoRXRnbUxvbSs3ZDhBQXlmS1czWEpEQks1T2hlVGZVenFtOTMxaEZNbUUrYXdNWGU1eWkybUJoZ2wrRVdvYWdBRU9EMnRBNWJjK2xoM1JwQ21sRS9BSXhJcmtnZllIYmN1bklUR1lZMGs5RlZIREZnSm9JejVUMm1sWDdoQ3VpTG8yZHNMVDA2YVJIMjR0NEs2bk1oT1gyS3JnaUVrUmFpM3J0R1ExcDVHMTNOM1dna29sY3NwV2tEM2RaT3FSaGVEVkZCN0EwblV2TXhra01sdG5nSFlkTzJTZWJTWjN6cWtlNlRKTUtYOTAxaUFBIiwiZXhwaXJlZFRpbWUiOjE3MDE2MzYyODY3Mzh9";
      [FusionAuthCommon shareInstance].SCHEME_CODE = @"FA000000004360024613";
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
