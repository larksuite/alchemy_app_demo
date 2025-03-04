/*
 * Copyright (c) 2025 Lark Technologies Pte. Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

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

/**
 * BDMapPlugin 类实现了 INativeAppPlugin 接口，用于处理与百度地图相关的插件功能。
 */
public class BDMapPlugin implements INativeAppPlugin {
    private static final String TAG = "BDMapPlugin";
    private static final int LOCATION_PERMISSION_REQUEST_CODE = 1;

    private BDMapService mLocService;
    private BDMapService mPoiService;

    /**
     * 插件创建时调用的方法，目前为空实现。
     *
     * @param iNativeAppPluginContext 插件上下文对象
     */
    @Override
    public void onCreate(INativeAppPluginContext iNativeAppPluginContext) {
    }

    /**
     * 处理插件事件的方法。
     *
     * <b>该方法未针对权限做完整的处理。</b>
     *
     * @param context 上下文对象
     * @param event 插件事件对象
     * @param callback 回调接口，用于返回处理结果
     * @return 插件处理结果对象，目前返回 null
     */
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
