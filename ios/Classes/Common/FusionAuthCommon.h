#import <Flutter/Flutter.h>

@interface FusionAuthCommon : NSObject
@property(nonatomic, assign) Boolean DEBUG_MODE;
@property(nonatomic, assign) NSString * _Nonnull TOKEN;
@property(nonatomic, assign) NSString * _Nonnull TEMLATEID; // @"100001"
@property(nonatomic, assign) NSString * _Nonnull SCHEME_CODE; // @"FA000000004360024613"
@property(nonatomic, assign) FlutterResult _Nullable Result;
@property(nonatomic, assign) FlutterMethodCall * _Nullable CallData;
@property(nonatomic, strong) FlutterMethodChannel * _Nullable methodChannel;
@property(nonatomic, strong) UIViewController * _Nullable viewController;
@property(nonatomic, strong) NSMutableDictionary * _Nonnull CONFIG;

+ (instancetype _Nullable )shareInstance;

- (void)resultData:(NSDictionary *_Nullable)dict;
- (void)showResultLog:(id __nullable)showResult;
- (void)showResultMsg:(id __nullable)showResult msg: (NSString*_Nullable)msg;

@end
