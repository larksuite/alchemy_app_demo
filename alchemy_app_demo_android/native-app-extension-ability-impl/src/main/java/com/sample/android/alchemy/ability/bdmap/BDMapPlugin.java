package com.sample.android.alchemy.ability.bdmap;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.text.TextUtils;
import android.util.Log;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.ss.android.lark.extension_interfaces.ApiResult;
import com.ss.android.lark.extension_interfaces.IApiCallback;
import com.ss.android.lark.extension_interfaces.INativeAppPlugin;
import com.ss.android.lark.extension_interfaces.INativeAppPluginContext;
import com.ss.android.lark.extension_model.NativeAppPluginEvent;
import com.ss.android.lark.extension_model.NativeAppPluginResult;

public class BDMapPlugin implements INativeAppPlugin {
    private static final String TAG = "BDMapPlugin";
    private static final int LOCATION_PERMISSION_REQUEST_CODE = 1;

    private BDMapService mLocService;
    private BDMapService mPoiService;

    @Override
    public void onCreate(INativeAppPluginContext iNativeAppPluginContext) {
    }

    @Override
    public NativeAppPluginResult handleEvent(Context context, NativeAppPluginEvent event, IApiCallback callback) {
        Log.i(TAG, "handleEvent call, eventName: " + event.getEventName());
        requestLocationPermission(context);

        if (TextUtils.equals(event.getEventName(), Constants.JsApi.GET_LOCATION)) {
            handleGetLocation(context, callback);
        } else if (TextUtils.equals(event.getEventName(), Constants.JsApi.GET_RESTAURANTS)) {
            handleGetRestaurants(context, callback);
        }

        return null;
    }

    private void handleGetLocation(Context context, IApiCallback callback) {
        if (mLocService == null) {
            mLocService = new BDMapService(context);
        }
        mLocService.getCurrentLocation(jsonObject -> {
            Log.i(TAG, "handleGetLocation, jsonObject: " + jsonObject);
            callback.onResult(jsonObject != null ? ApiResult.SUCCESS : ApiResult.FAIL, jsonObject);
            return null;
        });
    }

    private void handleGetRestaurants(Context context, IApiCallback callback) {
        if (mPoiService == null) {
            mPoiService = new BDMapService(context);
        }
        mPoiService.getNearbyRestaurants(jsonObject -> {
            Log.i(TAG, "handleGetRestaurants, jsonObject: " + jsonObject);
            callback.onResult(jsonObject != null ? ApiResult.SUCCESS : ApiResult.FAIL, jsonObject);
            return null;
        });
    }

    private void requestLocationPermission(Context context) {
        if (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions((Activity) context,
                    new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, LOCATION_PERMISSION_REQUEST_CODE
            );
        }
    }

    @Override
    public boolean handleActivityResult(int requestCode, int resultCode, Intent data) {
        return false;
    }

    @Override
    public void release() {

    }
}
