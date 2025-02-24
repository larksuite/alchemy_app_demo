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

package com.sample.android.alchemy.lifecycle

import android.content.Context
import com.sample.android.alchemy.logger.Log
import com.ss.android.lark.alchemy.lifecycle.AppState
import com.ss.android.lark.alchemy.lifecycle.ILifecycleApi
import com.ss.android.lark.alchemy.lifecycle.Lifecycle

/**
 * 该类实现了 [ILifecycleApi] 接口，用于处理应用的生命周期事件。
 * 使用 [Lifecycle] 注解标记，表明它是一个生命周期相关的实现类。
 *
 */
@Lifecycle
class LifecycleImpl : ILifecycleApi {
    companion object {
        private const val TAG = "LifecycleImpl"
    }

    /**
     * 当应用启动时调用此方法。
     *
     * @param context 应用的上下文对象。
     */
    override fun onStart(context: Context) {
        Log.i(TAG, "onStart")
    }

    /**
     * 当应用恢复到前台时调用此方法。
     *
     * @param context 应用的上下文对象。
     */
    override fun onResume(context: Context) {
        Log.i(TAG, "onResume")
    }

    /**
     * 当应用暂停时调用此方法。
     *
     * @param context 应用的上下文对象。
     */
    override fun onPause(context: Context) {
        Log.i(TAG, "onPause")
    }

    /**
     * 当应用的状态发生变化时调用此方法。
     *
     * @param context 应用的上下文对象。
     * @param oldState 应用的旧状态。
     * @param newState 应用的新状态。
     */
    override fun onAppStateChanged(context: Context, oldState: AppState, newState: AppState) {
        Log.i(
            TAG,
            "[onAppStateChanged] oldState: ${oldState.isFront}, newState: ${newState.isFront}"
        )
    }

    /**
     * 当用户登录成功时调用此方法。
     *
     * @param context 应用的上下文对象。
     * @param isFastLogin 是否为快速登录。
     */
    override fun onLoginSuccess(context: Context, isFastLogin: Boolean) {
        Log.i(TAG, "[onLoginSuccess] isFastLogin: $isFastLogin")
    }

    /**
     * 当用户登录失败时调用此方法。
     *
     * @param context 应用的上下文对象。
     * @param isFastLogin 是否为快速登录。
     */
    override fun onLoginFail(context: Context, isFastLogin: Boolean) {
        Log.i(TAG, "[onLoginFail] isFastLogin: $isFastLogin")
    }

    /**
     * 当用户登出时调用此方法。
     *
     * @param context 应用的上下文对象。
     */
    override fun onLogout(context: Context) {
        Log.i(TAG, "onLogout")
    }
}