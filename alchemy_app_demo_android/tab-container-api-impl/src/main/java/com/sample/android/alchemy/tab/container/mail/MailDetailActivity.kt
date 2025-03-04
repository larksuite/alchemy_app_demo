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

package com.sample.android.alchemy.tab.container.mail

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import com.sample.android.alchemy.common.ui.base.BaseBindingActivity
import com.sample.android.alchemy.tab.container.R
import com.sample.android.alchemy.tab.container.databinding.AlchemySampleActivityMailDetailBinding
import com.ss.android.lark.core.spi.SpiManager
import com.ss.android.lark.ka.message.api.IMessageApi
import com.ss.android.lark.ka.message.api.model.FileMessageBody
import com.ss.android.lark.ka.message.api.model.Message
import com.ss.android.lark.ka.message.api.model.MessageType

/**
 * 邮件详情页。
 */
class MailDetailActivity : BaseBindingActivity<AlchemySampleActivityMailDetailBinding>(
    AlchemySampleActivityMailDetailBinding::inflate
) {
    companion object {
        private const val KEY_TITLE = "title"
        private const val KEY_CONTENT = "content"
        private const val PICK_FILE_REQUEST_CODE = 1

        /**
         * 跳转到邮件详情页。
         *
         * @param context 上下文对象。
         * @param title 邮件标题。
         * @param content 邮件内容。
         */
        @JvmStatic
        fun launch(context: Context, title: String, content: String) {
            val intent = Intent(context, MailDetailActivity::class.java).apply {
                putExtra(KEY_TITLE, title)
                putExtra(KEY_CONTENT, content)
            }
            context.startActivity(intent)
        }
    }

    private fun openFilePicker() {
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "*/*"
        }

        startActivityForResult(
            Intent.createChooser(
                intent,
                getString(R.string.alchemy_sample_select_file_title)
            ),
            PICK_FILE_REQUEST_CODE
        )
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == PICK_FILE_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            val uri = data?.data
            if (uri == null) {
                Toast.makeText(this, "no file selected", Toast.LENGTH_SHORT).show()
            } else {
                forwardFile(uri)
            }
        }
    }

    /**
     * 使用[IMessageApi]转发选择的文件。
     *
     * @param data 选择的文件的 Uri。
     */
    private fun forwardFile(data: Uri) {
        val spiManager = SpiManager.getInstance().getSpi() ?: return
        // 通过 SpiManager 加载 IMessageApi 实例
        val messageApi = spiManager.loadClass(IMessageApi::class.java)
        // 创建一个文件消息体，并设置文件的 Uri
        val messageBody = FileMessageBody().apply {
            uri = data
        }
        // 调用 IMessageApi 的 forward 方法转发文件消息
        messageApi.forward(this, Message(MessageType.FILE, messageBody))
    }

    private fun initForwardButton() {
        binding.alchemySampleForward.setOnClickListener {
            openFilePicker()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val title = intent.getStringExtra(KEY_TITLE)
        val content = intent.getStringExtra(KEY_CONTENT)
        binding.alchemySampleTitle.text = title
        binding.alchemySampleContent.text = content
        initForwardButton()
    }

}