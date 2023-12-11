package com.sean.rao.fusion_auth.config;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.os.Build;

import com.alibaba.fastjson.JSONObject;
import com.mobile.auth.gatewayauth.AuthUIConfig;
import com.mobile.auth.gatewayauth.PhoneNumberAuthHelper;

import io.flutter.plugin.common.EventChannel;

public class FullLandConfig extends BaseUIConfig {

    private int mOldScreenOrientation;

    public FullLandConfig(Activity activity, EventChannel.EventSink _eventSink, JSONObject jsonObject, AuthUIConfig.Builder config, PhoneNumberAuthHelper authHelper) {
        super(activity, _eventSink, jsonObject, config, authHelper);
    }

    @Override
    public void configAuthPage() {
//        mAuthHelper.addAuthRegisterXmlConfig(new AuthRegisterXmlConfig.Builder()
//                .setLayout(R.layout.custom_port_dialog_action_bar, new AbstractPnsViewDelegate() {
//                    @Override
//                    public void onViewCreated(View view) {
//                        findViewById(R.id.tv_title).setVisibility(View.GONE);
//                        findViewById(R.id.btn_close).setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View v) {
//                                mAuthHelper.quitLoginPage();
//                            }
//                        });
//                    }
//                })
//                .build());
        int authPageOrientation = ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE;
        if (Build.VERSION.SDK_INT == 26) {
            mOldScreenOrientation = mActivity.getRequestedOrientation();
            mActivity.setRequestedOrientation(authPageOrientation);
            authPageOrientation = ActivityInfo.SCREEN_ORIENTATION_BEHIND;
        }
        updateScreenSize(authPageOrientation);

        mAuthHelper.setAuthUIConfig(autoConfig.setScreenOrientation(authPageOrientation).create());
    }

    @Override
    public void onResume() {
        super.onResume();
        if (mOldScreenOrientation != mActivity.getRequestedOrientation()) {
            mActivity.setRequestedOrientation(mOldScreenOrientation);
        }
    }
}
