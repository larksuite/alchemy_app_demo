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

package com.sample.android.alchemy.tab.container.mail

import androidx.fragment.app.Fragment
import com.sample.android.alchemy.tab.container.mail.lark.KATabFragment
import com.sample.android.alchemy.tab.container.mail.lark.KATabTitleConfig
import com.sample.android.alchemy.tab.container.mail.lark.KATabViewConfig
import com.ss.android.lark.tab.ITabPageConfig
import com.ss.android.lark.tab.TabPageConfig

/**
 * KAMailTab 类实现了 [ITabPageConfig] 接口，用于配置邮件标签页的相关信息。
 */
@TabPageConfig
class KAMailTab : ITabPageConfig {

    /**
     * 获取当前标签页所属应用的 ID。
     * 注意：返回的是占位符 "YOUR_APP_ID"，需要替换为实际的应用 ID。
     *
     * @return 应用的 ID。
     */
    override fun getAppId(): String {
        return "YOUR_APP_ID"
    }

    override fun getTabViewConfig(): ITabPageConfig.ITabViewConfig {
        return KATabViewConfig()
    }

    override fun interceptBackPress(): Boolean {
        return false
    }

    override fun getTabContent(): Fragment {
        return KATabFragment()
    }

    override fun getTabTitleConfig(): ITabPageConfig.ITabTitleConfig {
        return KATabTitleConfig()
    }
}
