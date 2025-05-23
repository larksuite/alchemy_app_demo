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

package com.sample.android.alchemy.app.login.network.login.bean

import com.google.gson.annotations.SerializedName

/**
 * 登录请求的参数。
 *
 * @property username 用户的用户名。
 * @property password 用户的密码。
 */
data class LoginBean(
    @SerializedName("username")
    val username: String,

    @SerializedName("password")
    val password: String
)
