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

package com.sample.android.alchemy.shortcut

import android.content.Context
import com.ss.android.lark.shortcut.IShortcutApi
import com.ss.android.lark.shortcut.ShortcutImpl

/**
 * 该类实现了 [IShortcutApi] 接口，用于定义一个Todo快捷方式。
 */
@ShortcutImpl
class ShortcutTodo : IShortcutApi {
    override fun getId(context: Context): String {
        return "uitest_ka_cd_shortcut2"
    }

    override fun getIcon(context: Context): Int{
        return R.drawable.alchemy_sample_task
    }

    override fun getShortLabel(context: Context): String {
        return context.getString(R.string.alchemy_sample_shortcut_open_todo)
    }

    override fun getLongLabel(context: Context): String {
        return context.getString(R.string.alchemy_sample_shortcut_open_todo)
    }

    override fun getApplink(context: Context): String {
        return "lark://applink.feishu.cn/client/todo/open"
    }
}