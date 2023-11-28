#import "FusionAuthPlugin.h"
#import "AlicomFusionManager.h"
#import "AlicomFusionUtil.h"
#import "FusionAuthPluginCommon.h"

@interface FusionAuthPlugin()<UIApplicationDelegate, FlutterStreamHandler>
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation FusionAuthPlugin{
  FusionAuthPluginCommon * common;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FusionAuthPlugin* instance = [[FusionAuthPlugin alloc] init];
  
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"fusion_auth"
            binaryMessenger:[registrar messenger]];
  [registrar addMethodCallDelegate:instance channel:channel];
  
  FlutterEventChannel* chargingChannel = [FlutterEventChannel 
      eventChannelWithName:@"fusion_auth/event"
           binaryMessenger: [registrar messenger]];
  [chargingChannel setStreamHandler: instance];
}


#pragma mark - IOS 主动发送通知让 flutter调用监听 eventChannel start
- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
  // 设置监听后自动初始化SDK
  if (self->common == NULL) {
    self->common = [FusionAuthPluginCommon shareInstance];
  }
  
  if (self->common.EventSink == NULL) {
    self->common.EventSink = eventSink;
  }
  
  /** 返回初始化状态 */
//  NSString *version = [AlicomFusionAuthHandler getSDKVersion];
//  NSDictionary *dict = @{ @"code": @"500004", @"msg": version };
//  [self->common showResultMsg: dict msg:version];
  return nil;
}

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
  self->common.EventSink = nil;
  return nil;
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if (self->common == nil) {
    self->common = [FusionAuthPluginCommon shareInstance];
  }
  self->common.Result = result;
  self->common.CallData = call;
  
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"init" isEqualToString:call.method]) {
    // 初始化设置公共参数
    self->common.CONFIG = call.arguments;
    [AlicomFusionLog logEnable:NO];
    [FusionAuthPluginCommon shareInstance].TEMLATEID = @"100001";
    if ([AlicomFusionManager shareInstance].isActive){
      [[AlicomFusionManager shareInstance]
       startSceneWithTemplateId:[FusionAuthPluginCommon shareInstance].TEMLATEID
                 viewController:[AlicomFusionUtil findCurrentViewController]
      ];
    } else {
      [FusionAuthPluginCommon shareInstance].TOKEN = @"eyJhY2Nlc3NLZXlJZCI6IlNUUy5OU3JYbnB2M0xHOER6RzRGd1I5ckh6R0dtIiwiYWNjZXNzS2V5U2VjcmV0IjoiNnB5U2Z6UjE2bmRHejJvOWFldzF5N2tMTXBCSlk2RE5xNThWMnlOMmVWczkiLCJiaXpUb2tlbiI6ImpVRkMzb3g1dER1Ui9SQkdDdklkRkFaNWZtTWI5TnMrY2MrbU5XNWNoaDlZVFBNYzFVdUxJR1dyeXhINnV5cW5od1dRSW12ZEFyMEszY2RjSGcrWHR3RnpxeVVDSVhLK0lEQTNERFY2YlVDdlBQS01YNDE3Q1NQMXNRa2J3cW9LTDZDT1pQWnFQOHMzaTJMUTYwNXZyV1NEOVNaUENsSVpOVXJudEROcEtSV2xTdmtCZy9jSXdMSkk0K09TdTNqSSt1MHNYSmJhVDdNam8wdmQyalRyd0JmRHhLOFlBd2loU2o4K1p3cmlvY01HSFJPZTZQKzd3STd1K3BFZ0JwUHorOUZOSXVvbEZ5Zz0iLCJ1bWVuZ0FwcEtleSI6IjY1MDgwMjhmYjJmNmZhMDBiYTU0YjVhNiIsInN0c1Rva2VuIjoiQ0FJU3p3UjFxNkZ0NUIyeWZTaklyNURIRTlURW0reHQ4UHF2ZUdHRm9uY0hOZjFrbFlMc2p6ejJJSDlGZEhsdEFld1dzdmcxbm01Vzdmc2ZsclphUUpSSVhsZnFjTkJ4NlpKKzdCK2hSSkxNdmVXdDdJRWZoWWVmSG15ZVU4VUxEblFFT3JlWGRzalVYOXZ3UWNPdTlFWXFzMCtURjFpTFcxaWlMdWZZNi9wT1pjZ1dXUStWZENkUEFNd3NTQ0pwdE00ZE13bVlWNU9xS1FXNHJXZk1LMEJxdHdGZzZ4dDQ4ci90N2NDQXpSRGNnVmJtNCtRUjNiU1RSS0twZE01eEpweHlmczZvMWVodERNcjczVFZYOWdKQitkVWk3djVOOGl5VnVjcUdVUnNEb1VlSUx2SFY5ZHNxTndONkk3TXhGcWhKNmZQN2svTjV0YXY5dnR5dmswNFZaYmtORDMrQkhOajZuSldkUTZUclJHaFFGOXZTUDNES3phcE1YL3VSbWdnNFlIVWRHUnBYY3Q0NlVCRlpBZ0F0VFRlbzBNYkZnbHpiZWdHNEdaV2QxS1kvM2FGNXpISHY4cmo1SzBtWFJhN0wvaXNFQVpvblVsc1dPZ1FYMDMzS2Rha2FmZ3BRRVM5ckZxNlRWdGRJWVJaU2w2N3l2QVBEZlNwc3d4TWJzK3ptWWVpRWxMMEVhSUw1ZDQ5YTBiRVFiNGxjc25jN1pGUHhWNmlwam13VWRXcHNJLzFhd2JIcklzMkc5YktmMGN1T2V1L0JETXNNdDFOWFdqZlhvU3VDZDM1S05pejI0S2RVQ3p5aTl0L1cwYmJIL3I1NURRSXEvYW8vTnd5ZWRzdDNwRkVVaU1uYnJUYnJxYisvQWk3d3JqdGtwb0NIcHRBUnRuRUpKS24wMzdXZzJSZkZwMkdWYktVRG44UGFaWFppV3h6ZmVRWWluNkhDMWk5ZiswQmR6enZ1WlVoRXRnbUxvbSs3ZDhBQXlmS1czWEpEQks1T2hlVGZVenFtOTMxaEZNbUUrYXdNWGU1eWkybUJoZ2wrRVdvYWdBRWlwZTVwSmxFbkFnUVB1WTdsRmhUM0ZhL1BPVDhwTDVHYmlGV1VtVXY3d0FCcDFCMjBqcTVEaXhHZjY5azdQVDd2Zy9hSHV2NlRYT2lDR1lITXVZK2djM3d1Qzh6ZWRvYWVFcmI2ZkVjMHFaM1ZqQUVjL2lEaWNCZnhONVluS05Pb0syamUyUlpvM3RXelFhamZHY2ZJUjF0N3MrT3ZaMTVKVDFTUmVGNHdHaUFBIiwiZXhwaXJlZFRpbWUiOjE3MDA0NDUxOTUxNTV9";
      [FusionAuthPluginCommon shareInstance].SCHEME_CODE = @"FA000000004360024613";
      [FusionAuthPluginCommon shareInstance].DEBUG_MODE = true;
      [[AlicomFusionManager shareInstance] start];
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
