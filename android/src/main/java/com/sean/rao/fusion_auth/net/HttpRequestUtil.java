package com.sean.rao.fusion_auth.net;

import android.content.Context;
import android.util.Log;

import com.sean.rao.fusion_auth.utils.PackageUtil;
import com.sean.rao.fusion_auth.utils.FusionUtilTool;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

public class HttpRequestUtil {

    private static final String TAG = "HttpRequestUtil";

    public static AuthTokenResult getAuthToken(Context context) {
        StringBuilder builder=new StringBuilder();
        builder.append("Action=");
        // builder.append(Constant.GETAUTHREQUESTACTION);
        builder.append("&Platform=Android");
        builder.append("&PackageName=");
        builder.append(FusionUtilTool.getPackageName(context));
        builder.append("&SchemeCode=");
        // builder.append(Constant.SCHEME_CODE);
        //token有效期 单位 s
        builder.append("&DurationSeconds=");
        builder.append(3600);
        builder.append("&PackageSign=");
        builder.append(PackageUtil.getSign(context));
        String result = ""; // getHttp(Constant.NETURL, builder.toString());
        Log.d(TAG, "getAuthToken result is " + result);
        AuthTokenResult authTokenResult = HttpResultUtils.getAuthTokenResult(result);
        return authTokenResult;
    }

    public static VerifyTokenResult verifyToken(Context context, String token) {
        StringBuilder builder=new StringBuilder();
        builder.append("platform=Android&");
        builder.append("Action=");
        // builder.append(Constant.VERIFYREQUESTACTION);
        builder.append("&SchemeCode=");
        // builder.append(Constant.SCHEME_CODE);
        builder.append("&VerifyToken=");
        builder.append(token);
        String result = ""; // postHttp(Constant.NETURL, builder.toString());
        Log.d(TAG, "verifyToken result is " + result);
        VerifyTokenResult verifyTokenResult = HttpResultUtils.getVerifyTokenResult(result);
        return verifyTokenResult;
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
