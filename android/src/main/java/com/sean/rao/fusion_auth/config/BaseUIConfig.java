package com.sean.rao.fusion_auth.config;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.graphics.Color;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.Surface;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.Space;
import android.widget.TextView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hjq.toast.Toaster;
import com.mobile.auth.gatewayauth.AuthUIConfig;
import com.mobile.auth.gatewayauth.PhoneNumberAuthHelper;
import com.sean.rao.fusion_auth.common.Constant;
import com.sean.rao.fusion_auth.common.LoginParams;
import com.sean.rao.fusion_auth.utils.AppUtils;
import com.sean.rao.fusion_auth.utils.UtilTool;

import java.io.IOException;

import io.flutter.plugin.common.EventChannel;

public abstract class BaseUIConfig extends LoginParams {
    public Activity mActivity;
    public Context mContext;
    public PhoneNumberAuthHelper mAuthHelper;
    public int mScreenWidthDp;
    public int mScreenHeightDp;
    public AuthUIConfig.Builder autoConfig;
    public EventChannel.EventSink eventSink;
    public JSONObject jsonObject;

    public static BaseUIConfig init(int type, Activity activity, EventChannel.EventSink _eventSink, JSONObject jsonObject, AuthUIConfig.Builder config, PhoneNumberAuthHelper authHelper) {
        isChecked = false;
        switch (type) {
            case Constant.FULL_PORT:
                return new FullPortConfig(activity, _eventSink, jsonObject, config, authHelper);
            case Constant.FULL_LAND:
                return new FullLandConfig(activity, _eventSink, jsonObject, config, authHelper);
            case Constant.DIALOG_PORT:
                return new DialogPortConfig(activity, _eventSink, jsonObject, config, authHelper);
            case Constant.DIALOG_LAND:
                return new DialogLandConfig(activity, _eventSink, jsonObject, config, authHelper);
            case Constant.DIALOG_BOTTOM:
                return new DialogBottomConfig(activity, _eventSink, jsonObject, config, authHelper);
            case Constant.CUSTOM_XML:
                return new CustomXmlConfig(activity, _eventSink, jsonObject, config, authHelper);
            default:
                if (jsonObject.getString("backgroundPath") != null && !jsonObject.getString("backgroundPath").equals("")) {
                    if (jsonObject.getString("backgroundPath").equals("xml")) {
                        return new CustomXmlConfig(activity, _eventSink, jsonObject, config, authHelper);
                    } else if (jsonObject.getString("backgroundPath").equals("view")) {
                        return new CustomViewConfig(activity, _eventSink, jsonObject, config, authHelper);
                    } else {
                        return new CustomAssetsConfig(activity, jsonObject, _eventSink, config, authHelper);
                    }
                }
                return null;
        }
    }

    public BaseUIConfig(Activity activity, EventChannel.EventSink _eventSink, JSONObject _jsonObject, AuthUIConfig.Builder config, PhoneNumberAuthHelper authHelper) {
        mActivity = activity;
        mContext = activity.getApplicationContext();
        mAuthHelper = authHelper;
        autoConfig = config;
        eventSink = _eventSink;
        jsonObject = _jsonObject;

        // 防止内存泄漏
        clearCustomConfig();
    }

    /**
     * 第三方布局设置
     * @param marginTop
     * @return
     */
    protected View initSwitchView(int marginTop) {
        JSONObject customThirdView = jsonObject.getJSONObject("customThirdView");
        /// 名称列表
        JSONArray customThirdViewName = customThirdView.getJSONArray("viewItemName");
        /// 图片路径列表
        JSONArray customThirdViewItem = customThirdView.getJSONArray("viewItemPath");
        if (customThirdViewName != null && customThirdViewItem != null) {
            LinearLayout linearLayout = new LinearLayout(mContext);
            // 创建一个最大宽度和适量高度的布局
            LinearLayout.LayoutParams LayoutParams = new LinearLayout.LayoutParams(
                    customThirdView.getFloatValue("width") > 0 ? AppUtils.dp2px(mContext, customThirdView.getFloatValue("width")) : LinearLayout.LayoutParams.MATCH_PARENT,
                    customThirdView.getFloatValue("height") > 0 ? AppUtils.dp2px(mContext, customThirdView.getFloatValue("height")) : LinearLayout.LayoutParams.WRAP_CONTENT
            );

            // 居中边距
            LayoutParams.setMargins(
                    AppUtils.dp2px(mContext, customThirdView.getFloatValue("left") > 0 ? customThirdView.getFloatValue("left") : 10),
                    AppUtils.dp2px(mContext, customThirdView.getFloatValue("top") > 0 ? customThirdView.getFloatValue("top") : marginTop),
                    AppUtils.dp2px(mContext, customThirdView.getFloatValue("right") > 0 ? customThirdView.getFloatValue("right") : 10),
                    AppUtils.dp2px(mContext, customThirdView.getFloatValue("bottom") > 0 ? customThirdView.getFloatValue("bottom") : 10)
            );
            linearLayout.setLayoutParams(LayoutParams);
            linearLayout.setOrientation(LinearLayout.HORIZONTAL);
            linearLayout.setGravity(Gravity.CENTER_HORIZONTAL);

            for (int i = 0; i < customThirdViewItem.size(); i++) {
                if (customThirdViewItem.get(i) != null && !String.valueOf(customThirdViewItem.get(i)).isEmpty()) {
                    int finalI = i;
                    /// 每个item布局
                    LinearLayout itemLinearLayout = new LinearLayout(mContext);
                    /// 按钮和文字布局
                    itemLinearLayout.setOrientation(LinearLayout.VERTICAL);

                    /// 按钮控件
                    ImageButton itemButton = new ImageButton(mActivity);
                    /// 需要转化路径
                    try {
                        itemButton.setBackground(
                                UtilTool.getBitmapToBitmapDrawable(
                                        mContext,
                                        UtilTool.flutterToPath(String.valueOf(customThirdViewItem.get(i)))
                                )
                        );
                    } catch (IOException e) {
                        eventSink.success(UtilTool.resultFormatData("500000", null, e.getMessage()));
                    }
                    ViewGroup.LayoutParams buttonLayoutParams = new ViewGroup.LayoutParams(
                            AppUtils.dp2px(mContext, customThirdView.getFloatValue("itemWidth") > 0 ? customThirdView.getFloatValue("itemWidth") : 60),
                            AppUtils.dp2px(mContext, customThirdView.getFloatValue("itemHeight") > 0 ? customThirdView.getFloatValue("itemHeight") : 60)
                    );
                    itemButton.setLayoutParams(buttonLayoutParams);

                    /// 第三方按钮的点击事件
                    itemButton.setOnClickListener(v -> {
                        // 判断是否隐藏toast
                        eventSink.success(UtilTool.resultFormatData("600019", null, finalI));
                        if (!jsonObject.getBooleanValue("isHideToast") && !isChecked) {
                            Toaster.show(jsonObject.getString("toastText"));
                            return;
                        }
                        if (jsonObject.getBooleanValue("autoQuitPage")) {
                            mAuthHelper.quitLoginPage();
                        }
                    });
                    itemLinearLayout.addView(itemButton);


                    Object itemName = customThirdViewName.get(i);
                    if (itemName != null && !String.valueOf(itemName).isEmpty()) {
                        // 按钮下文字控件
                        TextView textView = new TextView(mContext);
                        textView.setText(String.valueOf(itemName));
                        // 文字颜色
                        textView.setTextColor(customThirdView.getString("color") != null && customThirdView.getString("color").isEmpty() ? Color.parseColor(customThirdView.getString("color")) : Color.BLACK);
                        textView.setTextSize(
                                TypedValue.COMPLEX_UNIT_SP,
                                customThirdView.getFloatValue("size") > 0 ? customThirdView.getFloatValue("size") : 14F
                        );
                        textView.setGravity(Gravity.CENTER);
                        itemLinearLayout.addView(textView);
                    }

                    /// 新增按钮间距控件
                    if (i > 0 && i < customThirdViewItem.size()) {
                        Space space = new Space(mContext);
                        space.setLayoutParams(new ViewGroup.LayoutParams(
                                AppUtils.dp2px(mContext, customThirdView.getFloatValue("space") > 0 ? customThirdView.getFloatValue("space") : 10),
                                LinearLayout.LayoutParams.MATCH_PARENT)
                        );
                        linearLayout.addView(space);
                    }

                    /// 将item放入布局中
                    linearLayout.addView(itemLinearLayout);
                }
            }

            return linearLayout;
        } else {
            return null;
        }
    }

    /**
     * 删除自定义布局参数，防止内存溢出
     */
    void clearCustomConfig(){
        mAuthHelper.removeAuthRegisterXmlConfig();
        mAuthHelper.removeAuthRegisterViewConfig();
    }

    /**
     * 更新屏幕
     * @param authPageScreenOrientation
     */
    protected void updateScreenSize(int authPageScreenOrientation) {
        int screenHeightDp = AppUtils.px2dp(mContext, AppUtils.getPhoneHeightPixels(mContext));
        int screenWidthDp = AppUtils.px2dp(mContext, AppUtils.getPhoneWidthPixels(mContext));
        int rotation = mActivity.getWindowManager().getDefaultDisplay().getRotation();
        if (authPageScreenOrientation == ActivityInfo.SCREEN_ORIENTATION_BEHIND) {
            authPageScreenOrientation = mActivity.getRequestedOrientation();
        }
        if (authPageScreenOrientation == ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE
                || authPageScreenOrientation == ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE
                || authPageScreenOrientation == ActivityInfo.SCREEN_ORIENTATION_USER_LANDSCAPE) {
            rotation = Surface.ROTATION_90;
        } else if (authPageScreenOrientation == ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
                || authPageScreenOrientation == ActivityInfo.SCREEN_ORIENTATION_SENSOR_PORTRAIT
                || authPageScreenOrientation == ActivityInfo.SCREEN_ORIENTATION_USER_PORTRAIT) {
            rotation = Surface.ROTATION_180;
        }
        switch (rotation) {
            case Surface.ROTATION_0:
            case Surface.ROTATION_180:
                mScreenWidthDp = screenWidthDp;
                mScreenHeightDp = screenHeightDp;
                break;
            case Surface.ROTATION_90:
            case Surface.ROTATION_270:
                mScreenWidthDp = screenHeightDp;
                mScreenHeightDp = screenWidthDp;
                break;
            default:
                break;
        }
    }

    public abstract void configAuthPage();

    private void configBuild(){}

    /**
     *  在横屏APP弹竖屏一键登录页面或者竖屏APP弹横屏授权页时处理特殊逻辑
     *  Android8.0只能启动SCREEN_ORIENTATION_BEHIND模式的Activity
     */
    public void onResume() {
    }
}
