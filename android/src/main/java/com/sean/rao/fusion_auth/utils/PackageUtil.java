package com.sean.rao.fusion_auth.utils;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;

import java.security.MessageDigest;

/**
 * @Package: com.example.fusionauthdemo
 * @Description:
 * @CreateDate: 2023/2/9
 */
public class PackageUtil {
    private static String APP_SIGNATURE = null;

    public static String getSign(Context context) {
        try {
            if (APP_SIGNATURE == null) {
                PackageInfo packageInfo = context.getPackageManager().getPackageInfo(
                        context.getPackageName(), PackageManager.GET_SIGNATURES);
                Signature[] signs = packageInfo.signatures;
                Signature sign = signs[0];
                APP_SIGNATURE = hexdigest(sign.toByteArray());
            }
            return APP_SIGNATURE;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    private static final char[] HEX_DIGITS = {48, 49, 50, 51, 52, 53, 54, 55,
            56, 57, 97, 98, 99, 100, 101, 102
    };

    public static String hexdigest(byte[] paramArrayOfByte) {
        try {
            MessageDigest localMessageDigest = MessageDigest.getInstance("MD5");
            localMessageDigest.update(paramArrayOfByte);
            byte[] arrayOfByte = localMessageDigest.digest();
            char[] arrayOfChar = new char[32];
            int i = 0;
            int j = 0;
            while (true) {
                if (i >= 16) {
                    return new String(arrayOfChar);
                }
                int k = arrayOfByte[i];
                int m = j + 1;
                arrayOfChar[j] = HEX_DIGITS[(0xF & k >>> 4)];
                j = m + 1;
                arrayOfChar[m] = HEX_DIGITS[(k & 0xF)];
                i++;
            }
        } catch (Exception localException) {
        }
        return null;
    }
}
