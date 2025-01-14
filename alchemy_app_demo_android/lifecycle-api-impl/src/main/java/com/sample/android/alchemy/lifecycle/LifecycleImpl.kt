package com.sample.android.alchemy.lifecycle

import android.content.Context
import com.sample.android.alchemy.logger.Log
import com.ss.android.lark.alchemy.lifecycle.AppState
import com.ss.android.lark.alchemy.lifecycle.ILifecycleApi
import com.ss.android.lark.alchemy.lifecycle.Lifecycle

@Lifecycle
class LifecycleImpl : ILifecycleApi {
    companion object {
        private const val TAG = "LifecycleImpl"
    }

    override fun onStart(context: Context) {
        Log.i(TAG, "onStart")
    }

    override fun onResume(context: Context) {
        Log.i(TAG, "onResume")
    }

    override fun onPause(context: Context) {
        Log.i(TAG, "onPause")
    }

    override fun onAppStateChanged(context: Context, oldState: AppState, newState: AppState) {
        Log.i(
            TAG,
            "[onAppStateChanged] oldState: ${oldState.isFront}, newState: ${newState.isFront}"
        )
    }

    override fun onLoginSuccess(context: Context, isFastLogin: Boolean) {
        Log.i(TAG, "[onLoginSuccess] isFastLogin: $isFastLogin")
    }

    override fun onLoginFail(context: Context, isFastLogin: Boolean) {
        Log.i(TAG, "[onLoginFail] isFastLogin: $isFastLogin")
    }

    override fun onLogout(context: Context) {
        Log.i(TAG, "onLogout")
    }
}