package com.sean.rao.fusion_auth.utils;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.os.Build;
import android.os.Looper;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.annotation.RequiresApi;

import com.alibaba.fastjson2.JSON;
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
import com.mobile.auth.gatewayauth.ui.AbstractPnsViewDelegate;
import com.nirvana.tools.core.ExecutorManager;
import com.sean.rao.fusion_auth.R;

import java.util.concurrent.CountDownLatch;

import io.flutter.plugin.common.MethodChannel;

/**
 * @Package: com.alicom.fusion.demo
 * @Description:
 * @CreateDate: 2023/2/15
 */
public class FusionAuthUtil extends FusionAuthUiUtil{
    private static final String TAG = "FusionAuthUtil";
    FusionAuthUtil() {
    }
    private static class Holder {
        private static final FusionAuthUtil INSTANCE = new FusionAuthUtil();
    }
    public static FusionAuthUtil getInstance() {
        return Holder.INSTANCE;
    }
    private AlicomFusionAuthUICallBack uiCallBack;
    private MethodChannel channel;
    private Boolean DEBUG_MODE;
    private String TOKEN;
    private String TEMLATEID;
    private String SCHEME_CODE;

    public Boolean getDEBUG_MODE() {
        return DEBUG_MODE;
    }

    public void setDEBUG_MODE(Boolean DEBUG_MODE) {
        this.DEBUG_MODE = DEBUG_MODE;
    }

    public String getTOKEN() {
        return TOKEN;
    }

    public void setTOKEN(String TOKEN) {
        this.TOKEN = TOKEN;
    }

    public String getTEMLATEID() {
        return TEMLATEID;
    }

    public void setTEMLATEID(String TEMLATEID) {
        this.TEMLATEID = TEMLATEID;
    }

    public String getSCHEME_CODE() {
        return SCHEME_CODE;
    }

    public void setSCHEME_CODE(String SCHEME_CODE) {
        this.SCHEME_CODE = SCHEME_CODE;
    }

    public MethodChannel getChannel() {
        return channel;
    }

    public void setChannel(MethodChannel channel) {
        this.channel = channel;
    }
    public Activity getActivity() {
        return mActivity;
    }
    public void setActivity(Activity activity) {
        mActivity = activity;
    }
    public void setContext(Context context) {
        mContext = context;
    }
    public Context getContext() {
        return mContext;
    }
    private volatile int sum=0;
    private volatile boolean verifySuccess=false;

    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN)
    public void initAlicomFusionSdk(JSONObject option) {
        CONFIG = option;
        AlicomFusionBusiness.useSDKSupplyUMSDK(CONFIG.getBooleanValue("yMengSdk", false),"ymeng");
        mAlicomFusionBusiness = new AlicomFusionBusiness();
        AlicomFusionAuthToken token= new AlicomFusionAuthToken();
        token.setAuthToken(CONFIG.getString("token"));
        sum=0;
        mAlicomFusionBusiness.initWithToken(getContext(), CONFIG.getString("schemeCode"), token);
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
                    token.setAuthToken(TOKEN);
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
                verifySuccess=true;
            }

            @Override
            public void onSDKTokenAuthFailure(AlicomFusionAuthToken token, AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenAuthFailure "+alicomFusionEvent.getErrorCode() +"  "+alicomFusionEvent.getErrorMsg());
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        Looper.prepare();
                        // TokenActionFactory.getToken(mContext);
                        AlicomFusionAuthToken authToken=new AlicomFusionAuthToken();
                        authToken.setAuthToken(TOKEN);
                        mAlicomFusionBusiness.updateToken(authToken);
                    }
                }).start();
            }

            @Override
            public void onVerifySuccess(String token, String s1, AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifySuccess  " +token);
                JSONObject result = JSON.parseObject(JSON.toJSONString(alicomFusionEvent));
                result.put("token", token);
                resultData(result);
                new Thread(new Runnable() {
                    @Override
                    public void run() {
//                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(mContext, token);
//                        updateBusiness(verifyTokenResult,s1);
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
                Log.d(TAG, "AlicomFusionAuthCallBack---onHalfWayVerifySuccess  "+maskToken);
                JSONObject result = JSON.parseObject(JSON.toJSONString(alicomFusionEvent));
                result.put("token", maskToken);
                resultData(result);
                new Thread(new Runnable() {
                    @Override
                    public void run() {
//                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(mContext, maskToken);
//                        updateBusinessHalfWay(verifyTokenResult,halfWayVerifyResult,nodeName);
                    }
                }).start();
            }

            /**
             * 获取Token失败
             * @param alicomFusionEvent
             * @param s
             */
            @Override
            public void onVerifyFailed(AlicomFusionEvent alicomFusionEvent, String s) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyFailed "+alicomFusionEvent.toString());
                resultData(JSON.parseObject(JSON.toJSONString(alicomFusionEvent)));
                mAlicomFusionBusiness.continueSceneWithTemplateId("100001",false);
            }

            @Override
            public void onTemplateFinish(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onTemplateFinish  "+alicomFusionEvent.toString());
                sum=0;
                resultData(JSON.parseObject(JSON.toJSONString(alicomFusionEvent)));
                mAlicomFusionBusiness.stopSceneWithTemplateId(String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)));
            }

            @Override
            public void onAuthEvent(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onAuthEvent"+alicomFusionEvent.toString());
                resultData(JSON.parseObject(JSON.toJSONString(alicomFusionEvent)));
            }

            @Override
            public String onGetPhoneNumberForVerification(String s, AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onGetPhoneNumberForVerification"+alicomFusionEvent.toString());
                return "";
            }

            @Override
            public void onVerifyInterrupt(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyInterrupt"+alicomFusionEvent.toString());
                resultData(JSON.parseObject(JSON.toJSONString(alicomFusionEvent)));
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
                mActivity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        AlicomFusionInputView inputView = alicomFusionVerifyCodeView.getInputView();
//                        RelativeLayout inputNumberRootRL = inputView.getInputNumberRootRL();
//                        TextView inflate = new TextView(mActivity);
//                        inflate.setText("vhbjknlm");
//                        inflate.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View v) {
//                                mAlicomFusionBusiness.destory();
//                            }
//                        });
//                        RelativeLayout.LayoutParams rl = new RelativeLayout.LayoutParams(
//                                RelativeLayout.LayoutParams.MATCH_PARENT,
//                                RelativeLayout.LayoutParams.WRAP_CONTENT
//                        );
//                        rl.addRule(RelativeLayout.CENTER_IN_PARENT,RelativeLayout.TRUE);
//                        inflate.setLayoutParams(rl);
//                        inflate.setGravity(Gravity.CENTER);
//                        inputNumberRootRL.addView(inflate);
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
                mActivity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        RelativeLayout rootRl = view.getRootRl();
//                        TextView inflate = new TextView(mActivity);
//                        inflate.setText("vhbjknlm");
//                        inflate.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View v) {
//                                mAlicomFusionBusiness.destory();
//                            }
//                        });
//                        RelativeLayout.LayoutParams rl = new RelativeLayout.LayoutParams(
//                                RelativeLayout.LayoutParams.MATCH_PARENT,
//                                RelativeLayout.LayoutParams.WRAP_CONTENT
//                        );
//                        inflate.setLayoutParams(rl);
//                        inflate.setGravity(Gravity.CENTER);
//                        rootRl.addView(inflate);
                    }
                });
            }
        };
    }

    protected View initTestView(int marginTop) {
        TextView switchTV = new TextView(getActivity());
        RelativeLayout.LayoutParams mLayoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        //一键登录按钮默认marginTop 270dp
        mLayoutParams.setMargins(0, FusionUtilTool.dp2px(getActivity(), marginTop), 0, 0);
        mLayoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL, RelativeLayout.TRUE);
        switchTV.setText("其他登录");
        switchTV.setTextColor(Color.BLACK);
        switchTV.setTextSize(TypedValue.COMPLEX_UNIT_SP, 13.0F);
        switchTV.setLayoutParams(mLayoutParams);
        return switchTV;
    }

    protected View initCancelView(int marginTop) {
        TextView switchTV = new TextView(getActivity());
        RelativeLayout.LayoutParams mLayoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);
        mLayoutParams.setMargins(FusionUtilTool.dp2px(getActivity(), 50), FusionUtilTool.dp2px(getActivity(), marginTop), 0, 0);
        switchTV.setText("取消");
        switchTV.setTextColor(Color.BLACK);
        switchTV.setTextSize(TypedValue.COMPLEX_UNIT_SP, 15.0F);
        switchTV.setLayoutParams(mLayoutParams);
        return switchTV;
    }

    // 获取版本号
    public void getVersion(){
        String version = AlicomFusionBusiness.getSDKVersion();
        getResultData("999999", String.format("插件启动成功, 原生SDK版本: %s", version), "");
    }

    public void login() {
        mAlicomFusionBusiness.startSceneWithTemplateId(getActivity(), String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)), uiCallBack);
    }

    public void onClose() {
        if(mAlicomFusionBusiness!=null){
            mAlicomFusionBusiness.stopSceneWithTemplateId(String.valueOf(CONFIG.getOrDefault("templateId", FusionConstant.DEFAULTTEMPLATEID)));
        }
    }

    public void onDestroy() {
        if(mAlicomFusionBusiness!=null){
            mAlicomFusionBusiness.destory();
        }
    }

    /**
     * 组合数据
     * @param errorCode
     * @param errorMsg
     * @param data
     */
    public void getResultData(String errorCode, String errorMsg, Object data){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", errorCode);
        jsonObject.put("errorMsg", errorMsg);
        jsonObject.put("token", data);
        // 开始发送数据
        resultData(jsonObject);
    }
    /**
     * 共用返回事件
     * @param data
     */
    public void resultData(Object data){
        if (channel != null) {
            channel.invokeMethod("onEvent", data);
        }
    }
}
