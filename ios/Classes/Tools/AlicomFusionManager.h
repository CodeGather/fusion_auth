//
//  AlicomFusionMananer.h
//  AlicomFusionAuthDemo
//
//  Created by yanke on 2023/2/13.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "AlicomFusionManager.h"
#import <AlicomFusionAuth/AlicomFusionAuth.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AlicomFusionManagerDelegate <NSObject>

@optional
- (void)verifySuccess;

@end

@interface AlicomFusionManager : NSObject<AlicomFusionAuthDelegate, AlicomFusionAuthUIDelegate>

+ (instancetype)shareInstance;

@property (nonatomic,nullable, strong) AlicomFusionAuthHandler *handler;
@property (nonatomic, assign) BOOL isActive;
@property(nonatomic, weak) id<AlicomFusionManagerDelegate>delegate;     


- (void)start;

- (void)startSceneWithTemplateId:(NSString *)templateId viewController:(UIViewController *)controller;

- (void)stopScene;

- (void)destory;

@end

NS_ASSUME_NONNULL_END
