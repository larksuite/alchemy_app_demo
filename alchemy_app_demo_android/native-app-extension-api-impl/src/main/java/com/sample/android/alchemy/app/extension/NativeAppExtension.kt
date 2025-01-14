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

    // 换成自己的appId。
    override fun getAppId(): String {
        return "YOUR_APP_ID"
    }

    override fun pageRoute(context: Context, linkUrl: String) {
        Log.i(
            TAG,
            "pageRoute linkUrl is $linkUrl"
        )

        LoginActivity.launch(context, linkUrl)
    }
}