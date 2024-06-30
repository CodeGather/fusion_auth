package com.sean.rao.fusion_auth;

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

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.alicom.fusion.auth.AlicomFusionAuthCallBack;
import com.alicom.fusion.auth.AlicomFusionAuthUICallBack;
import com.alicom.fusion.auth.AlicomFusionBusiness;
import com.alicom.fusion.auth.HalfWayVerifyResult;
import com.alicom.fusion.auth.error.AlicomFusionEvent;
import com.alicom.fusion.auth.numberauth.FusionNumberAuthModel;
import com.alicom.fusion.auth.smsauth.AlicomFusionInputView;
import com.alicom.fusion.auth.smsauth.AlicomFusionVerifyCodeView;
import com.alicom.fusion.auth.token.AlicomFusionAuthToken;
import com.alicom.fusion.auth.upsms.AlicomFusionUpSMSView;
import com.mobile.auth.gatewayauth.AuthRegisterViewConfig;
import com.mobile.auth.gatewayauth.AuthRegisterXmlConfig;
import com.mobile.auth.gatewayauth.CustomInterface;
import com.sean.rao.fusion_auth.net.VerifyTokenResult;
import com.sean.rao.fusion_auth.utils.FusionAuthUiUtil;
import com.sean.rao.fusion_auth.utils.FusionConstant;
import com.sean.rao.fusion_auth.utils.FusionUtilTool;
import com.sean.rao.fusion_auth.utils.TokenActionFactory;

import java.io.IOException;
import java.lang.ref.WeakReference;
import java.util.concurrent.CountDownLatch;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

/**
 * @Package: com.alicom.fusion.demo
 * @Description:
 * @CreateDate: 2023/2/15
 */
@RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
public class FusionAuthClient {
    private static final String TAG = "FusionAuthClient";

    private WeakReference<Activity> mActivity;
    private FlutterPlugin.FlutterPluginBinding flutterPluginBinding;

    public static JSONObject CONFIG;
    private AlicomFusionAuthUICallBack uiCallBack;
    public static AlicomFusionBusiness mAlicomFusionBusiness;
    public static AlicomFusionAuthCallBack mAlicomFusionAuthCallBack;

    private MethodChannel methodChannel;
    private static volatile FusionAuthClient instance;
    //Singleton
    private FusionAuthClient() {
    }
    public static FusionAuthClient getInstance() {
        if (instance == null) {
            synchronized (FusionAuthClient.class) {
                if (instance == null) {
                    instance = new FusionAuthClient();
                }
            }
        }
        return instance;
    }

    public void setActivity(WeakReference<Activity> activity) {
        this.mActivity = activity;
    }
    public void setFlutterPluginBinding(FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding;
    }
    public void setMethodChannel(MethodChannel channel) {
        this.methodChannel = channel;
    }
    public MethodChannel getMethodChannel() {
        return this.methodChannel;
    }

    public void initAlicomFusionSdk(JSONObject option) {
        CONFIG = option;
        AlicomFusionBusiness.useSDKSupplyUMSDK(CONFIG.getBooleanValue("yMengSdk", false),"ymeng");
        mAlicomFusionBusiness = new AlicomFusionBusiness();
        AlicomFusionAuthToken token= new AlicomFusionAuthToken();
        token.setAuthToken(CONFIG.getString("token"));
        mAlicomFusionBusiness.initWithToken(mActivity.get(), CONFIG.getString("schemeCode"), token);
        mAlicomFusionAuthCallBack = new AlicomFusionAuthCallBack() {
            @Override
            public AlicomFusionAuthToken onSDKTokenUpdate() {
                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenUpdate");
                AlicomFusionAuthToken token=new AlicomFusionAuthToken();
                CountDownLatch latch=new CountDownLatch(1);
                new Thread(new Runnable() {
                    @Override
                    public void run() {
//                        TokenActionFactory.getToken(mContext);
//                        latch.countDown();
                    }
                }).start();
                try {
                    latch.await();
                    token.setAuthToken(CONFIG.getString("token"));
                } catch (InterruptedException e) {
                }
                return token;
            }

            @Override
            public void onSDKTokenAuthSuccess() {
                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenAuthSuccess");
                JSONObject result = new JSONObject();
                result.put("errorMsg", "验证成功");
                resultData(result);
            }

            //鉴权失败
            @Override
            public void onSDKTokenAuthFailure(AlicomFusionAuthToken token, AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenAuthFailure "+alicomFusionEvent.getErrorCode() +"  "+alicomFusionEvent.getErrorMsg());
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        Looper.prepare();
                        AlicomFusionAuthToken authToken=new AlicomFusionAuthToken();
                        authToken.setAuthToken(CONFIG.getString("token"));
                        mAlicomFusionBusiness.updateToken(authToken);
                    }
                }).start();
            }

            @Override
            public void onVerifySuccess(String token, String s1, AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifySuccess " +token);
                JSONObject result = JSON.parseObject(JSON.toJSONString(alicomFusionEvent));
                result.put("token", token);
                resultData(result);
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(mActivity.get(), token, CONFIG.getBooleanValue("debugMode", false));
                        Log.d(TAG, "AlicomFusionAuthCallBack---verifyTokenResult " +verifyTokenResult.toString());
                    }
                }).start();
            }

            /**
             * 中途获取Token成功
             * @param nodeName
             * @param maskToken
             * @param alicomFusionEvent
             * @param halfWayVerifyResult
             */
            @Override
            public void onHalfWayVerifySuccess(String nodeName, String maskToken, AlicomFusionEvent alicomFusionEvent, HalfWayVerifyResult halfWayVerifyResult) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onHalfWayVerifySuccess "+maskToken);
                JSONObject result = JSON.parseObject(JSON.toJSONString(alicomFusionEvent));
                result.put("token", maskToken);
                resultData(result);
            }

            /**
             * 获取Token失败
             * @param alicomFusionEvent
             * @param s
             */
            @Override
            public void onVerifyFailed(AlicomFusionEvent alicomFusionEvent, String s) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyFailed "+alicomFusionEvent.toString());
                resultData(alicomFusionEvent);
                mAlicomFusionBusiness.continueSceneWithTemplateId("100001",false);
            }

            @Override
            public void onTemplateFinish(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onTemplateFinish "+alicomFusionEvent.toString());
                resultData(alicomFusionEvent);
                mAlicomFusionBusiness.stopSceneWithTemplateId(String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)));
            }

            @Override
            public void onAuthEvent(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onAuthEvent "+alicomFusionEvent.toString());
                resultData(alicomFusionEvent);
            }

            @Override
            public String onGetPhoneNumberForVerification(String s, AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onGetPhoneNumberForVerification "+alicomFusionEvent.toString());
                resultData(alicomFusionEvent);
                return "";
            }

            @Override
            public void onVerifyInterrupt(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyInterrupt "+alicomFusionEvent.toString());
                resultData(alicomFusionEvent);
            }
        };
        mAlicomFusionBusiness.setAlicomFusionAuthCallBack(mAlicomFusionAuthCallBack);
        uiCallBack = new AlicomFusionAuthUICallBack() {
            /**
             * ⼀键登录自UI注意，请不要调整view id属性否则可能造成部分功能无法使用
             * @note ⾃定义⼀键登录相关UI界面，⼀键登录界面不可100%完全自定义，请通过AlicomFusionNumberAuthModel参数进行修改
             * @param templateId 场景ID
             * @param nodeId 节点ID
             * @param fusionNumberAuthModel 自定义UI属性
             */
            @Override
            public void onPhoneNumberVerifyUICustomView(String templateId,String nodeId, FusionNumberAuthModel fusionNumberAuthModel) {
                fusionNumberAuthModel.getBuilder()
                        .setPrivacyAlertBefore("请阅读")
                        .setPrivacyAlertEnd("等协议")
                        //单独设置授权页协议文本颜色
                        .setPrivacyOneColor(Color.RED)
                        .setPrivacyTwoColor(Color.BLUE)
                        .setPrivacyThreeColor(Color.BLUE)
                        .setPrivacyOperatorColor(Color.GREEN)
                        .setCheckBoxMarginTop(10)
                        .setPrivacyAlertOneColor(Color.RED)
                        .setPrivacyAlertTwoColor(Color.BLUE)
                        .setPrivacyAlertThreeColor(Color.GRAY)
                        .setPrivacyAlertOperatorColor(Color.GREEN)
                        /* .setProtocolShakePath("protocol_shake")
                         .setCheckBoxShakePath("protocol_shake")*/
                        //二次弹窗标题及确认按钮使用系统字体
                        /*.setPrivacyAlertTitleTypeface(Typeface.MONOSPACE)
                        .setPrivacyAlertBtnTypeface(Typeface.MONOSPACE)*/
                        /*//二次弹窗使用自定义字体
                        .setPrivacyAlertTitleTypeface(createTypeface(mContext,"globalFont.ttf"))
                        .setPrivacyAlertBtnTypeface(createTypeface(mContext,"testFont.ttf"))
                        .setPrivacyAlertContentTypeface(createTypeface(mContext,"testFont.ttf"))*/
                        //授权页使用系统字体
                        /* .setNavTypeface(Typeface.SANS_SERIF)
                         .setSloganTypeface(Typeface.SERIF)
                         .setLogBtnTypeface(Typeface.MONOSPACE)
                         .setSwitchTypeface(Typeface.MONOSPACE)
                         .setProtocolTypeface(Typeface.MONOSPACE)
                         .setNumberTypeface(Typeface.MONOSPACE)
                         .setPrivacyAlertContentTypeface(Typeface.MONOSPACE)*/
                        //授权页使用自定义字体
                        /*.setNavTypeface(createTypeface(mContext,"globalFont.ttf"))
                        .setSloganTypeface(createTypeface(mContext,"globalFont.ttf"))
                        .setLogBtnTypeface(createTypeface(mContext,"globalFont.ttf"))
                        .setSwitchTypeface(createTypeface(mContext,"testFont.ttf"))
                        .setProtocolTypeface(createTypeface(mContext,"testFont.ttf"))
                        .setNumberTypeface(createTypeface(mContext,"testFont.ttf"))*/
                        //授权页协议名称系统字体
                        /*.setProtocolNameTypeface(Typeface.SANS_SERIF)
                        //授权页协议名称自定义字体
                        //.setProtocolNameTypeface(createTypeface(mContext,"globalFont.ttf"))
                        //授权页协议名称是否添加下划线
                        .protocolNameUseUnderLine(true)
                        //二次弹窗协议名称系统字体
                        //.setPrivacyAlertProtocolNameTypeface(Typeface.SANS_SERIF)
                        //二次弹窗协议名称自定义字体
                        .setPrivacyAlertProtocolNameTypeface(createTypeface(getActivity(),"globalFont.ttf"))
                        //二次弹窗协议名称是否添加下划线
                        .privacyAlertProtocolNameUseUnderLine(true)*/
                        .setPrivacyAlertTitleContent("请注意")
                        .setPrivacyAlertBtnOffsetX(200)
                        .setPrivacyAlertBtnOffsetY(84)
                        .setPrivacyAlertBtnContent("同意");


                fusionNumberAuthModel.addAuthRegistViewConfig(
                        "switch_msg",
                        new AuthRegisterViewConfig.Builder()
                                .setView(initSwitchView(420))
                                .setRootViewId(AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_BODY)
                                .setCustomInterface(new CustomInterface() {
                                    @Override
                                    public void onClick(Context context) {
                                        mAlicomFusionBusiness.destory();
                                        //必须在setProtocolShakePath之后才能使用
                                        //mAlicomFusionBusiness.privacyAnimationStart();
                                        //必须在setCheckBoxShakePath之后才能使用
                                        //mAlicomFusionBusiness.checkBoxAnimationStart();
                                    }
                                })
                                .build()
                );

                fusionNumberAuthModel.addAuthRegisterXmlConfig(new AuthRegisterXmlConfig.Builder()
//                    .setLayout(R.layout.fusion_action, new AbstractPnsViewDelegate() {
//                        @Override
//                        public void onViewCreated(View view) {
//                            findViewById(R.id.tv_close).setOnClickListener(new View.OnClickListener() {
//                                @Override
//                                public void onClick(View v) {
//                                    mAlicomFusionBusiness.destory();
//                                }
//                            });
//                        }
//                    })
                        .build());


                fusionNumberAuthModel.addPrivacyAuthRegistViewConfig("privacy_cancel",new AuthRegisterViewConfig.Builder()
                        //两种加载方式都可以
                        .setView(initCancelView(100))
                        //.setView(initNumberTextView())
                        //RootViewId有三个参数
                        //AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_BODY 协议区域
                        //AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_TITLE_BAR 导航栏部分
                        //AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_NUMBER 二次弹窗为按钮区域
                        .setRootViewId(AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_NUMBER)
                        .setCustomInterface(new CustomInterface() {
                            @Override
                            public void onClick(Context context) {
                                fusionNumberAuthModel.quitPrivacyPage();
                            }
                        }).build());
            }

            /**
             * 短信验证码认证自定义UI注意，请不要调整view id属性否则可能造成部分功能无法使用
             * @note 短信验证码界面修改
             * @param templateId 场景ID
             * @param isAutoInput 是否自动填充手机用户配置autoNumberShow值进行判断
             * @param alicomFusionVerifyCodeView 短信验证码界面view
             * 是否填充通过AlicomFusionAuthCallBack回调的onGetPhoneNumberForVerification方法传入的手机号
             */
            @Override
            public void onSMSCodeVerifyUICustomView(String templateId,String s,boolean isAutoInput, AlicomFusionVerifyCodeView alicomFusionVerifyCodeView) {
                mActivity.get().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        AlicomFusionInputView inputView = alicomFusionVerifyCodeView.getInputView();
                        RelativeLayout inputNumberRootRL = inputView.getInputNumberRootRL();
                        View inflate = initTestView(0);
                        inputNumberRootRL.addView(inflate);
                    }
                });

            }

            /**
             * 上⾏短信认证自定义UI注意，请不要调整view id属性否则可能造成部分功能无法使用
             * @note 上行短信认证界面相关UI修改
             * @param templateId 场景ID
             * @param nodeId 节点ID
             * @param view 上行短信认证界面view
             * @param receivePhoneNumber 短信接收号码
             * @param verifyCode 短信内容
             */
            @Override
            public void onSMSSendVerifyUICustomView(String templateId, String nodeId, AlicomFusionUpSMSView view, String receivePhoneNumber, String verifyCode) {
                mActivity.get().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        RelativeLayout rootRl = view.getRootRl();
                        View inflate = initTestView(0);
                        rootRl.addView(inflate);
                    }
                });
            }
        };
    }

    protected View initSwitchView(int marginTop) {
        JSONObject customThirdView = CONFIG.getJSONObject("customThirdView");
        if (customThirdView == null) { return null; }
        /// 名称列表
        JSONArray customThirdViewName = customThirdView.getJSONArray("viewItemName");
        /// 图片路径列表
        JSONArray customThirdViewItem = customThirdView.getJSONArray("viewItemPath");
        if (customThirdViewName != null && customThirdViewItem != null) {
            LinearLayout linearLayout = new LinearLayout(mActivity.get().getBaseContext());
            // 创建一个最大宽度和适量高度的布局
            LinearLayout.LayoutParams LayoutParams = new LinearLayout.LayoutParams(
                    customThirdView.getFloatValue("width") > 0 ? FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("width")) : LinearLayout.LayoutParams.MATCH_PARENT,
                    customThirdView.getFloatValue("height") > 0 ? FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("height")) : LinearLayout.LayoutParams.WRAP_CONTENT
            );

            // 居中边距
            LayoutParams.setMargins(
                    FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("left") > 0 ? customThirdView.getFloatValue("left") : 10),
                    FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("top") > 0 ? customThirdView.getFloatValue("top") : marginTop),
                    FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("right") > 0 ? customThirdView.getFloatValue("right") : 10),
                    FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("bottom") > 0 ? customThirdView.getFloatValue("bottom") : 10)
            );
            linearLayout.setLayoutParams(LayoutParams);
            linearLayout.setOrientation(LinearLayout.HORIZONTAL);
            linearLayout.setGravity(Gravity.CENTER_HORIZONTAL);

            for (int i = 0; i < customThirdViewItem.size(); i++) {
                if (customThirdViewItem.get(i) != null && String.valueOf(customThirdViewItem.get(i)).isEmpty()) {
                    int finalI = i;
                    /// 每个item布局
                    LinearLayout itemLinearLayout = new LinearLayout(mActivity.get().getBaseContext());
                    /// 按钮和文字布局
                    itemLinearLayout.setOrientation(LinearLayout.VERTICAL);
                    /// 按钮控件
                    ImageButton itemButton = new ImageButton(mActivity.get());
                    /// 需要转化路径
                    try {
                        itemButton.setBackground(
                                FusionUtilTool.getBitmapToBitmapDrawable(
                                        mActivity.get().getBaseContext(),
                                        FusionUtilTool.flutterToPath(String.valueOf(customThirdViewItem.get(i)))
                                )
                        );
                    } catch (IOException e) {
                        resultData(customeData("500000", "获取图片路径出现错误", null));
                    }
                    ViewGroup.LayoutParams buttonLayoutParams = new ViewGroup.LayoutParams(
                            FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("itemWidth") > 0 ? customThirdView.getFloatValue("itemWidth") : 60),
                            FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("itemHeight") > 0 ? customThirdView.getFloatValue("itemHeight") : 60)
                    );
                    itemButton.setLayoutParams(buttonLayoutParams);

                    /// 第三方按钮的点击事件
                    itemButton.setOnClickListener(v -> {
                        // 判断是否隐藏toast
                        resultData(customeData("600019", "点击第三方登录按钮", String.valueOf(finalI)));
                    });
                    itemLinearLayout.addView(itemButton);
                    Object itemName = customThirdViewName.get(i);
                    if (itemName != null && !String.valueOf(itemName).isEmpty()) {
                        // 按钮下文字控件
                        TextView textView = new TextView(mActivity.get().getBaseContext());
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
                        Space space = new Space(mActivity.get().getBaseContext());
                        space.setLayoutParams(new ViewGroup.LayoutParams(
                                FusionUtilTool.dp2px(mActivity.get().getBaseContext(), customThirdView.getFloatValue("space") > 0 ? customThirdView.getFloatValue("space") : 10),
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

    protected View initTestView(int marginTop) {
        TextView switchTV = new TextView(mActivity.get());
        RelativeLayout.LayoutParams mLayoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        //一键登录按钮默认marginTop 270dp
        mLayoutParams.setMargins(0, FusionUtilTool.dp2px(mActivity.get(), marginTop), 0, 0);
        mLayoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL, RelativeLayout.TRUE);
        switchTV.setText("其他登录");
        switchTV.setTextColor(Color.BLACK);
        switchTV.setTextSize(TypedValue.COMPLEX_UNIT_SP, 13.0F);
        switchTV.setGravity(Gravity.CENTER);
        switchTV.setLayoutParams(mLayoutParams);
        switchTV.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mAlicomFusionBusiness.destory();
            }
        });
        return switchTV;
    }

    protected View initCancelView(int marginTop) {
        TextView switchTV = new TextView(mActivity.get());
        RelativeLayout.LayoutParams mLayoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        mLayoutParams.setMargins(FusionUtilTool.dp2px(mActivity.get(), 50), FusionUtilTool.dp2px(mActivity.get(), marginTop), 0, 0);
        switchTV.setText("取消");
        switchTV.setTextColor(Color.BLACK);
        switchTV.setTextSize(TypedValue.COMPLEX_UNIT_SP, 15.0F);
        switchTV.setLayoutParams(mLayoutParams);
        return switchTV;
    }
    protected void login() {
        mAlicomFusionBusiness.startSceneWithTemplateId(mActivity.get(), String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)), uiCallBack);
    }
    public void updateToken(String arguments) {
        AlicomFusionAuthToken authToken=new AlicomFusionAuthToken();
        authToken.setAuthToken(CONFIG.getString("token"));
        mAlicomFusionBusiness.updateToken(authToken);
    }
    // 获取版本号
    protected void getVersion(){
        String version = AlicomFusionBusiness.getSDKVersion();
        resultData(customeData("999999", String.format("插件启动成功, 原生SDK版本: %s", version), null));
    }
    protected void onClose() {
        if(mAlicomFusionBusiness!=null){
            mAlicomFusionBusiness.stopSceneWithTemplateId(String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)));
        }
    }
    protected void onDestroy() {
        if(mAlicomFusionBusiness!=null){
            mAlicomFusionBusiness.destory();
        }
    }
    /**
     * 共用返回事件
     * @param innerCode
     * @param errorMsg
     * @param innerCode
     */
    public AlicomFusionEvent.Builder customeData(String errorCode, String errorMsg, @Nullable String innerCode){
        AlicomFusionEvent.Builder alicomFusionEvent = new AlicomFusionEvent.Builder();
        alicomFusionEvent.errorCode = innerCode;
        alicomFusionEvent.errorMsg = errorMsg;
        alicomFusionEvent.innerCode = innerCode;
        return alicomFusionEvent;
    }
    /**
     * 共用返回事件
     * @param data
     */
    public void resultData(Object data){
        if (methodChannel != null) {
            mActivity.get().runOnUiThread(() -> methodChannel.invokeMethod(FusionConstant.FUSIONCHANEL, data));
        }
    }
//
//    private AlicomFusionAuthUICallBack uiCallBack;
//
//    private Boolean DEBUG_MODE;
//    private String TOKEN;
//    private String TEMLATEID;
//    private String SCHEME_CODE;
//
//    public Boolean getDEBUG_MODE() {
//        return DEBUG_MODE;
//    }
//
//    public void setDEBUG_MODE(Boolean DEBUG_MODE) {
//        this.DEBUG_MODE = DEBUG_MODE;
//    }
//
//    public String getTOKEN() {
//        return TOKEN;
//    }
//
//    public void setTOKEN(String TOKEN) {
//        this.TOKEN = TOKEN;
//    }
//
//    public String getTEMLATEID() {
//        return TEMLATEID;
//    }
//
//    public void setTEMLATEID(String TEMLATEID) {
//        this.TEMLATEID = TEMLATEID;
//    }
//
//    public String getSCHEME_CODE() {
//        return SCHEME_CODE;
//    }
//
//    public void setSCHEME_CODE(String SCHEME_CODE) {
//        this.SCHEME_CODE = SCHEME_CODE;
//    }
//
//    public MethodChannel getChannel() {
//        return channel;
//    }
//
//    public void setChannel(MethodChannel channel) {
//        this.channel = channel;
//    }
//    public Activity getActivity() {
//        return mActivity;
//    }
//    public void setActivity(Activity activity) {
//        mActivity = activity;
//    }
//    public void setContext(Context context) {
//        mContext = context;
//    }
//    public Context getContext() {
//        return mContext;
//    }
//    private volatile int sum=0;
//    private volatile boolean verifySuccess=false;
//
//    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
//    public void initAlicomFusionSdk(JSONObject option) {
//        CONFIG = option;
//        AlicomFusionBusiness.useSDKSupplyUMSDK(CONFIG.getBooleanValue("yMengSdk", false),"ymeng");
//        mAlicomFusionBusiness = new AlicomFusionBusiness();
//        AlicomFusionAuthToken token= new AlicomFusionAuthToken();
//        token.setAuthToken(CONFIG.getString("token"));
//        sum=0;
//        mAlicomFusionBusiness.initWithToken(getContext(), CONFIG.getString("schemeCode"), token);
//        mAlicomFusionAuthCallBack = new AlicomFusionAuthCallBack() {
//            @Override
//            public AlicomFusionAuthToken onSDKTokenUpdate() {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenUpdate");
//                AlicomFusionAuthToken token=new AlicomFusionAuthToken();
//                CountDownLatch latch=new CountDownLatch(1);
//                new Thread(new Runnable() {
//                    @Override
//                    public void run() {
////                        TokenActionFactory.getToken(mContext);
////                        latch.countDown();
//                    }
//                }).start();
//                try {
//                    latch.await();
//                    token.setAuthToken(TOKEN);
//                } catch (InterruptedException e) {
//                }
//                return token;
//            }
//
//            @Override
//            public void onSDKTokenAuthSuccess() {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenAuthSuccess");
//                JSONObject result = new JSONObject();
//                result.put("errorMsg", "验证成功");
//                resultData(result);
//                verifySuccess=true;
//            }
//
//            @Override
//            public void onSDKTokenAuthFailure(AlicomFusionAuthToken token, AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenAuthFailure "+alicomFusionEvent.getErrorCode() +"  "+alicomFusionEvent.getErrorMsg());
//                new Thread(new Runnable() {
//                    @Override
//                    public void run() {
//                        Looper.prepare();
//                        // TokenActionFactory.getToken(mContext);
//                        AlicomFusionAuthToken authToken=new AlicomFusionAuthToken();
//                        authToken.setAuthToken(TOKEN);
//                        mAlicomFusionBusiness.updateToken(authToken);
//                    }
//                }).start();
//            }
//
//            @Override
//            public void onVerifySuccess(String token, String s1, AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifySuccess  " +token);
//                JSONObject result = JSON.parseObject(JSON.toJSONString(alicomFusionEvent));
//                result.put("token", token);
//                resultData(result);
//                new Thread(new Runnable() {
//                    @Override
//                    public void run() {
////                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(mContext, token);
////                        updateBusiness(verifyTokenResult,s1);
//                    }
//                }).start();
//            }
//
//            /**
//             * 中途获取Token成功
//             * @param nodeName
//             * @param maskToken
//             * @param alicomFusionEvent
//             * @param halfWayVerifyResult
//             */
//            @Override
//            public void onHalfWayVerifySuccess(String nodeName, String maskToken, AlicomFusionEvent alicomFusionEvent, HalfWayVerifyResult halfWayVerifyResult) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onHalfWayVerifySuccess  "+maskToken);
//                JSONObject result = JSON.parseObject(JSON.toJSONString(alicomFusionEvent));
//                result.put("token", maskToken);
//                resultData(result);
//                new Thread(new Runnable() {
//                    @Override
//                    public void run() {
////                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(mContext, maskToken);
////                        updateBusinessHalfWay(verifyTokenResult,halfWayVerifyResult,nodeName);
//                    }
//                }).start();
//            }
//
//            /**
//             * 获取Token失败
//             * @param alicomFusionEvent
//             * @param s
//             */
//            @Override
//            public void onVerifyFailed(AlicomFusionEvent alicomFusionEvent, String s) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyFailed "+alicomFusionEvent.toString());
//                resultData(alicomFusionEvent);
//                mAlicomFusionBusiness.continueSceneWithTemplateId("100001",false);
//            }
//
//            @Override
//            public void onTemplateFinish(AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onTemplateFinish  "+alicomFusionEvent.toString());
//                sum=0;
//                resultData(alicomFusionEvent);
//                mAlicomFusionBusiness.stopSceneWithTemplateId(String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)));
//            }
//
//            @Override
//            public void onAuthEvent(AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onAuthEvent"+alicomFusionEvent.toString());
//                resultData(alicomFusionEvent);
//            }
//
//            @Override
//            public String onGetPhoneNumberForVerification(String s, AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onGetPhoneNumberForVerification"+alicomFusionEvent.toString());
//                return "";
//            }
//
//            @Override
//            public void onVerifyInterrupt(AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyInterrupt"+alicomFusionEvent.toString());
//                resultData(alicomFusionEvent);
//            }
//        };
//        mAlicomFusionBusiness.setAlicomFusionAuthCallBack(mAlicomFusionAuthCallBack);
//        uiCallBack = new AlicomFusionAuthUICallBack() {
//            /**
//             * ⼀键登录自UI注意，请不要调整view id属性否则可能造成部分功能无法使用
//             * @note ⾃定义⼀键登录相关UI界面，⼀键登录界面不可100%完全自定义，请通过AlicomFusionNumberAuthModel参数进行修改
//             * @param templateId 场景ID
//             * @param nodeId 节点ID
//             * @param fusionNumberAuthModel 自定义UI属性
//             */
//            @Override
//            public void onPhoneNumberVerifyUICustomView(String templateId,String nodeId, FusionNumberAuthModel fusionNumberAuthModel) {
//                fusionNumberAuthModel.getBuilder()
//                        .setPrivacyAlertBefore("请阅读")
//                        .setPrivacyAlertEnd("等协议")
//                        //单独设置授权页协议文本颜色
//                        .setPrivacyOneColor(Color.RED)
//                        .setPrivacyTwoColor(Color.BLUE)
//                        .setPrivacyThreeColor(Color.BLUE)
//                        .setPrivacyOperatorColor(Color.GREEN)
//                        .setCheckBoxMarginTop(10)
//                        .setPrivacyAlertOneColor(Color.RED)
//                        .setPrivacyAlertTwoColor(Color.BLUE)
//                        .setPrivacyAlertThreeColor(Color.GRAY)
//                        .setPrivacyAlertOperatorColor(Color.GREEN)
//                        /* .setProtocolShakePath("protocol_shake")
//                         .setCheckBoxShakePath("protocol_shake")*/
//                        //二次弹窗标题及确认按钮使用系统字体
//                        /*.setPrivacyAlertTitleTypeface(Typeface.MONOSPACE)
//                        .setPrivacyAlertBtnTypeface(Typeface.MONOSPACE)*/
//                        /*//二次弹窗使用自定义字体
//                        .setPrivacyAlertTitleTypeface(createTypeface(mContext,"globalFont.ttf"))
//                        .setPrivacyAlertBtnTypeface(createTypeface(mContext,"testFont.ttf"))
//                        .setPrivacyAlertContentTypeface(createTypeface(mContext,"testFont.ttf"))*/
//                        //授权页使用系统字体
//                        /* .setNavTypeface(Typeface.SANS_SERIF)
//                         .setSloganTypeface(Typeface.SERIF)
//                         .setLogBtnTypeface(Typeface.MONOSPACE)
//                         .setSwitchTypeface(Typeface.MONOSPACE)
//                         .setProtocolTypeface(Typeface.MONOSPACE)
//                         .setNumberTypeface(Typeface.MONOSPACE)
//                         .setPrivacyAlertContentTypeface(Typeface.MONOSPACE)*/
//                        //授权页使用自定义字体
//                        /*.setNavTypeface(createTypeface(mContext,"globalFont.ttf"))
//                        .setSloganTypeface(createTypeface(mContext,"globalFont.ttf"))
//                        .setLogBtnTypeface(createTypeface(mContext,"globalFont.ttf"))
//                        .setSwitchTypeface(createTypeface(mContext,"testFont.ttf"))
//                        .setProtocolTypeface(createTypeface(mContext,"testFont.ttf"))
//                        .setNumberTypeface(createTypeface(mContext,"testFont.ttf"))*/
//                        //授权页协议名称系统字体
//                        /*.setProtocolNameTypeface(Typeface.SANS_SERIF)
//                        //授权页协议名称自定义字体
//                        //.setProtocolNameTypeface(createTypeface(mContext,"globalFont.ttf"))
//                        //授权页协议名称是否添加下划线
//                        .protocolNameUseUnderLine(true)
//                        //二次弹窗协议名称系统字体
//                        //.setPrivacyAlertProtocolNameTypeface(Typeface.SANS_SERIF)
//                        //二次弹窗协议名称自定义字体
//                        .setPrivacyAlertProtocolNameTypeface(createTypeface(getActivity(),"globalFont.ttf"))
//                        //二次弹窗协议名称是否添加下划线
//                        .privacyAlertProtocolNameUseUnderLine(true)*/
//                        .setPrivacyAlertTitleContent("请注意")
//                        .setPrivacyAlertBtnOffsetX(200)
//                        .setPrivacyAlertBtnOffsetY(84)
//                        .setPrivacyAlertBtnContent("同意");
//
//
//                fusionNumberAuthModel.addAuthRegistViewConfig(
//                    "switch_msg",
//                    new AuthRegisterViewConfig.Builder()
//                    .setView(initSwitchView(420))
//                    .setRootViewId(AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_BODY)
//                    .setCustomInterface(new CustomInterface() {
//                        @Override
//                        public void onClick(Context context) {
//                            mAlicomFusionBusiness.destory();
//                            //必须在setProtocolShakePath之后才能使用
//                            //mAlicomFusionBusiness.privacyAnimationStart();
//                            //必须在setCheckBoxShakePath之后才能使用
//                            //mAlicomFusionBusiness.checkBoxAnimationStart();
//                        }
//                    })
//                    .build()
//                );
//
//                fusionNumberAuthModel.addAuthRegisterXmlConfig(new AuthRegisterXmlConfig.Builder()
////                    .setLayout(R.layout.fusion_action, new AbstractPnsViewDelegate() {
////                        @Override
////                        public void onViewCreated(View view) {
////                            findViewById(R.id.tv_close).setOnClickListener(new View.OnClickListener() {
////                                @Override
////                                public void onClick(View v) {
////                                    mAlicomFusionBusiness.destory();
////                                }
////                            });
////                        }
////                    })
//                        .build());
//
//
//                fusionNumberAuthModel.addPrivacyAuthRegistViewConfig("privacy_cancel",new AuthRegisterViewConfig.Builder()
//                        //两种加载方式都可以
//                        .setView(initCancelView(100))
//                        //.setView(initNumberTextView())
//                        //RootViewId有三个参数
//                        //AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_BODY 协议区域
//                        //AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_TITLE_BAR 导航栏部分
//                        //AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_NUMBER 二次弹窗为按钮区域
//                        .setRootViewId(AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_NUMBER)
//                        .setCustomInterface(new CustomInterface() {
//                            @Override
//                            public void onClick(Context context) {
//                                fusionNumberAuthModel.quitPrivacyPage();
//                            }
//                        }).build());
//            }
//
//            /**
//             * 短信验证码认证自定义UI注意，请不要调整view id属性否则可能造成部分功能无法使用
//             * @note 短信验证码界面修改
//             * @param templateId 场景ID
//             * @param isAutoInput 是否自动填充手机用户配置autoNumberShow值进行判断
//             * @param alicomFusionVerifyCodeView 短信验证码界面view
//             * 是否填充通过AlicomFusionAuthCallBack回调的onGetPhoneNumberForVerification方法传入的手机号
//             */
//            @Override
//            public void onSMSCodeVerifyUICustomView(String templateId,String s,boolean isAutoInput, AlicomFusionVerifyCodeView alicomFusionVerifyCodeView) {
//                mActivity.runOnUiThread(new Runnable() {
//                    @Override
//                    public void run() {
//                        AlicomFusionInputView inputView = alicomFusionVerifyCodeView.getInputView();
////                        RelativeLayout inputNumberRootRL = inputView.getInputNumberRootRL();
////                        TextView inflate = new TextView(mActivity);
////                        inflate.setText("vhbjknlm");
////                        inflate.setOnClickListener(new View.OnClickListener() {
////                            @Override
////                            public void onClick(View v) {
////                                mAlicomFusionBusiness.destory();
////                            }
////                        });
////                        RelativeLayout.LayoutParams rl = new RelativeLayout.LayoutParams(
////                                RelativeLayout.LayoutParams.MATCH_PARENT,
////                                RelativeLayout.LayoutParams.WRAP_CONTENT
////                        );
////                        rl.addRule(RelativeLayout.CENTER_IN_PARENT,RelativeLayout.TRUE);
////                        inflate.setLayoutParams(rl);
////                        inflate.setGravity(Gravity.CENTER);
////                        inputNumberRootRL.addView(inflate);
//                    }
//                });
//
//            }
//
//            /**
//             * 上⾏短信认证自定义UI注意，请不要调整view id属性否则可能造成部分功能无法使用
//             * @note 上行短信认证界面相关UI修改
//             * @param templateId 场景ID
//             * @param nodeId 节点ID
//             * @param view 上行短信认证界面view
//             * @param receivePhoneNumber 短信接收号码
//             * @param verifyCode 短信内容
//             */
//            @Override
//            public void onSMSSendVerifyUICustomView(String templateId, String nodeId, AlicomFusionUpSMSView view, String receivePhoneNumber, String verifyCode) {
//                mActivity.runOnUiThread(new Runnable() {
//                    @Override
//                    public void run() {
//                        RelativeLayout rootRl = view.getRootRl();
////                        TextView inflate = new TextView(mActivity);
////                        inflate.setText("vhbjknlm");
////                        inflate.setOnClickListener(new View.OnClickListener() {
////                            @Override
////                            public void onClick(View v) {
////                                mAlicomFusionBusiness.destory();
////                            }
////                        });
////                        RelativeLayout.LayoutParams rl = new RelativeLayout.LayoutParams(
////                                RelativeLayout.LayoutParams.MATCH_PARENT,
////                                RelativeLayout.LayoutParams.WRAP_CONTENT
////                        );
////                        inflate.setLayoutParams(rl);
////                        inflate.setGravity(Gravity.CENTER);
////                        rootRl.addView(inflate);
//                    }
//                });
//            }
//        };
//    }
//
//    protected View initTestView(int marginTop) {
//        TextView switchTV = new TextView(getActivity());
//        RelativeLayout.LayoutParams mLayoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
//        //一键登录按钮默认marginTop 270dp
//        mLayoutParams.setMargins(0, FusionUtilTool.dp2px(getActivity(), marginTop), 0, 0);
//        mLayoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL, RelativeLayout.TRUE);
//        switchTV.setText("其他登录");
//        switchTV.setTextColor(Color.BLACK);
//        switchTV.setTextSize(TypedValue.COMPLEX_UNIT_SP, 13.0F);
//        switchTV.setLayoutParams(mLayoutParams);
//        return switchTV;
//    }
//
//    protected View initCancelView(int marginTop) {
//        TextView switchTV = new TextView(getActivity());
//        RelativeLayout.LayoutParams mLayoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
//        mLayoutParams.setMargins(FusionUtilTool.dp2px(getActivity(), 50), FusionUtilTool.dp2px(getActivity(), marginTop), 0, 0);
//        switchTV.setText("取消");
//        switchTV.setTextColor(Color.BLACK);
//        switchTV.setTextSize(TypedValue.COMPLEX_UNIT_SP, 15.0F);
//        switchTV.setLayoutParams(mLayoutParams);
//        return switchTV;
//    }
//
//    // 获取版本号
//    public void getVersion(){
//        String version = AlicomFusionBusiness.getSDKVersion();
//        getResultData("999999", String.format("插件启动成功, 原生SDK版本: %s", version), "");
//    }
//
//    public void login() {
//        mAlicomFusionBusiness.startSceneWithTemplateId(getActivity(), String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)), uiCallBack);
//    }
//
//    public void onClose() {
//        if(mAlicomFusionBusiness!=null){
//            mAlicomFusionBusiness.stopSceneWithTemplateId(String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)));
//        }
//    }
//
//    public void onDestroy() {
//        if(mAlicomFusionBusiness!=null){
//            mAlicomFusionBusiness.destory();
//        }
//    }
//
}
