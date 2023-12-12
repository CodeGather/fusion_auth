package com.sean.rao.fusion_auth;

import androidx.annotation.NonNull;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.sean.rao.fusion_auth.common.GlobalManager;
import com.sean.rao.fusion_auth.utils.FusionAuthUtils;

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
    FusionAuthUtils.getInstance().setChannel(channel);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method){
      case "getVersion":
        FusionAuthUtils.getInstance().getVersion();
        break;
      case "initSdk":
        FusionAuthUtils.getInstance().setCONFIG(JSON.to(JSONObject.class, call.arguments));
        result.success("Android1 " + android.os.Build.VERSION.RELEASE);
        break;
      case "login":
        result.success("Android2 " + android.os.Build.VERSION.RELEASE);
        break;
      case "updateToken":
        result.success("Android3 " + android.os.Build.VERSION.RELEASE);
        break;
      case "dispose":
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
