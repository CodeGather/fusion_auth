package com.sean.rao.fusion_auth.net;

import android.text.TextUtils;

import com.alicom.tools.serialization.JSONType;
import com.alicom.tools.serialization.JSONUtils;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * @author: cmw01044812
 * @date: 8/31/23
 * @descript:
 */
public class ResultUtils {

    public static GetAuthTokenResult getAuthTokenResult(String result){
        GetAuthTokenResult tokenResult;
        if(TextUtils.isEmpty(result)){
            return null;
        }else {
            try {
                JSONObject object=new JSONObject(result);
                tokenResult= JSONUtils.fromJson(object, new JSONType<GetAuthTokenResult>(){}, null);
            } catch (JSONException e) {
                e.printStackTrace();
                return null;
            }
            return tokenResult;
        }
    }

    public static VerifyTokenResult getVerifyTokenResult(String result){
        VerifyTokenResult tokenResult;
        if(TextUtils.isEmpty(result)){
            return null;
        }else {
            try {
                JSONObject object=new JSONObject(result);
                tokenResult= JSONUtils.fromJson(object, new JSONType<VerifyTokenResult>(){}, null);
            } catch (JSONException e) {
                e.printStackTrace();
                return null;
            }
            return tokenResult;
        }
    }

}
