package com.sample.android.alchemy.qrcode

import android.content.Context
import android.widget.Toast
import com.ss.android.lark.qrcode.IQRCodeApi
import com.ss.android.lark.qrcode.QRCodeImpl

@QRCodeImpl
class QRCodeImpl: IQRCodeApi {
    companion object {
        private const val INTERCEPT_KEY = "DemoIntercept"
        private const val HANDLE_KEY = "DemoHandle"
    }

    override fun interceptHandle(context: Context, result: String): Boolean {
        Toast.makeText(context, "interceptHandle: $result", Toast.LENGTH_SHORT).show()
        return result.contains(INTERCEPT_KEY)
    }

    override fun handle(context: Context, result: String): Boolean {
        Toast.makeText(context, "handle: $result", Toast.LENGTH_SHORT).show()
        // Open your activity here
        return result.contains(HANDLE_KEY)
    }
}