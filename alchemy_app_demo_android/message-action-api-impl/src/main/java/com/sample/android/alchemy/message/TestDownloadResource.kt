package com.sample.android.alchemy.message

import android.content.Context
import android.graphics.drawable.Drawable
import android.widget.Toast
import androidx.appcompat.content.res.AppCompatResources
import com.sample.android.alchemy.logger.Log
import com.ss.android.lark.core.spi.SpiManager
import com.ss.android.lark.ka.message.api.IMessageApi
import com.ss.android.lark.ka.message.api.callback.Callback
import com.ss.android.lark.ka.message.api.model.FileMessageBody
import com.ss.android.lark.ka.message.api.model.Message
import com.ss.android.lark.ka.message.api.model.MessageInfo
import com.ss.android.lark.message.action.IMessageActionApi
import com.ss.android.lark.message.action.MessageActionApi
import com.ss.android.lark.message.action.model.ActionContext
import com.ss.android.lark.message.action.model.ActionMessage

@MessageActionApi
class TestDownloadResource : IMessageActionApi {
    companion object {
        private const val TAG = "MessageAction"
    }

    override fun getIcon(context: Context): Drawable? {
        return AppCompatResources.getDrawable(
            context,
            R.drawable.alchemy_sample_round_file_download
        )
    }

    override fun getLabel(context: Context): String {
        return context.getString(R.string.alchemy_sample_download)
    }

    override fun isVisible(context: Context, actionContext: ActionContext): Boolean {
        return actionContext.actionMessages.any { it.messageType == ActionMessage.Type.FILE }
    }

    override fun onClick(context: Context, actionContext: ActionContext) {
        val messageApi =
            SpiManager.getInstance().getSpi()?.loadClass(IMessageApi::class.java) ?: return

        messageApi.getMessageResource(
            actionContext.actionMessages,
            object : Callback<MutableList<MessageInfo>> {
                override fun onSuccess(t: MutableList<MessageInfo>) {
                    t.forEach { messageInfo ->
                        messageApi.downloadResource(messageInfo, object : Callback<Message> {
                            override fun onSuccess(t: Message?) {
                                Log.d(TAG, "downloadResource success")
                                val path = (t?.messageBody as? FileMessageBody)?.uri?.toString()
                                Toast.makeText(
                                    context, "download success $path",
                                    Toast.LENGTH_SHORT
                                ).show()
                            }

                            override fun onFail(code: Int, msg: String?) {
                                Log.e(
                                    TAG,
                                    "downloadResource " + messageInfo.messageId + " fail, code: " + code + ", msg: " + msg
                                )
                                Toast.makeText(context, "fail,$msg", Toast.LENGTH_SHORT).show()
                            }

                        })
                    }
                }

                override fun onFail(code: Int, msg: String?) {
                    Log.e(TAG, "getMessageResource fail, code: $code, msg: $msg")
                    Toast.makeText(context, "fail,$msg", Toast.LENGTH_SHORT).show()
                }

            })
    }
}