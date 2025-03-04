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

package com.sample.android.alchemy.app.login.network

import com.google.gson.Gson
import com.sample.android.alchemy.app.login.network.login.bean.LoginBean
import com.sample.android.alchemy.app.login.network.login.response.LoginResponse
import com.sample.android.alchemy.logger.Log
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.MediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.Response
import okhttp3.logging.HttpLoggingInterceptor
import okio.BufferedSource
import java.nio.charset.Charset

/**
 * Network 单例对象，负责处理网络请求相关的操作。
 * 提供了登录方法，以及将请求转换为网络响应的工具方法。
 */
object Network {
    private const val TAG = "Network"

    private var client: OkHttpClient

    init {
        val loggingInterceptor = HttpLoggingInterceptor()
        loggingInterceptor.level = HttpLoggingInterceptor.Level.BODY
        client = OkHttpClient.Builder().build()
    }

    /**
     * 执行登录操作的挂起函数。
     * 该函数会构建一个登录请求，发送到指定的 URL，并返回登录结果。
     *
     * @param username 用户的用户名。
     * @param password 用户的密码。
     * @param state 登录状态参数。
     * @return 包含登录响应的网络结果对象。
     */
    suspend fun login(
        username: String,
        password: String,
        state: String
    ): NetworkResult<LoginResponse> {
        val request = Request.Builder()
            .url("YOUR_URL?client_id=YOUR_CLIENT_ID&state=$state")
            .addHeader("Content-Type", "application/json")
            .addHeader("Accept", "*/*")
            .post(
                RequestBody.create(
                    MediaType.parse("application/json; charset=utf-8"),
                    Gson().toJson(
                        LoginBean(
                            username,
                            password
                        )
                    )
                )
            )
            .build()
        return newRequest(request).toNetworkResponse()
    }

    private suspend fun newRequest(request: Request): Response =
        withContext(Dispatchers.IO) { client.newCall(request).execute() }

    private inline fun <reified T> Response.toNetworkResponse(): NetworkResult<T> {
        if (!isSuccessful) {
            return NetworkResult.Failure.BizError("Request failed, code: ${code()}, message: ${message()}")
        }

        val responseBody = body() ?: return NetworkResult.Failure.BizError("no response body")

        try {
            val source: BufferedSource = responseBody.source()
            source.request(Long.MAX_VALUE) // Buffer the entire body.
            val buffer = source.buffer()
            val responseString = buffer.clone().readString(Charset.forName("UTF-8"))

            val response = Gson().fromJson(
                responseString,
                T::class.java
            )
            return NetworkResult.Success(response)
        } catch (e: Exception) {
            Log.e(TAG, "toNetworkResponse error", e)
            return NetworkResult.Failure.Exception(e)
        }
    }


    /**
     * 网络请求结果的通用接口。
     * 该接口定义了两种类型的网络请求结果：成功和失败。
     *
     * @param T 网络请求的响应类型。
     */
    sealed interface NetworkResult<out T> {
        /**
         * 表示网络请求成功的结果。
         *
         * @param T 网络请求的响应类型。
         * @property content 网络请求的响应内容。
         */
        data class Success<T>(val content: T) : NetworkResult<T>

        /**
         * 表示网络请求失败的结果。
         * 该结果包含两种类型的失败：异常和业务错误。
         */
        sealed interface Failure : NetworkResult<Nothing> {
            /**
             * 表示网络请求抛出的异常。
             *
             * @property throwable 抛出的异常对象。
             */
            data class Exception(val throwable: Throwable) : Failure

            /**
             * 表示网络请求返回的业务错误。
             *
             * @property msg 业务错误的消息。
             */
            data class BizError(val msg: String) : Failure
        }
    }
}