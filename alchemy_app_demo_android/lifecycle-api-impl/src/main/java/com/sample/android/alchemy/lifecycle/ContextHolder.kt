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
import java.lang.ref.WeakReference

/**
 * 仅供未提供Context上下文的场景使用。例如在7.18中QRCode的接口未提供Context作为入参，无法直接打开页面。
 */
object ContextHolder {
    private var _context: WeakReference<Context>? = null

    /**
     * 初始化Context
     * @param context Context
     */
    fun setContext(context: Context) {
        this._context = WeakReference(context)
    }

    /**
     * 获取Context
     * @return Context
     */
    fun getContext(): Context {
        return requireNotNull(_context?.get()) {
            "context require initialization"
        }
    }
}