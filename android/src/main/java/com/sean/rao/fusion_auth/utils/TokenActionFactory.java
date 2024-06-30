package com.sean.rao.fusion_auth.utils;

import android.content.Context;
import android.util.Log;


import com.sean.rao.fusion_auth.net.HttpRequestUtil;
import com.sean.rao.fusion_auth.net.VerifyTokenModel;
import com.sean.rao.fusion_auth.net.VerifyTokenResult;

import java.util.UUID;

/**
 * @author: cmw01044812
 * @date: 8/28/23
 * @descript:
 */
public class TokenActionFactory {

   public static void getToken(Context mContext){
       if(Constant.TOKEN_MODEL==1){
           GlobalInfoManager.getInstance().setToken(Constant.LOCAL_TOKEN);
       }else if(Constant.TOKEN_MODEL==2){
           GetAuthTokenResult authToken = HttpRequestUtil.getAuthToken(GlobalInfoManager.getInstance().getContext());
           GlobalInfoManager.getInstance().setToken(authToken==null?"":authToken.getModel());
       }
   }

    public static VerifyTokenResult verifyToken(Context mContext, String token, boolean tokenModel){
        VerifyTokenResult verifyTokenResult;
        if(tokenModel){
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
        }else{
            verifyTokenResult = HttpRequestUtil.verifyToken(mContext, token);
        }
        return verifyTokenResult;
    }

}
