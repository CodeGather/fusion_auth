package com.sean.rao.fusion_auth.net;

import com.alicom.tools.serialization.JSONUtils;
import com.alicom.tools.serialization.JSONer;

import org.json.JSONObject;

/**
 * @author: cmw01044812
 * @date: 8/31/23
 * @descript:
 */
public class GetAuthTokenResult implements JSONer {

    private String RequestId;
    private String Model;
    private String Code;
    private boolean Success;

    public String getRequestId() {
        return RequestId;
    }

    public void setRequestId(String requestId) {
        RequestId = requestId;
    }

    public String getModel() {
        return Model;
    }

    public void setModel(String model) {
        Model = model;
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

    @Override
    public JSONObject toJson() {
        return null;
    }

    @Override
    public void fromJson(JSONObject jsonObject) {
        JSONUtils.fromJson(jsonObject, this, null);
    }
}
