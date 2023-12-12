//package com.sean.rao.fusion_auth.common;
//
//import android.os.Looper;
//import android.text.TextUtils;
//import android.util.Log;
//import android.widget.Toast;
//
//import com.alicom.fusion.auth.AlicomFusionAuthCallBack;
//import com.alicom.fusion.auth.AlicomFusionBusiness;
//import com.alicom.fusion.auth.AlicomFusionConstant;
//import com.alicom.fusion.auth.HalfWayVerifyResult;
//import com.alicom.fusion.auth.error.AlicomFusionEvent;
//import com.alicom.fusion.auth.token.AlicomFusionAuthToken;
//import com.sean.rao.fusion_auth.utils.FusionAuthUtils;
//
//import java.util.concurrent.CountDownLatch;
//
//public class AliComFusionManager {
//    private static final String TAG = "AliComFusionManager";
//
//    private static class Holder {
//        private static final AliComFusionManager INSTANCE = new AliComFusionManager();
//    }
//
//    public static AliComFusionManager getInstance() {
//        return AliComFusionManager.Holder.INSTANCE;
//    }
//
//    private AlicomFusionBusiness mAlicomFusionBusiness;
//    private AlicomFusionAuthCallBack mAlicomFusionAuthCallBack;
//    private String currentTemplatedId="";
//
//    private void initAlicomFusionSdk() {
//        AlicomFusionBusiness.useSDKSupplyUMSDK(true,"umeng");
//        String token = null;
//        sum=0;
//        if(TextUtils.isEmpty(FusionAuthUtils.getInstance().getTOKEN())){
//            TokenActionFactory.getToken(FusionAuthUtils.getInstance().getContext());
//        }
//        token=FusionAuthUtils.getInstance().getTOKEN();
//        mAlicomFusionBusiness = new AlicomFusionBusiness();
//        AlicomFusionAuthToken authToken=new AlicomFusionAuthToken();
//        authToken.setAuthToken(token);
//        mAlicomFusionBusiness.initWithToken(FusionAuthUtils.getInstance().getContext(), Constant.SCHEME_CODE,authToken);
//        mAlicomFusionAuthCallBack = new AlicomFusionAuthCallBack() {
//            @Override
//            public AlicomFusionAuthToken onSDKTokenUpdate() {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenUpdate");
//                AlicomFusionAuthToken token=new AlicomFusionAuthToken();
//                CountDownLatch latch=new CountDownLatch(1);
//                new Thread(new Runnable() {
//                    @Override
//                    public void run() {
//                        TokenActionFactory.getToken(FusionAuthUtils.getInstance().getContext());
//                        latch.countDown();
//                    }
//                }).start();
//                try {
//                    latch.await();
//                    token.setAuthToken(FusionAuthUtils.getInstance().getToken());
//                } catch (InterruptedException e) {
//                }
//                return token;
//            }
//
//            @Override
//            public void onSDKTokenAuthSuccess() {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenAuthSuccess");
//                verifySuccess=true;
//            }
//
//            @Override
//            public void onSDKTokenAuthFailure(AlicomFusionAuthToken token1, AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onSDKTokenAuthFailure " +alicomFusionEvent.getErrorCode());
//                new Thread(new Runnable() {
//                    @Override
//                    public void run() {
//                        Looper.prepare();
//                        CountDownLatch latch=new CountDownLatch(1);
//                        new Thread(new Runnable() {
//                            @Override
//                            public void run() {
//                                TokenActionFactory.getToken(FusionAuthUtils.getInstance().getContext());
//                                latch.countDown();
//                            }
//                        }).start();
//                        try {
//                            latch.await();
//                        } catch (InterruptedException e) {
//                        }
//                        AlicomFusionAuthToken authToken=new AlicomFusionAuthToken();
//                        authToken.setAuthToken(FusionAuthUtils.getInstance().getToken());
//                        mAlicomFusionBusiness.updateToken(authToken);
//                    }
//                }).start();
//            }
//
//            @Override
//            public void onVerifySuccess(String token, String s1,AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifySuccess  "+token);
//                new Thread(new Runnable() {
//                    @Override
//                    public void run() {
//                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(FusionAuthUtils.getInstance().getContext(), token);
//                        updateBusiness(verifyTokenResult,s1);
//                    }
//                }).start();
//            }
//
//            @Override
//            public void onHalfWayVerifySuccess(String nodeName, String maskToken,AlicomFusionEvent alicomFusionEvent, HalfWayVerifyResult halfWayVerifyResult) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onHalfWayVerifySuccess  "+maskToken);
//                new Thread(new Runnable() {
//                    @Override
//                    public void run() {
//                        VerifyTokenResult verifyTokenResult = TokenActionFactory.verifyToken(FusionAuthUtils.getInstance().getContext(), maskToken);
//                        updateBusinessHalfWay(verifyTokenResult,halfWayVerifyResult,nodeName);
//
//                    }
//                }).start();
//            }
//
//            @Override
//            public void onVerifyFailed(AlicomFusionEvent alicomFusionEvent, String s) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyFailed "+alicomFusionEvent.getErrorCode()+"   "+alicomFusionEvent.getErrorMsg());
//                mAlicomFusionBusiness.continueSceneWithTemplateId(currentTemplatedId,false);
//            }
//
//            @Override
//            public void onTemplateFinish(AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onTemplateFinish  "+alicomFusionEvent.getErrorCode());
//                sum=0;
//                mAlicomFusionBusiness.stopSceneWithTemplateId(currentTemplatedId);
//            }
//
//
//            @Override
//            public void onAuthEvent(AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onAuthEvent"+alicomFusionEvent.getErrorCode());
//
//            }
//
//
//            @Override
//            public String onGetPhoneNumberForVerification(String s,AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onGetPhoneNumberForVerification");
//
//                return FusionAuthUtils.getInstance().getUserInfo();
//            }
//
//            @Override
//            public void onVerifyInterrupt(AlicomFusionEvent alicomFusionEvent) {
//                Log.d(TAG, "AlicomFusionAuthCallBack---onVerifyInterrupt"+alicomFusionEvent.toString());
//            }
//        };
//        mAlicomFusionBusiness.setAlicomFusionAuthCallBack(mAlicomFusionAuthCallBack);
//    }
//
//    private void updateBusiness(VerifyTokenResult verifyTokenResult,String nodeNmae){
//        runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                if(verifyTokenResult!=null&&verifyTokenResult.isSuccess()){
//                    if ("PASS".equals(verifyTokenResult.getData().getVerifyResult())) {
//                        if("100003".equals(currentTemplatedId)){
//                            if(!verifyTokenResult.getData().getPhoneNumber().equals(FusionAuthUtils.getInstance().getUserInfo())){
//                                Toast.makeText(FusionAuthUtils.getInstance().getContext(),"请注意使用已登录账号",Toast.LENGTH_SHORT).show();
//                                return;
//                            }
//                        }
//                        Toast.makeText(FusionAuthUtils.getInstance().getContext(),"校验通过",Toast.LENGTH_SHORT).show();
//                        mAlicomFusionBusiness.continueSceneWithTemplateId(currentTemplatedId,true);
//                        FusionAuthUtils.getInstance().setUserInfo(verifyTokenResult.getData().getPhoneNumber());
//                    }else {
//                        Toast.makeText(FusionAuthUtils.getInstance().getContext(),"校验未通过",Toast.LENGTH_SHORT).show();
//                        if(nodeNmae.equals(AlicomFusionConstant.ALICOMFUSIONAUTH_SMSAUTHNODENAME)&&sum<3){
//                            sum++;
//                        }else {
//                            sum=0;
//                            mAlicomFusionBusiness.continueSceneWithTemplateId(currentTemplatedId,false);
//                        }
//                    }
//                }else {
//                    Toast.makeText(FusionAuthUtils.getInstance().getContext(),"校验未通过",Toast.LENGTH_SHORT).show();
//                    if(nodeNmae.equals(AlicomFusionConstant.ALICOMFUSIONAUTH_SMSAUTHNODENAME)&&sum<3){
//                        sum++;
//                    }else {
//                        sum=0;
//                        mAlicomFusionBusiness.continueSceneWithTemplateId(currentTemplatedId,false);
//                    }
//                }
//
//            }
//        });
//
//    }
//
//    private void updateBusinessHalfWay(VerifyTokenResult verifyTokenResult,HalfWayVerifyResult verifyResult,String nodeNmae){
//        runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                if(verifyTokenResult!=null&&verifyTokenResult.isSuccess()){
//                    if ("PASS".equals(verifyTokenResult.getData().getVerifyResult())) {
//                        if("100002".equals(currentTemplatedId)){
//                            if(!verifyTokenResult.getData().getPhoneNumber().equals(FusionAuthUtils.getInstance().getUserInfo())){
//                                Toast.makeText(FusionAuthUtils.getInstance().getContext(),"请注意使用已登录账号",Toast.LENGTH_SHORT).show();
//                                return;
//                            }
//                        }
//                        Toast.makeText(FusionAuthUtils.getInstance().getContext(),"校验通过",Toast.LENGTH_SHORT).show();
//                        verifyResult.verifyResult(true);
//                        FusionAuthUtils.getInstance().setUserInfo(verifyTokenResult.getData().getPhoneNumber());
//                    }else {
//                        Toast.makeText(FusionAuthUtils.getInstance().getContext(),"校验未通过",Toast.LENGTH_SHORT).show();
//                        if(nodeNmae.equals(AlicomFusionConstant.ALICOMFUSIONAUTH_SMSAUTHNODENAME)&&sum<3){
//                            sum++;
//                        }else {
//                            verifyResult.verifyResult(false);
//                            sum=0;
//                        }
//                    }
//                }else {
//                    Toast.makeText(FusionAuthUtils.getInstance().getContext(),"校验未通过",Toast.LENGTH_SHORT).show();
//                    if(nodeNmae.equals(AlicomFusionConstant.ALICOMFUSIONAUTH_SMSAUTHNODENAME)&&sum<3){
//                        sum++;
//                    }else {
//                        verifyResult.verifyResult(false);
//                        sum=0;
//                    }
//                }
//            }
//        });
//
//    }
//
//
//    private void refreshToken(){
//        new Thread(){
//            @Override
//            public void run() {
//                super.run();
//                if(TextUtils.isEmpty(FusionAuthUtils.getInstance().getTOKEN())){
//                    CountDownLatch latch=new CountDownLatch(1);
//                    GetAuthTokenResult authToken = HttpRequestUtil.getAuthToken(FusionAuthUtils.getInstance().getContext());
//                    latch.countDown();
//                    try {
//                        latch.await();
//                    } catch (InterruptedException e) {
//                    }
//                    FusionAuthUtils.getInstance().setToken(authToken==null?"":authToken.getModel());
//                }
//            }
//        }.start();
//    }
//
//}
