package com.sample.android.alchemy.app.login.network.login.response

import com.google.gson.annotations.SerializedName

data class LoginResponseData(
    @SerializedName("next_step")
    val nextStep: String,

    @SerializedName("step_info")
    val stepInfo: LoginResponseDataStepInfo
)
