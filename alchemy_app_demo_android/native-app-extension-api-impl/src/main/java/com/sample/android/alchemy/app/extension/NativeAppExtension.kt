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

package com.sample.android.alchemy.app.extension

import android.content.Context
import com.sample.android.alchemy.app.login.LoginActivity
import com.sample.android.alchemy.logger.Log
import com.ss.android.lark.extension_api.INativeAppExtension
import com.ss.android.lark.extension_api.INativeAppPageRouter
import com.ss.android.lark.extension_api.NativeAppExtensionImpl

@NativeAppExtensionImpl
class NativeAppExtension:  INativeAppExtension, INativeAppPageRouter {
    companion object {
        private const val TAG = "NativeAppExtension"
    }

    override fun init() {

    }

    override fun destroy() {

    }

    /**
     * 获取应用 ID 的方法。
     * 注意：需要将返回值替换为自己的应用 ID。
     *
     * @return 返回应用的 ID，当前返回的是占位符 "YOUR_APP_ID"。
     */
    override fun getAppId(): String {
        return "YOUR_APP_ID"
    }

    /**
     * 处理页面路由的方法。
     * 该方法会记录路由链接的日志，并启动 [LoginActivity] 页面。
     *
     * @param context 上下文对象，用于启动页面。
     * @param linkUrl 路由链接。
     */
    override fun pageRoute(context: Context, linkUrl: String) {
        Log.i(
            TAG,
            "pageRoute linkUrl is $linkUrl"
        )

        LoginActivity.launch(context, linkUrl)
    }
}