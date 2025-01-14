package com.sample.android.alchemy.shortcut

import android.content.Context
import com.ss.android.lark.shortcut.IShortcutApi
import com.ss.android.lark.shortcut.ShortcutImpl

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