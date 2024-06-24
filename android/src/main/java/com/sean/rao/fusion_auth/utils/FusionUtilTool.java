package com.sean.rao.fusion_auth.utils;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.StateListDrawable;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.WindowManager;

import com.alibaba.fastjson2.JSONObject;
import com.sean.rao.fusion_auth.net.HttpRequestUtil;
import com.sean.rao.fusion_auth.net.VerifyTokenModel;
import com.sean.rao.fusion_auth.net.VerifyTokenResult;

import org.jetbrains.annotations.Nullable;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.loader.FlutterLoader;
import io.flutter.plugin.common.MethodCall;
/**
 * @ProjectName: android
 * @Package: com.sean.rao.ali_auth.utils
 * @ClassName: UtilTool
 * @Description: java类作用描述
 * @Author: liys
 * @CreateDate: 5/11/22 3:33 PM
 * @UpdateUser: 更新者
 * @UpdateDate: 5/11/22 3:33 PM
 * @UpdateRemark: 更新说明
 * @Version: 1.0
 */
public class FusionUtilTool {
  public static VerifyTokenResult verifyToken(Context mContext, String token){
    VerifyTokenResult verifyTokenResult = null;
    if(token != null){
      Log.d("verifyToken", "获取到认证token:"+token+", 请到https://next.api.aliyun.com/api/Dypnsapi/2017-05-25/VerifyWithFusionAuthToken 校验结果，Demo默认校验已成功，流程结束，展示默认手机号码18888888888");
      verifyTokenResult=new VerifyTokenResult();
      VerifyTokenModel model=new VerifyTokenModel();
      model.setPhoneNumber("18888888888");
      model.setVerifyResult("PASS");
      model.setPhoneScore(0);
      verifyTokenResult.setData(model);
      verifyTokenResult.setCode("OK");
      verifyTokenResult.setSuccess(true);
      verifyTokenResult.setRequestId(UUID.randomUUID().toString());
    }else if(mContext != null){
      verifyTokenResult = HttpRequestUtil.verifyToken(mContext, token);
    }
    return verifyTokenResult;
  }

  /**
   * 判断数据类型
   * @param data
   * @param key
   * @return
   */
  public static boolean dataStatus(JSONObject data, String key ){
    if(data.containsKey(key) && data.get(key) != null){
      if((data.get(key) instanceof Float) || (data.get(key) instanceof Double) && (double) data.get(key) > -1){
        return true;
      } else if((data.get(key) instanceof Integer) || (data.get(key) instanceof Number) && (int) data.get(key) > -1){
        return true;
      } else if((data.get(key) instanceof Boolean) && (boolean) data.get(key)){
        return true;
      } else if((data.get(key) instanceof String) && !((String) data.get(key)).equals("")){
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  public static int dp2px(Context context, float dipValue) {
    try {
      final float scale = context.getResources().getDisplayMetrics().density;
      return (int) (dipValue * scale + 0.5f);
    } catch (Exception e) {
      return (int) dipValue;
    }
  }

  public static int px2dp(Context context, float px) {
    try {
      final float scale = context.getResources().getDisplayMetrics().density;
      return (int) (px / scale + 0.5f);
    } catch (Exception e) {
      return (int) px;
    }
  }

  public static int getPhoneWidthPixels(Context context) {
    WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
    DisplayMetrics var2 = new DisplayMetrics();
    if (wm != null) {
      wm.getDefaultDisplay().getMetrics(var2);
    }

    return var2.widthPixels;
  }

  public static int getPhoneHeightPixels(Context context) {
    WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
    DisplayMetrics var2 = new DisplayMetrics();
    if (wm != null) {
      wm.getDefaultDisplay().getMetrics(var2);
    }

    return var2.heightPixels;
  }

  public static String getPackageName(Context mContext){
    String packageName="";
    try {
      PackageManager packageManager = mContext.getPackageManager();
      PackageInfo packageInfo = packageManager.getPackageInfo(mContext.getPackageName(), 0);
      packageName = packageInfo.packageName;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return packageName;
  }

  /**
   * flutter 路径转换
   * @param fluPath
   * @return
   */
  public static String flutterToPath(@Nullable Object fluPath){
    FlutterLoader flutterLoader = FlutterInjector.instance().flutterLoader();
    return flutterLoader.getLookupKeyForAsset(String.valueOf(fluPath));
  }

  /**
   * 获取key
   * @param call
   * @param key
   * @return
   */
  public static Object getValueByKey(MethodCall call, String key) {
    if (call != null && call.hasArgument(key)) {
      return call.argument(key);
    } else {
      return null;
    }
  }

  /**
   * 创建有状态的按钮
   * @param mContext
   * @param btnPathImage
   * @return
   */
  public static Drawable getStateListDrawable(Context mContext, String btnPathImage) {
    StateListDrawable stateListDrawable = new StateListDrawable();
    if (!btnPathImage.contains(",")) {
      return stateListDrawable;
    }
    try{
      List<String> btnPathList = Arrays.asList(btnPathImage.split(","));
      // 正常状态下的Drawable
      BitmapDrawable drawable_p = getBitmapToBitmapDrawable(mContext, flutterToPath(btnPathList.get(0)));
      // 按下和获取焦点是的Drawable
      BitmapDrawable drawable_n = getBitmapToBitmapDrawable(mContext, flutterToPath(btnPathList.get(1)));
      // 被禁用时的Drawable
      BitmapDrawable drawable_b = getBitmapToBitmapDrawable(mContext, flutterToPath(btnPathList.get(2)));

      stateListDrawable.addState(new int[]{android.R.attr.state_activated, android.R.attr.state_pressed}, drawable_n);
      stateListDrawable.addState(new int[]{android.R.attr.state_activated, -android.R.attr.state_pressed}, drawable_p);
      stateListDrawable.addState(new int[]{-android.R.attr.state_activated, -android.R.attr.state_pressed}, drawable_b);
      stateListDrawable.addState(new int[]{-android.R.attr.state_activated, android.R.attr.state_pressed}, drawable_n);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return stateListDrawable;
  }

  /**
   * 将bitmap数据转换为drawable
   * @param mContext
   * @param path
   * @return
   */
  public static BitmapDrawable getBitmapToBitmapDrawable(Context mContext, String path) throws IOException {
    // 正常状态下的Drawable
    return new BitmapDrawable(mContext.getResources(), getPathToBitmap(mContext, path));
  }

  /**
   * 获取本地图片转换为bitmap
   * @param mContext
   * @param path
   * @return
   */
  public static Bitmap getPathToBitmap(Context mContext, String path) throws IOException {
    AssetManager assetManager = mContext.getAssets();
    InputStream fileDescriptor = assetManager.open(path);
    Bitmap bitmap = BitmapFactory.decodeStream(fileDescriptor);
    return bitmap;
  }

  /**
   * 返回数据封装
   * @param code
   * @param msg
   * @param jsonDataObj
   * @return
   */
  public static JSONObject resultFormatData(String code, @Nullable String msg, @Nullable Object jsonDataObj){
    JSONObject jsonObj = new JSONObject();
    jsonObj.put("code", code);
    jsonObj.put("data", jsonDataObj);
//    jsonObj.put("msg", msg != null && !msg.isEmpty() ? msg : StatusAll.getName(code));
    return jsonObj;
  }

}
