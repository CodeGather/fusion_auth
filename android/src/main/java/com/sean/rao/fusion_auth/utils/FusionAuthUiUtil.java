package com.sean.rao.fusion_auth.utils;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.os.Build;
import android.os.Looper;
import android.util.Log;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Space;
import android.widget.TextView;

import androidx.annotation.RequiresApi;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.alicom.fusion.auth.AlicomFusionAuthCallBack;
import com.alicom.fusion.auth.AlicomFusionAuthUICallBack;
import com.alicom.fusion.auth.AlicomFusionBusiness;
import com.alicom.fusion.auth.HalfWayVerifyResult;
import com.alicom.fusion.auth.error.AlicomFusionEvent;
import com.alicom.fusion.auth.numberauth.FusionNumberAuthModel;
import com.alicom.fusion.auth.smsauth.AlicomFusionVerifyCodeView;
import com.alicom.fusion.auth.token.AlicomFusionAuthToken;
import com.alicom.fusion.auth.upsms.AlicomFusionUpSMSView;
import com.mobile.auth.gatewayauth.AuthRegisterViewConfig;
import com.mobile.auth.gatewayauth.AuthRegisterXmlConfig;
import com.mobile.auth.gatewayauth.CustomInterface;
import com.nirvana.tools.core.ExecutorManager;

import java.io.IOException;
import java.util.concurrent.CountDownLatch;

import io.flutter.plugin.common.MethodChannel;

/**
 * @Package: com.alicom.fusion.demo
 * @Description:
 * @CreateDate: 2023/2/15
 */
public class FusionAuthUiUtil {
    public static Activity mActivity;
    public static Context mContext;
    public static JSONObject CONFIG;
    public static AlicomFusionBusiness mAlicomFusionBusiness;
    public static AlicomFusionAuthCallBack mAlicomFusionAuthCallBack;

    protected View initTestView(int marginTop) {
        TextView switchTV = new TextView(mActivity);
        RelativeLayout.LayoutParams mLayoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        //一键登录按钮默认marginTop 270dp
        mLayoutParams.setMargins(0, FusionUtilTool.dp2px(mActivity, marginTop), 0, 0);
        mLayoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL, RelativeLayout.TRUE);
        switchTV.setText("其他登录");
        switchTV.setTextColor(Color.BLACK);
        switchTV.setTextSize(TypedValue.COMPLEX_UNIT_SP, 13.0F);
        switchTV.setLayoutParams(mLayoutParams);
        return switchTV;
    }

    /**
     * 第三方布局设置
     * @param marginTop
     * @return
     */
    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    protected View initSwitchView(int marginTop) {
        JSONObject customThirdView = CONFIG.getJSONObject("customThirdView");
        if (customThirdView == null) { return null; }
        /// 名称列表
        JSONArray customThirdViewName = customThirdView.getJSONArray("viewItemName");
        /// 图片路径列表
        JSONArray customThirdViewItem = customThirdView.getJSONArray("viewItemPath");
        if (customThirdViewName != null && customThirdViewItem != null) {
            LinearLayout linearLayout = new LinearLayout(mContext);
            // 创建一个最大宽度和适量高度的布局
            LinearLayout.LayoutParams LayoutParams = new LinearLayout.LayoutParams(
                    customThirdView.getFloatValue("width") > 0 ? FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("width")) : LinearLayout.LayoutParams.MATCH_PARENT,
                    customThirdView.getFloatValue("height") > 0 ? FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("height")) : LinearLayout.LayoutParams.WRAP_CONTENT
            );

            // 居中边距
            LayoutParams.setMargins(
                    FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("left") > 0 ? customThirdView.getFloatValue("left") : 10),
                    FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("top") > 0 ? customThirdView.getFloatValue("top") : marginTop),
                    FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("right") > 0 ? customThirdView.getFloatValue("right") : 10),
                    FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("bottom") > 0 ? customThirdView.getFloatValue("bottom") : 10)
            );
            linearLayout.setLayoutParams(LayoutParams);
            linearLayout.setOrientation(LinearLayout.HORIZONTAL);
            linearLayout.setGravity(Gravity.CENTER_HORIZONTAL);

            for (int i = 0; i < customThirdViewItem.size(); i++) {
                if (customThirdViewItem.get(i) != null && String.valueOf(customThirdViewItem.get(i)).isEmpty()) {
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
                                FusionUtilTool.getBitmapToBitmapDrawable(
                                        mContext,
                                        FusionUtilTool.flutterToPath(String.valueOf(customThirdViewItem.get(i)))
                                )
                        );
                    } catch (IOException e) {
                        // eventSink.success(UtilTool.resultFormatData("500000", null, e.getMessage()));
                        //showResult("500000", "出现错误", e.getMessage());
                    }
                    ViewGroup.LayoutParams buttonLayoutParams = new ViewGroup.LayoutParams(
                            FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("itemWidth") > 0 ? customThirdView.getFloatValue("itemWidth") : 60),
                            FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("itemHeight") > 0 ? customThirdView.getFloatValue("itemHeight") : 60)
                    );
                    itemButton.setLayoutParams(buttonLayoutParams);

                    /// 第三方按钮的点击事件
                    itemButton.setOnClickListener(v -> {
                        // 判断是否隐藏toast
//                        showResult("700005", "点击第三方登录按钮", finalI);
//                        // eventSink.success(UtilTool.resultFormatData("600019", null, finalI));
//                        if (!CONFIG.getBooleanValue("isHideToast") && !isChecked) {
//                            Toaster.show(CONFIG.getString("toastText"));
//                            return;
//                        }
                    });
                    itemLinearLayout.addView(itemButton);
                    Object itemName = customThirdViewName.get(i);
                    if (itemName != null && !String.valueOf(itemName).isEmpty()) {
                        // 按钮下文字控件
                        TextView textView = new TextView(mContext);
                        textView.setText(String.valueOf(itemName));
                        // 文字颜色
                        textView.setTextColor(customThirdView.getString("color") != null && !customThirdView.getString("color").isEmpty() ? Color.parseColor(customThirdView.getString("color")) : Color.BLACK);
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
                                FusionUtilTool.dp2px(mContext, customThirdView.getFloatValue("space") > 0 ? customThirdView.getFloatValue("space") : 10),
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
}
