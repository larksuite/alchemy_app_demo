package com.sample.android.alchemy.tab.container.mail.bean

import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import kotlin.random.Random
import com.sample.android.alchemy.tab.container.R

object MockData {
    val dataList: List<MailBean> by lazy {
        loadData()
    }

    private fun loadData(): List<MailBean> {
        val list = mutableListOf<MailBean>()
        val avatarBgColors = arrayOf(
            R.color.alchemy_sample_tab_color_blue,
            R.color.alchemy_sample_tab_color_red,
            R.color.alchemy_sample_tab_color_yellow,
            R.color.alchemy_sample_tab_color_green,
            R.color.alchemy_sample_tab_color_orange,
            R.color.alchemy_sample_tab_color_purple,
        )
        val formatter = SimpleDateFormat("MM月dd日", Locale.getDefault())

        for (i in 1..100) {
            list.add(
                MailBean(
                    "$i",
                    avatarBgColors[Random.nextInt(avatarBgColors.size)],
                    "原生集成@$i",
                    "原生集成是指飞书开放了多个业务场景，提供配套工具，让三方能力能够在飞书内被调用，且达到原生代码的体验。原生集成提高了飞书的开放性和灵活性，可以满足客户更多原生定制的集成场景",
                    formatter.format(Calendar.getInstance().time)
                )
            )
        }

        return list
    }
}