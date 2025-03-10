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

package com.sample.android.alchemy.tab.container.mail.lark;

import android.content.Context;
import com.ss.android.lark.tab.ITabPageConfig;

/**
 * KATabTitleConfig 类实现了 [ITabPageConfig.ITabTitleConfig] 接口，用于配置邮件标签页标题的相关信息。
 * 在这个例子中，没有标题。
 */
class KATabTitleConfig : ITabPageConfig.ITabTitleConfig {

    override fun isShow(): Boolean {
        return false
    }

    override fun getFunctionButtonList(context: Context?): List<ITabPageConfig.ITabTitleConfig.IFunctionButton>? {
        return null
    }

    override fun getClickListener(): ITabPageConfig.TabTitleClickListener? {
        return null
    }

}