package com.sean.rao.fusion_auth;

import androidx.annotation.NonNull;

import com.alibaba.fastjson2.JSONObject;
import com.sean.rao.fusion_auth.utils.FusionConstant;
import com.sean.rao.fusion_auth.utils.FusionAuthUtil;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FusionAuthPlugin */
public class FusionAuthPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "fusion_auth");
    channel.setMethodCallHandler(this);
    FusionAuthUtil.getInstance().setChannel(channel);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method){
      case FusionConstant.VERSION:
        FusionAuthUtil.getInstance().getVersion();
        break;
      case FusionConstant.INIT:
        // 设置参数
        FusionAuthUtil.getInstance().setCONFIG(JSONObject.from(call.arguments));
        FusionAuthUtil.getInstance().initAlicomFusionSdk();
        break;
      case FusionConstant.LOGIN:
        FusionAuthUtil.getInstance().login();
        break;
      case FusionConstant.UPDATE_TOKEN:
        result.success("Android3 " + android.os.Build.VERSION.RELEASE);
        break;
      case FusionConstant.DISPOSE:
        result.success("Android4 " + android.os.Build.VERSION.RELEASE);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
