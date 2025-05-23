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

package com.sample.android.alchemy.tab.container.mail.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.sample.android.alchemy.tab.container.mail.bean.MailBean
import com.sample.android.alchemy.common.ui.base.BaseAdapter
import com.sample.android.alchemy.tab.container.databinding.AlchemySampleItemMailBinding

/**
 * 邮件列表适配器。
 */
class MailAdapter(
    private val context: Context,
    private val onMailItemClickListener: OnMailItemClickListener
) :
    BaseAdapter<MailAdapter.MailViewHolder, MailBean>(MailAlwaysDiff) {

    /**
     * 邮件列表项点击监听器。
     */
    fun interface OnMailItemClickListener {
        /**
         * 点击邮件列表项时调用。
         *
         * @param position 点击的邮件列表项的位置。
         * @param mailItem 点击的邮件列表项的数据。
         */
        fun onClick(position: Int, mailItem: MailBean)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MailViewHolder {
        return MailViewHolder(
            AlchemySampleItemMailBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: MailViewHolder, position: Int) {
        val mailBean = getItem(position)
        holder.binding.apply {
            avatar.text = mailBean.avatarText
            avatar.background = ContextCompat.getDrawable(context, mailBean.avatarBgColor)
            title.text = mailBean.title
            content.text = mailBean.content
            time.text = mailBean.time
        }

        holder.binding.root.setOnClickListener {
            onMailItemClickListener.onClick(position, mailBean)
        }
    }

    /**
     * 邮件列表项的 ViewHolder。
     *
     * @property binding 邮件列表项的绑定对象。
     */
    inner class MailViewHolder(val binding: AlchemySampleItemMailBinding) :
        RecyclerView.ViewHolder(binding.root)

    /**
     * 邮件列表项的 Diff 回调。没有实际的diff逻辑，始终返回false。
     */
    object MailAlwaysDiff : DiffUtil.ItemCallback<MailBean>() {
        override fun areItemsTheSame(oldItem: MailBean, newItem: MailBean): Boolean {
            return false
        }

        override fun areContentsTheSame(oldItem: MailBean, newItem: MailBean): Boolean {
            return false
        }
    }
}