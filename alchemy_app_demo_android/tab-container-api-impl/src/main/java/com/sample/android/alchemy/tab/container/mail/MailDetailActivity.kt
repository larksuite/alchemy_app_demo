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

class MailDetailActivity : BaseBindingActivity<AlchemySampleActivityMailDetailBinding>(
    AlchemySampleActivityMailDetailBinding::inflate
) {
    companion object {
        private const val KEY_TITLE = "title"
        private const val KEY_CONTENT = "content"
        private const val PICK_FILE_REQUEST_CODE = 1

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

    private fun forwardFile(data: Uri) {
        val spiManager = SpiManager.getInstance().getSpi() ?: return
        val messageApi = spiManager.loadClass(IMessageApi::class.java)
        val messageBody = FileMessageBody().apply {
            uri = data
        }
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