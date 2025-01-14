package com.sample.android.alchemy.logger

import com.ss.android.lark.alchemy.logger.ILoggerApi
import com.ss.android.lark.core.spi.SpiManager

object Log {
    private val logger by lazy {
        SpiManager.getInstance().getSpi()?.loadClass(ILoggerApi::class.java)
    }

    @JvmStatic
    fun v(tag: String, message: String) {
        logger?.v(tag, message)
    }

    @JvmStatic
    fun d(tag: String, message: String) {
        logger?.d(tag, message)
    }

    @JvmStatic
    fun i(tag: String, message: String) {
        logger?.i(tag, message)
    }

    @JvmStatic
    fun w(tag: String, message: String) {
        logger?.w(tag, message)
    }

    @JvmStatic
    @JvmOverloads
    fun e(tag: String, message: String, throwable: Throwable? = null) {
        logger?.e(tag, message, throwable)
    }
}