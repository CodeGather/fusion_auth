[![Pub](https://img.shields.io/pub/v/fusion_auth.svg)](https://pub.flutter-io.cn/packages/fusion_auth)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/CodeGather/fusion_auth/publish.yml)


[![GitHub license](https://img.shields.io/github/license/CodeGather/fusion_auth?style=social)](https://github.com/CodeGather/fusion_auth/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/CodeGather/fusion_auth?style=social)](https://github.com/CodeGather/fusion_auth/issues)
[![GitHub forks](https://img.shields.io/github/forks/CodeGather/fusion_auth?style=social)](https://github.com/CodeGather/fusion_auth/network)
[![GitHub stars](https://img.shields.io/github/stars/CodeGather/fusion_auth?style=social)](https://github.com/CodeGather/fusion_auth/stargazers)
[![GitHub size](https://img.shields.io/github/repo-size/CodeGather/fusion_auth?style=social)](https://github.com/CodeGather/fusion_auth)
[![GitHub release](https://img.shields.io/github/v/release/CodeGather/fusion_auth?style=social)](https://github.com/CodeGather/fusion_auth/releases)

## 目录
* [插件名称](#插件名称)
* [插件版本](#插件版本)
* [效果图](#效果图)
    * [IOS](#IOS)
    * [Android](#Android)
* [集成步骤](##集成步骤)
* [准备工作](#准备工作)
* [插件使用](#插件使用)
    * [添加监听](#1-添加监听)
    * [初始化SDK配置密钥与UI](#2初始化sdk-initsdk)
    * [检查环境](#3一键登录获取token-login)
    * [预取号](#4检查认证环境-checkverifyenable)
    * [调起授权页面，获取Token](#5一键登录预取号-accelerateloginpage)
* [注意事项](#注意事项)
* [打赏-技术支持](#打赏-技术支持)


## 插件名称

Fusion_auth是基于阿里云号码认证服务中融合认证SDK的Flutter插件 **请注意如遇问题请先下载源码跑DEMO，如果还是有问题，请提issues**,

## 插件版本

| platform | support |                                          version                                          |
|:--------:|:-------:|:-----------------------------------------------------------------------------------------:|
| Android  |   YES   | [V1.0.8](https://help.aliyun.com/zh/pnvs/developer-reference/the-android-client-access-3) |
|   Ios    |   YES   |   [V1.0.8](https://help.aliyun.com/zh/pnvs/developer-reference/the-ios-client-access-3)   |

## 效果图

### IOS

| 全屏                      | 底部弹窗               | 中间弹窗                   |
|-------------------------|--------------------|------------------------|
| ![]( "full_screen_ios") | ![]( "dialog_ios") | ![]( "bottomShot_ios") |

### Android

| 全屏                          | 底部弹窗                   | 中间弹窗                       |
|-----------------------------|------------------------|----------------------------|
| ![]( "full_screen_android") | ![]( "dialog_android") | ![]( "bottomShot_android") |

## 集成步骤

  - 1、集成阿里云SDK到客户端中，初始化并调用阿里云SDK。
  - 2、对接阿里云API接口 [GetFusionAuthToken](https://help.aliyun.com/zh/pnvs/developer-reference/api-dypnsapi-2017-05-25-getfusionauthtoken) -> 融合认证获取鉴权Token，下发至客户端后传入SDK进行鉴权。
  - 3、唤起场景授权页面，部分场景需要用户授权（同意隐私协议、获取短信验证码等）。
  - 4、用户授权后，从SDK回调接口获取到换号Token后, 上传到开发者的服务器
  - 5、对接阿里云的服务端API接口 [VerifyWithFusionAuthToken](https://help.aliyun.com/document_detail/2384478.html) -> 融合认证获取认证结果，将Token转换为用户的手机号。

## 准备工作

 - 请登录阿里云控制台 [号码认证服务->融合认证](https://dypns.console.aliyun.com/fusionSolution/All)
 - 开通融合认证服务
 - 创建认证方案 分别添IOS和Android的认证方案，分别获取到方案Code。
   - IOS只需要输入绑定`Bundle name`即可，
   - Android则需要包名和和签名。[如何获取App的签名](https://help.aliyun.com/document_detail/87870.html) 
 - 添加短信模版、签名 (** 注意如果认证策略没有添加短信可以不添加 **)
   - [添加短信签名](https://dysms.console.aliyun.com/domestic/text/sign/add) 
   - [添加短信模版](https://dysms.console.aliyun.com/domestic/text/template/add) 

## 插件使用

## 注意事项

## 打赏-技术支持
| Wechat                                                                                        | Alipay                                                                                        |
|-----------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| ![](https://github.com/CodeGather/fusion_auth/blob/main/screenshots/play_wechat.jpg "Wechat") | ![](https://github.com/CodeGather/fusion_auth/blob/main/screenshots/play_alipay.jpg "Alipay") |
