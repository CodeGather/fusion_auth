package com.sean.rao.fusion_auth.common;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * @Package: com.alicom.fusion.demo
 * @Description:
 * @CreateDate: 2023/2/15
 */
public class GlobalManager {

    private String token;

    private Context mContext;

    public String getUserInfo() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences("user_info", Context.MODE_PRIVATE);
        String userId = sharedPreferences.getString("username", "");
        return userId;
    }

    public void setUserInfo(String userInfo) {
        SharedPreferences.Editor editor = mContext.getSharedPreferences("user_info", Context.MODE_PRIVATE).edit();
        editor.putString("username", userInfo);
        editor.apply();
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getToken() {
        return token;
    }

    public void setContext(Context context) {
        this.mContext = context;
    }

    public Context getContext() {
        return mContext;
    }

    private static class Holder {
        private static final GlobalManager INSTANCE = new GlobalManager();
    }

    private GlobalManager() {
    }

    public static GlobalManager getInstance() {
        return Holder.INSTANCE;
    }
}
