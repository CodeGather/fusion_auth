package com.sean.rao.fusion_auth.common;

import android.content.Context;
import android.content.SharedPreferences;

import io.flutter.plugin.common.MethodChannel;

/**
 * @Package: com.alicom.fusion.demo
 * @Description:
 * @CreateDate: 2023/2/15
 */
public class GlobalManager {
    private GlobalManager() {
    }

    private static class Holder {
        private static final GlobalManager INSTANCE = new GlobalManager();
    }

    public static GlobalManager getInstance() {
        return Holder.INSTANCE;
    }

    private MethodChannel channel;

    private Boolean DEBUG_MODE;

    private String TOKEN;

    private String TEMLATEID;

    private String SCHEME_CODE;

    private String CONFIG;

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

    public String getCONFIG() {
        return CONFIG;
    }

    public void setCONFIG(String CONFIG) {
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
