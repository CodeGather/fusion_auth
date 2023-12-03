[![Pub](https://img.shields.io/pub/v/fusion_auth.svg)](https://pub.flutter-io.cn/packages/fusion_auth)
![GitHub Workflow Status](https://github.com/CodeGather/fusion_auth/actions)


[![GitHub license](https://img.shields.io/github/license/CodeGather/flutter_ali_auth?style=social)](https://github.com/CodeGather/flutter_ali_auth/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/CodeGather/flutter_ali_auth?style=social)](https://github.com/CodeGather/flutter_ali_auth/issues)
[![GitHub forks](https://img.shields.io/github/forks/CodeGather/flutter_ali_auth?style=social)](https://github.com/CodeGather/flutter_ali_auth/network)
[![GitHub stars](https://img.shields.io/github/stars/CodeGather/flutter_ali_auth?style=social)](https://github.com/CodeGather/flutter_ali_auth/stargazers)
[![GitHub size](https://img.shields.io/github/repo-size/CodeGather/flutter_ali_auth?style=social)](https://github.com/CodeGather/flutter_ali_auth)
[![GitHub release](https://img.shields.io/github/v/release/CodeGather/flutter_ali_auth?style=social)](https://github.com/CodeGather/flutter_ali_auth/releases)

## 名称 Fusion_auth

基于阿里云号码认证服务中融合认证SDK的 **Flutter插件**

## 插件

|    platform  | support  |                                          version                                          |
| :------:|:----:|:-----------------------------------------------------------------------------------------:|
| Android  | YES | [V1.0.8](https://help.aliyun.com/zh/pnvs/developer-reference/the-android-client-access-3) |
| Ios      | YES |   [V1.0.8](https://help.aliyun.com/zh/pnvs/developer-reference/the-ios-client-access-3)   |

## 目录
* [效果图](#效果图-)
    * [IOS](#IOS)
    * [Android](#Android)
* [准备工作](#准备工作-)
* [原生SDK代码调用顺序](##先了解原生sdk代码调用顺序-)
* [插件使用](#插件使用-%EF%B8%8F)
    * [添加监听](#1-添加监听)
    * [初始化SDK配置密钥与UI](#2初始化sdk-initsdk)
    * [检查环境](#3一键登录获取token-login)
    * [预取号](#4检查认证环境-checkverifyenable)
    * [调起授权页面，获取Token](#5一键登录预取号-accelerateloginpage)
* [注意事项](#注意事项-%EF%B8%8F)

## 准备工作

 - 请登录阿里云控制台 [号码认证服务->融合认证](https://dypns.console.aliyun.com/fusionSolution/All)
 - 开通融合认证服务
 - 创建认证方案 分别添IOS和Android的认证方案，分别获取到方案Code。
 - 添加短信模版、签名

 - ## 注意：Ios只需要输入绑定`Bundle name`即可，Android则需要包名和和签名。[如何获取App的签名](https://help.aliyun.com/document_detail/87870.html) ##
