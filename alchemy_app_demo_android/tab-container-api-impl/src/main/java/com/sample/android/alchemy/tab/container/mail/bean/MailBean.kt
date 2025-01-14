package com.sample.android.alchemy.tab.container.mail.bean

import androidx.annotation.ColorRes

data class MailBean(
    val avatarText: String,
    @ColorRes
    val avatarBgColor: Int,
    val title: String,
    val content: String,
    val time: String
)
