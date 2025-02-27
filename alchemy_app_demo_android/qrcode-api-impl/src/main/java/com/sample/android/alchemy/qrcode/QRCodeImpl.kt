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

package com.sample.android.alchemy.qrcode

import android.content.Context
import com.sample.android.alchemy.lifecycle.ContextHolder
import com.ss.android.lark.core.spi.SpiManager
import com.ss.android.lark.extension_interfaces.IApiGateway
import com.ss.android.lark.extension_model.NativeAppPluginEvent
import com.ss.android.lark.qrcode.IQRCodeApi
import com.ss.android.lark.qrcode.QRCodeImpl
import org.json.JSONObject

/**
 * 该类实现了 [IQRCodeApi] 接口，用于处理二维码扫描结果的拦截和处理。
 */
@QRCodeImpl
class QRCodeImpl : IQRCodeApi {
    companion object {
        private const val INTERCEPT_KEY = "DemoIntercept"
        private const val HANDLE_KEY = "DemoHandle"
    }

    private fun showToast(context: Context, message: String) {
        val gateway =
            SpiManager.getInstance().getSpi()?.loadClass(IApiGateway::class.java) ?: return
        gateway.invokeLarkApi(
            context,
            NativeAppPluginEvent("showToast", "YOUR_APP_ID", JSONObject().apply {
                put("title", message)
            }),
            null
        )
    }

    /**
     * 二维码扫描拦截处理方法。
     *
     * @param result 二维码扫描结果。
     * @return 如果扫描结果包含 [INTERCEPT_KEY]，则返回 true 表示拦截并自行处理；否则返回 false 放行给系统处理。
     */
    override fun interceptHandle(result: String): Boolean {
        val context = ContextHolder.getContext()
        showToast(context, "interceptHandle: $result")
        return result.contains(INTERCEPT_KEY)
    }

    /**
     * 二维码结果处理方法。
     *
     * @param result 二维码扫描结果。
     * @return 如果扫描结果包含 [HANDLE_KEY]，则返回 true 表示已处理；否则返回 false 表示未处理。
     */
    override fun handle(result: String): Boolean {
        val context = ContextHolder.getContext()
        showToast(context, "handle: $result")
        // Open your activity here
        return result.contains(HANDLE_KEY)
    }
}