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

package com.sample.android.alchemy.app.login

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.sample.android.alchemy.app.login.network.Network
import com.sample.android.alchemy.app.login.network.Network.NetworkResult
import com.sample.android.alchemy.app.login.network.login.response.LoginResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/**
 * LoginViewModel 类，用于管理登录相关的数据和操作。
 */
class LoginViewModel : ViewModel() {
    private val _landUrlData: MutableLiveData<String> = MutableLiveData()

    /**
     * 登录成功后需要跳转的落地页URL
     */
    val landUrlData: LiveData<String> = _landUrlData

    /**
     * 设置落地页URL并通知观察者
     * @param landUrl 登录成功后需要跳转的落地页URL
     */
    fun setLandUrl(landUrl: String) {
        _landUrlData.postValue(landUrl)
    }

    private val _loginResult: MutableLiveData<NetworkResult<LoginResponse>> = MutableLiveData()

    /**
     * 登录操作的结果
     */
    val loginResult: LiveData<NetworkResult<LoginResponse>> = _loginResult

    /**
     * 执行登录操作
     * @param username 用户名
     * @param password 密码
     * @param state 从URL解析的state参数
     * 在IO线程发起网络请求，并通过LiveData通知结果
     */
    fun login(username: String, password: String, state: String) {
        viewModelScope.launch(Dispatchers.IO) {
            _loginResult.postValue(
                Network.login(
                    username,
                    password,
                    state
                )
            )
        }
    }
}