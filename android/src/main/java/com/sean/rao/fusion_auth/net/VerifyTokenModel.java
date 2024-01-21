package com.sean.rao.fusion_auth.net;

import com.alicom.tools.serialization.JSONUtils;
import com.alicom.tools.serialization.JSONer;

import org.json.JSONObject;

/**
 * @author: cmw01044812
 * @date: 8/31/23
 * @descript:
 */
public class VerifyTokenModel implements JSONer {

    private String PhoneNumber;

    private String VerifyResult;

    private int PhoneScore;

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        PhoneNumber = phoneNumber;
    }

    public String getVerifyResult() {
        return VerifyResult;
    }

    public void setVerifyResult(String verifyResult) {
        VerifyResult = verifyResult;
    }

    public int getPhoneScore() {
        return PhoneScore;
    }

    public void setPhoneScore(int phoneScore) {
        PhoneScore = phoneScore;
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
