package com.sample.android.alchemy.common.ui.utils

import android.content.Context
import android.widget.Toast
import com.sample.android.alchemy.common.R

object NotAvailableToast {
    fun show(context: Context) {
        Toast.makeText(
            context,
            R.string.alchemy_sample_Lark_Demo_ActionNotSupportedInDemo_Toast,
            Toast.LENGTH_SHORT
        ).show()
    }
}