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

package com.sample.android.alchemy.tab.container.mail.lark

import com.ss.android.lark.tab.ITabPageConfig

/**
 * KATabViewConfig 类实现了 [ITabPageConfig.ITabViewConfig] 接口，用于Tab标签点击后的事件。
 * 在这个例子中，没有配置事件。
 */
class KATabViewConfig : ITabPageConfig.ITabViewConfig {

    override fun getClickListener(): ITabPageConfig.TabViewClickListener {
        return object : ITabPageConfig.TabViewClickListener {
            override fun onSingleClick() {
                // 单点击事件处理逻辑，当前为空
            }

            override fun onDoubleClick() {
                // 双点击事件处理逻辑，当前为空
            }
        }
    }
}
