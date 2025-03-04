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

package com.sample.android.alchemy.common.ui.utils

import android.content.Context
import android.widget.Toast
import com.sample.android.alchemy.common.R

/**
 * Demo 中缺失例子时的 Toast。
 */
object NotAvailableToast {
    /**
     * 显示 Demo 中缺失例子时的 Toast。
     *
     * @param context 上下文。
     */
    fun show(context: Context) {
        Toast.makeText(
            context,
            R.string.alchemy_sample_Lark_Demo_ActionNotSupportedInDemo_Toast,
            Toast.LENGTH_SHORT
        ).show()
    }
}