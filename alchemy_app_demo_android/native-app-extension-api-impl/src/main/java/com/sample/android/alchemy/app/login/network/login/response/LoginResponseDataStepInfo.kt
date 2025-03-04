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

package com.sample.android.alchemy.app.login.network.login.response

import com.google.gson.annotations.SerializedName

/**
 * 登录响应数据中的步骤信息。
 *
 * @property landUrl 登录成功后重定向的 URL。
 */
data class LoginResponseDataStepInfo(@SerializedName("land_url") val landUrl: String)
