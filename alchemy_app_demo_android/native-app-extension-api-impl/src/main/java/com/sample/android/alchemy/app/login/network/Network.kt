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

object Network {
    private const val TAG = "Network"

    private var client: OkHttpClient

    init {
        val loggingInterceptor = HttpLoggingInterceptor()
        loggingInterceptor.level = HttpLoggingInterceptor.Level.BODY
        client = OkHttpClient.Builder().build()
    }

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

    private suspend inline fun <reified T> Response.toNetworkResponse(): NetworkResult<T> {
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


    sealed interface NetworkResult<out T> {
        data class Success<T>(val content: T) : NetworkResult<T>

        sealed interface Failure : NetworkResult<Nothing> {
            data class Exception(val throwable: Throwable) : Failure

            data class BizError(val msg: String) : Failure
        }
    }
}