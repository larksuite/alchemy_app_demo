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

/**
 * 该类实现了 [IMessageActionApi] 接口，用于在消息菜单列表增加下载资源操作。
 * 使用 @MessageActionApi 注解标记，表明它是一个消息菜单列表的 API 实现。
 */
@MessageActionApi
class TestDownloadResource : IMessageActionApi {
    companion object {
        private const val TAG = "MessageAction"
    }

    /**
     * 获取消息操作的图标。
     *
     * @param context 上下文对象，用于获取资源。
     * @return 返回一个 [Drawable] 对象，表示消息操作的图标。
     */
    override fun getIcon(context: Context): Drawable? {
        return AppCompatResources.getDrawable(
            context,
            R.drawable.alchemy_sample_round_file_download
        )
    }

    /**
     * 获取消息操作的标签。
     *
     * @param context 上下文对象，用于获取字符串资源。
     * @return 返回一个字符串，表示消息菜单项的标签。
     */
    override fun getLabel(context: Context): String {
        return context.getString(R.string.alchemy_sample_download)
    }

    /**
     * 判断消息操作是否可见。
     *
     * @param context 上下文对象。
     * @param actionContext 消息操作的上下文信息。
     * @return 如果消息类型为文件类型，则返回 true；否则返回 false。
     */
    override fun isVisible(context: Context, actionContext: ActionContext): Boolean {
        return actionContext.actionMessages.any { it.messageType == ActionMessage.Type.FILE }
    }

    /**
     * 处理消息操作的点击事件。
     *
     * @param context 上下文对象。
     * @param actionContext 消息操作的上下文信息。
     */
    override fun onClick(context: Context, actionContext: ActionContext) {
        // 通过 SpiManager 加载 IMessageApi 实例，如果获取失败则返回
        val messageApi =
            SpiManager.getInstance().getSpi()?.loadClass(IMessageApi::class.java) ?: return

        // 调用消息 API 获取消息资源
        messageApi.getMessageResource(
            actionContext.actionMessages,
            object : Callback<MutableList<MessageInfo>> {
                override fun onSuccess(t: MutableList<MessageInfo>) {
                    t.forEach { messageInfo ->
                        // 调用消息 API 下载消息资源
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