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

package com.sample.android.alchemy.app.login.util

import com.ss.android.lark.core.spi.SpiManager
import com.ss.android.lark.kv.IKVStorageApi

/**
 * KVUtils 单例对象，用于提供键值存储的工具方法。
 * 通过SpiManager加载IKVStorageApi的实现，实现对键值存储的读写操作。
 */
object KVUtils {
    private val kvStorageImpl by lazy(LazyThreadSafetyMode.NONE) {
        SpiManager.getInstance().getSpi()?.loadClass(IKVStorageApi::class.java)
    }

    /**
     * 向键值存储中存入布尔类型的值。
     *
     * @param key 存储的键。
     * @param value 存储的布尔值。
     */
    fun putBoolean(key: String, value: Boolean) {
        kvStorageImpl?.putBoolean(key, value)
    }

    /**
     * 从键值存储中获取布尔类型的值。
     *
     * @param key 要获取值的键。
     * @param defaultValue 如果键不存在时返回的默认值。
     * @return 键对应的值，如果键不存在则返回默认值。
     */
    fun getBoolean(key: String, defaultValue: Boolean): Boolean {
        return kvStorageImpl?.getBoolean(key, defaultValue) ?: defaultValue
    }

    /**
     * 向键值存储中存入字符串类型的值。
     *
     * @param key 存储的键。
     * @param value 存储的字符串值。
     */
    fun putString(key: String, value: String) {
        kvStorageImpl?.putString(key, value)
    }

    /**
     * 从键值存储中获取字符串类型的值。
     *
     * @param key 要获取值的键。
     * @param defaultValue 如果键不存在时返回的默认值。
     * @return 键对应的值，如果键不存在则返回默认值。
     */
    fun getString(key: String, defaultValue: String): String {
        return kvStorageImpl?.getString(key, defaultValue) ?: defaultValue
    }

    /**
     * 检查键值存储中是否包含指定的键。
     *
     * @param key 要检查的键。
     * @return 如果包含指定的键返回true，否则返回false。
     */
    fun hasKey(key: String): Boolean {
        return kvStorageImpl?.contains(key) ?: false
    }
}