//
//  AlicomFusionWebViewController.m
//  AlicomFusionAuthDemo
//
//  Created by shenchao12344 on 2023/2/22.
//

#import "FusionAuthPlugin.h"
#import "AlicomFusionSampleController.h"
#import <WebKit/WebKit.h>


@implementation AlicomFusionSampleController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"AlicomFusionSampleController touchesBegan. next: %@", @999);
    [super touchesBegan:touches withEvent:event];
}

@end
