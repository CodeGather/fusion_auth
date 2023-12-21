package com.sean.rao.fusion_auth.utils;

import android.content.Context;

import com.alibaba.fastjson2.JSONObject;
import com.alicom.fusion.auth.AlicomFusionBusiness;

import io.flutter.plugin.common.MethodChannel;

/**
 * @Package: com.alicom.fusion.demo
 * @Description:
 * @CreateDate: 2023/2/15
 */
public class FusionAuthUtil {
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

    // 获取版本号
    public void getVersion(){
        String version = AlicomFusionBusiness.getSDKVersion();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("resultCode", "999999");
        jsonObject.put("resultMsg", String.format("插件启动成功, 原生SDK版本: %s", version));
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
