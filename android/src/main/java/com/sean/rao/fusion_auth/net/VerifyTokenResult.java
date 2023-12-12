package com.sean.rao.fusion_auth.net;

import com.alicom.tools.serialization.JSONType;
import com.alicom.tools.serialization.JSONUtils;
import com.alicom.tools.serialization.JSONer;

import org.json.JSONObject;

/**
 * @author: cmw01044812
 * @date: 8/31/23
 * @descript:
 */
public class VerifyTokenResult implements JSONer {


    private String RequestId;

    private String Code;

    private boolean Success;

    private VerifyTokenModel Data;


    public String getRequestId() {
        return RequestId;
    }

    public void setRequestId(String requestId) {
        RequestId = requestId;
    }

    public String getCode() {
        return Code;
    }

    public void setCode(String code) {
        Code = code;
    }

    public boolean isSuccess() {
        return Success;
    }

    public void setSuccess(boolean success) {
        Success = success;
    }


    public VerifyTokenModel getData() {
        return Data;
    }

    public void setData(VerifyTokenModel data) {
        Data = data;
    }

    @Override
    public JSONObject toJson() {
        return null;
    }

    @Override
    public void fromJson(JSONObject jsonObject) {
        JSONUtils.fromJson(jsonObject, this, null);
        if(jsonObject!=null&&jsonObject.optJSONObject("Data")!=null){
            VerifyTokenModel model= JSONUtils.fromJson(jsonObject.optJSONObject("Data"), new JSONType<VerifyTokenModel>(){}, null);
            setData(model);
        }
    }
}
