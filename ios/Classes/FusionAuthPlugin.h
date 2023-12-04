#import <Flutter/Flutter.h>
#import "FusionAuthCommon.h"

@interface FusionAuthPlugin : NSObject<FlutterPlugin>
@property(nonatomic, strong) FlutterMethodChannel * methodChannel;
@property(nonatomic, assign) id httpAuthority;
@end
