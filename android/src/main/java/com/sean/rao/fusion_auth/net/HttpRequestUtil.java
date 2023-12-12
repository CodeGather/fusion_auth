package com.sean.rao.fusion_auth.net;

import android.content.Context;
import android.util.Log;

import com.alibaba.fastjson2.JSONObject;
import com.sean.rao.fusion_auth.utils.AppUtils;
import com.sean.rao.fusion_auth.utils.FusionAuthUtils;
import com.sean.rao.fusion_auth.utils.PackageUtil;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;


/**
 * @Package: com.example.fusionauthdemo.net
 * @Description:
 * @CreateDate: 2023/2/13
 */
public class HttpRequestUtil {

    private static final String TAG = "HttpRequestUtil";

    public static GetAuthTokenResult getAuthToken(Context context) {
        StringBuilder builder=new StringBuilder();
        JSONObject dict = FusionAuthUtils.getInstance().getCONFIG();
        builder.append("Action=");
        builder.append(dict.getString("authtokenApi"));
        builder.append("&Platform=Android");
        builder.append("&PackageName=");
        builder.append(AppUtils.getPackageName(context));
        builder.append("&SchemeCode=");
        builder.append(dict.getString("schemeCode"));
        //token有效期 单位 s
        builder.append("&DurationSeconds=");
        builder.append(3600);
        builder.append("&PackageSign=");
        builder.append(PackageUtil.getSign(context));
        String result = getHttp(dict.getString("appServerHost"), builder.toString());
        Log.d(TAG, "getAuthToken result is " + result);
        return ResultUtils.getAuthTokenResult(result);
    }

    public static VerifyTokenResult verifyToken(Context context, String token) {
        StringBuilder builder=new StringBuilder();
        JSONObject dict = FusionAuthUtils.getInstance().getCONFIG();
        builder.append("platform=Android&");
        builder.append("Action=");
        builder.append(dict.getString("verifyApi"));
        builder.append("&SchemeCode=");
        builder.append(dict.getString("schemeCode"));
        builder.append("&VerifyToken=");
        builder.append(token);
        String result = postHttp(dict.getString("appServerHost"), builder.toString());
        Log.d(TAG, "verifyToken result is " + result);
        return ResultUtils.getVerifyTokenResult(result);
    }

    private static String  getHttp(String urlPath, String params) {
        HttpURLConnection conn = null;
        OutputStream out = null;
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        String rsp = null;
        StringBuffer buffer = null;
        try {
            URL url = new URL(urlPath + "?" + params);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(3*1000);
            conn.setReadTimeout(3*1000);
            conn.connect();
            int code = conn.getResponseCode();
            if (code == HttpsURLConnection.HTTP_OK) {
                is = conn.getInputStream();
            } else {
                is = conn.getErrorStream();
            }
            isr = new InputStreamReader(is, "UTF-8");
            br = new BufferedReader(isr);
            buffer = new StringBuffer();
            String line = null;

            while ((line = br.readLine()) != null) {
                buffer.append(line);
            }
            rsp = new String(buffer);
        } catch (IOException e) {
            e.printStackTrace();
            //todo:打印错误信息
            return Log.getStackTraceString(e);
        } finally {
            try {
                if (is != null) {
                    is.close();
                }

                if (isr != null) {
                    isr.close();
                }

                if (br != null) {
                    br.close();
                }

                if (out != null) {
                    out.close();
                }
                if (conn != null) {
                    conn.disconnect();
                }
            } catch (Throwable e) {
                //todo:打印错误信息
                e.printStackTrace();
            }
        }
        return rsp;
    }



    public static String postHttp(String urlPath, String params) {
        HttpURLConnection conn = null;
        OutputStream out = null;
        InputStream is = null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        String rsp = null;
        StringBuffer buffer = null;
        try {
            URL url = new URL(urlPath);
            conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("POST");
            conn.setConnectTimeout(3*1000);
            conn.setReadTimeout(3*1000);
            //conn.setRequestProperty("Host", url.getHost());
            conn.setRequestProperty("Accept", "text/text,text/javascript");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
            conn.connect();
            out = conn.getOutputStream();
            out.write(params.getBytes("utf-8"));
            int code = conn.getResponseCode();
            if (code == HttpsURLConnection.HTTP_OK) {
                is = conn.getInputStream();
            } else {
                is = conn.getErrorStream();
            }
            isr = new InputStreamReader(is, "utf-8");
            br = new BufferedReader(isr);
            buffer = new StringBuffer();
            String line = null;

            while ((line = br.readLine()) != null) {
                buffer.append(line);
            }
            rsp = new String(buffer);
        } catch (SocketTimeoutException e) {
            e.printStackTrace();
            //todo:打印错误信息
            return Log.getStackTraceString(e);
        } catch (IOException e) {
            e.printStackTrace();
            //todo:打印错误信息
            return Log.getStackTraceString(e);
        } finally {
            try {
                if (is != null) {
                    is.close();
                }

                if (isr != null) {
                    isr.close();
                }

                if (br != null) {
                    br.close();
                }

                if (out != null) {
                    out.close();
                }
                if (conn != null) {
                    conn.disconnect();
                }
            } catch (Throwable e) {
                //todo:打印错误信息
                e.printStackTrace();
            }
        }
        return rsp;
    }

}
