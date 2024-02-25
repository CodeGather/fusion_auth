package com.sean.rao.fusion_auth.utils;

import android.content.Context;
import android.os.Looper;
import android.util.Log;

import com.alibaba.fastjson2.JSONObject;
import com.alicom.fusion.auth.AlicomFusionAuthCallBack;
import com.alicom.fusion.auth.AlicomFusionBusiness;
import com.alicom.fusion.auth.HalfWayVerifyResult;
import com.alicom.fusion.auth.error.AlicomFusionEvent;
import com.alicom.fusion.auth.token.AlicomFusionAuthToken;

import java.util.concurrent.CountDownLatch;

import io.flutter.plugin.common.MethodChannel;

/**
 * @Package: com.alicom.fusion.demo
 * @Description:
 * @CreateDate: 2023/2/15
 */
public class FusionAuthUtil {
    private static final String TAG = "FusionAuthUtil";
    private FusionAuthUtil() {
    }

    private static class Holder {
        private static final FusionAuthUtil INSTANCE = new FusionAuthUtil();
    }

    public static FusionAuthUtil getInstance() {
        return Holder.INSTANCE;
    }

    private MethodChannel channel;

    private Boolean DEBUG_MODE;

    private String TOKEN;

    private String TEMLATEID;

    private String SCHEME_CODE;

    private JSONObject CONFIG;

    private Context mContext;

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

    public JSONObject getCONFIG() {
        return CONFIG;
    }

    public void setCONFIG(JSONObject CONFIG) {
        this.CONFIG = CONFIG;
    }

    public void setContext(Context context) {
        this.mContext = context;
    }

    public Context getContext() {
        return mContext;
    }

    public MethodChannel getChannel() {
        return channel;
    }

    public void setChannel(MethodChannel channel) {
        this.channel = channel;
    }

    private volatile int  sum=0;
    private volatile boolean verifySuccess=false;
    private AlicomFusionBusiness mAlicomFusionBusiness;
    private AlicomFusionAuthCallBack mAlicomFusionAuthCallBack;
    public void initAlicomFusionSdk() {
        AlicomFusionBusiness.useSDKSupplyUMSDK(true,"ymeng");
        mAlicomFusionBusiness = new AlicomFusionBusiness();
        sum=0;
        AlicomFusionAuthToken token=new AlicomFusionAuthToken();
        token.setAuthToken(TOKEN);
        mAlicomFusionBusiness.initWithToken(mContext, CONFIG.getString("schemeCo de"),token);
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
                new Thread(new Runnable() {
                    @Override
                    public void run() {
//                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(mContext, token);
//                        updateBusiness(verifyTokenResult,s1);
                    }
                }).start();
            }

            @Override
            public void onHalfWayVerifySuccess(String nodeName, String maskToken, AlicomFusionEvent alicomFusionEvent, HalfWayVerifyResult halfWayVerifyResult) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onHalfWayVerifySuccess  "+maskToken);
                new Thread(new Runnable() {
                    @Override
                    public void run() {
//                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(mContext, maskToken);
//                        updateBusinessHalfWay(verifyTokenResult,halfWayVerifyResult,nodeName);
                    }
                }).start();
            }

            @Override
            public void onVerifyFailed(AlicomFusionEvent alicomFusionEvent, String s) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyFailed "+alicomFusionEvent.getErrorCode()+"   "+alicomFusionEvent.getErrorMsg());
                mAlicomFusionBusiness.continueSceneWithTemplateId("100001",false);
            }

            @Override
            public void onTemplateFinish(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onTemplateFinish  "+alicomFusionEvent.getErrorCode()+"  "+alicomFusionEvent.getErrorMsg());
                sum=0;
                mAlicomFusionBusiness.stopSceneWithTemplateId("100001");
            }

            @Override
            public void onAuthEvent(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onAuthEvent"+alicomFusionEvent.getErrorCode());
            }

            @Override
            public String onGetPhoneNumberForVerification(String s, AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onGetPhoneNumberForVerification");
                return "";
            }

            @Override
            public void onVerifyInterrupt(AlicomFusionEvent alicomFusionEvent) {
                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyInterrupt"+alicomFusionEvent.toString());
            }
        };
        mAlicomFusionBusiness.setAlicomFusionAuthCallBack(mAlicomFusionAuthCallBack);
    }

    // 获取版本号
    public void getVersion(){
        String version = AlicomFusionBusiness.getSDKVersion();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("resultCode", "999999");
        jsonObject.put("resultMsg", String.format("插件启动成功, 原生SDK版本: %s", version));
        resultData(jsonObject);
    }

    public void login() {
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
