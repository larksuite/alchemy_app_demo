package com.sample.android.alchemy.app.login.util

import com.ss.android.lark.core.spi.SpiManager
import com.ss.android.lark.kv.IKVStorageApi

object KVUtils {
    private val kvStorageImpl by lazy(LazyThreadSafetyMode.NONE) {
        SpiManager.getInstance().getSpi()?.loadClass(IKVStorageApi::class.java)
    }

    fun putBoolean(key: String, value: Boolean) {
        kvStorageImpl?.putBoolean(key, value)
    }

    fun getBoolean(key: String, defaultValue: Boolean): Boolean {
        return kvStorageImpl?.getBoolean(key, defaultValue) ?: defaultValue
    }

    fun putString(key: String, value: String) {
        kvStorageImpl?.putString(key, value)
    }

    fun getString(key: String, defaultValue: String): String {
        return kvStorageImpl?.getString(key, defaultValue) ?: defaultValue
    }

    fun hasKey(key: String): Boolean {
        return kvStorageImpl?.contains(key) ?: false
    }
}