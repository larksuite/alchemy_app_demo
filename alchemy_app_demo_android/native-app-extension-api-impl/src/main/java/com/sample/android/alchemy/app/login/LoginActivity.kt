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

package com.sample.android.alchemy.app.login

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.sample.android.alchemy.app.extension.databinding.AlchemySampleActivityLoginBinding
import com.sample.android.alchemy.common.ui.base.BaseBindingActivity
import com.sample.android.alchemy.logger.Log
import com.ss.android.lark.alchemy.applink.IAppLinkApi
import com.ss.android.lark.core.spi.SpiManager

/**
 * 登录页。
 */
class LoginActivity :
    BaseBindingActivity<AlchemySampleActivityLoginBinding>(AlchemySampleActivityLoginBinding::inflate) {

    companion object {
        private const val TAG = "LoginActivity"
        private const val EXTRA_URL = "extra_url"

        fun launch(context: Context, url: String?) {
            val intent = Intent(context, LoginActivity::class.java)
            intent.putExtra(EXTRA_URL, url)
            context.startActivity(intent)
        }
    }

    private lateinit var loginViewModel: LoginViewModel

    private fun navToFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction().replace(binding.container.id, fragment).commit()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        loginViewModel = ViewModelProvider(this).get(LoginViewModel::class.java)
        loginViewModel.landUrlData.observe(this, ::landUrl)

        val intent = intent
        val url = intent.getStringExtra(EXTRA_URL)
        if (url == null) {
            navToFragment(NoUrlFragment())
        } else {
            navToFragment(LoginFragment.newInstance(url))
        }
    }

    private fun landUrl(url: String) {
        Log.i(TAG, "landUrl: $url")
        val passportApi = SpiManager.getInstance().getSpi()?.loadClass(IAppLinkApi::class.java)
        if (passportApi == null) {
            Toast.makeText(this, "passport api not available", Toast.LENGTH_SHORT).show()
            return
        }

        passportApi.openAppLink(this, url)
    }
}