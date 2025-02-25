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

package com.sample.android.alchemy.tab.container.mail.bean

import androidx.annotation.ColorRes

/**
 * 邮件数据。
 *
 * @property avatarText 头像文本。
 * @property avatarBgColor 头像背景颜色。
 * @property title 标题。
 * @property content 内容。
 * @property time 时间。
 */
data class MailBean(
    val avatarText: String,
    @ColorRes
    val avatarBgColor: Int,
    val title: String,
    val content: String,
    val time: String
)
