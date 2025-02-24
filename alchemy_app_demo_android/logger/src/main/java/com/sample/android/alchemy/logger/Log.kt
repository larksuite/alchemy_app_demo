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

package com.sample.android.alchemy.logger

import com.ss.android.lark.alchemy.logger.ILoggerApi
import com.ss.android.lark.core.spi.SpiManager

/**
 * Log 单例对象，用于管理日志记录功能。
 * 该对象通过 SpiManager 加载 ILoggerApi 实现，并提供不同级别的日志记录方法。
 */
object Log {
    private val logger by lazy {
        SpiManager.getInstance().getSpi()?.loadClass(ILoggerApi::class.java)
    }

    /**
     * 记录详细级别的日志。
     *
     * @param tag 日志标签，用于标识日志来源。
     * @param message 日志消息内容。
     */
    @JvmStatic
    fun v(tag: String, message: String) {
        logger?.v(tag, message)
    }

    /**
     * 记录调试级别的日志。
     *
     * @param tag 日志标签，用于标识日志来源。
     * @param message 日志消息内容。
     */
    @JvmStatic
    fun d(tag: String, message: String) {
        logger?.d(tag, message)
    }

    /**
     * 记录信息级别的日志。
     *
     * @param tag 日志标签，用于标识日志来源。
     * @param message 日志消息内容。
     */
    @JvmStatic
    fun i(tag: String, message: String) {
        logger?.i(tag, message)
    }

    /**
     * 记录警告级别的日志。
     *
     * @param tag 日志标签，用于标识日志来源。
     * @param message 日志消息内容。
     */
    @JvmStatic
    fun w(tag: String, message: String) {
        logger?.w(tag, message)
    }

    /**
     * 记录错误级别的日志。
     *
     * @param tag 日志标签，用于标识日志来源。
     * @param message 日志消息内容。
     * @param throwable 可选的异常对象，用于记录错误信息。
     */
    @JvmStatic
    @JvmOverloads
    fun e(tag: String, message: String, throwable: Throwable? = null) {
        logger?.e(tag, message, throwable)
    }
}