#import "FusionAuthPluginCommon.h"
#import "FusionAuthEnum.h"


@implementation FusionAuthPluginCommon
-(void) resultData:(NSDictionary *)dict{
  if (_EventSink != nil) {
    _EventSink(dict);
  }
}


+ (instancetype)shareInstance {
    static FusionAuthPluginCommon *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[FusionAuthPluginCommon alloc] init];
        }
    });
    return instance;
}

#pragma mark -  格式化数据utils返回数据
- (void)showResultMsg:(id __nullable)showResult msg: (NSString*)msg {
  NSString *resultMsg = [NSString stringWithFormat: [FusionAuthEnum initData][[showResult objectForKey:@"code"]], msg]?:@"";
  NSDictionary *dict = @{
      @"code": [NSString stringWithFormat: @"%@", [showResult objectForKey:@"code"]],
      @"msg" : resultMsg,
      @"data" : [showResult objectForKey: @"token"]?:@""
  };

  [self resultData: dict];
  [self showResultLog: showResult];
}

#pragma mark -  格式化数据utils统一输出日志
- (void)showResultLog:(id __nullable)showResult  {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *desc = nil;
        if ([showResult isKindOfClass:NSString.class]) {
            desc = (NSString *)showResult;
        } else {
            desc = [showResult description];
            // if (desc != nil) {
            //     desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
            // }
        }
        // NSLog( @"打印日志---->>%@", desc );
    });
}
@end
