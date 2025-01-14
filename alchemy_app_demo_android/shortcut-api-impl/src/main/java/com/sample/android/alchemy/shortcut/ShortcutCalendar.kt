package com.sample.android.alchemy.shortcut

import android.content.Context
import com.ss.android.lark.shortcut.IShortcutApi
import com.ss.android.lark.shortcut.ShortcutImpl


@ShortcutImpl
class ShortcutCalendar : IShortcutApi{
    override fun getId(context: Context): String {
        return "uitest_ka_cd_shortcut"
    }

    override fun getIcon(context: Context): Int{
        return R.drawable.alchemy_sample_baseline_calendar_month
    }

    override fun getShortLabel(context: Context): String {
        return context.getString(R.string.alchemy_sample_shortcut_open_calendar)
    }

    override fun getLongLabel(context: Context): String {
        return context.getString(R.string.alchemy_sample_shortcut_open_calendar)
    }

    override fun getApplink(context: Context): String {
        return "lark://applink.feishu.cn/client/calendar/open"
    }
}