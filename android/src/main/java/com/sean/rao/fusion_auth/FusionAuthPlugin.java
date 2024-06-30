package com.sean.rao.fusion_auth;

import android.app.Activity;
import android.content.Context;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.alibaba.fastjson2.JSONObject;
import com.sean.rao.fusion_auth.utils.FusionConstant;
import com.sean.rao.fusion_auth.utils.FusionAuthUtil;

import java.lang.ref.WeakReference;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FusionAuthPlugin FlutterPlugin, ActivityAware, MethodCallHandler, EventChannel.StreamHandler */

@RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
public class FusionAuthPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private FusionAuthClient fusionAuthClient;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    MethodChannel methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), FusionConstant.METHODKEY);
    fusionAuthClient = FusionAuthClient.getInstance();
    fusionAuthClient.setMethodChannel(methodChannel);
    methodChannel.setMethodCallHandler(this);
    fusionAuthClient.setFlutterPluginBinding(flutterPluginBinding);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method){
      case FusionConstant.VERSION:
        fusionAuthClient.getVersion();
        break;
      case FusionConstant.INIT:
        // 设置参数
        fusionAuthClient.initAlicomFusionSdk(JSONObject.from(call.arguments));
        break;
      case FusionConstant.LOGIN:
        fusionAuthClient.login();
        break;
      case FusionConstant.UPDATE_TOKEN:
        fusionAuthClient.updateToken(call.argument("token"));
        break;
      case FusionConstant.DISPOSE:
        result.success("Android4 " + android.os.Build.VERSION.RELEASE);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    WeakReference<Activity> activityWeakReference = new WeakReference<>(binding.getActivity());
    fusionAuthClient.setActivity(activityWeakReference);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {}

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {}

  @Override
  public void onDetachedFromActivity() {
    fusionAuthClient.setFlutterPluginBinding(null);
    fusionAuthClient.getMethodChannel().setMethodCallHandler(null);
    fusionAuthClient.setActivity(null);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    fusionAuthClient.setFlutterPluginBinding(null);
    fusionAuthClient.getMethodChannel().setMethodCallHandler(null);
  }
}
