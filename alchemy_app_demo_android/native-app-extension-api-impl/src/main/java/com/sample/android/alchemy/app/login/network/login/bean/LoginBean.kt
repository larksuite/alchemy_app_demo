package com.sample.android.alchemy.app.login.network.login.bean

import com.google.gson.annotations.SerializedName

data class LoginBean(
    @SerializedName("username")
    val username: String,

    @SerializedName("password")
    val password: String
)
