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
import android.net.Uri
import android.os.Bundle
import android.text.SpannableString
import android.text.Spanned
import android.text.method.LinkMovementMethod
import android.text.style.ClickableSpan
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.Toast
import androidx.lifecycle.ViewModelProvider
import com.sample.android.alchemy.app.extension.R
import com.sample.android.alchemy.app.extension.databinding.AlchemySampleFragmentLoginBinding
import com.sample.android.alchemy.app.login.network.Network
import com.sample.android.alchemy.app.login.network.login.response.LoginResponse
import com.sample.android.alchemy.app.login.util.KVUtils
import com.sample.android.alchemy.common.ui.base.BaseBindingFragment
import com.sample.android.alchemy.common.ui.utils.NotAvailableToast
import com.sample.android.alchemy.logger.Log
import kotlinx.coroutines.launch

/**
 * 登录页。
 */
class LoginFragment :
    BaseBindingFragment<AlchemySampleFragmentLoginBinding>(AlchemySampleFragmentLoginBinding::inflate) {
    companion object {
        private const val TAG = "LoginFragment"

        private const val BUNDLE_KEY_URL = "url"
        private const val KV_KEY_USER_NAME = "user_name"
        private const val KV_KEY_PASSWORD = "password"

        @JvmStatic
        fun newInstance(url: String): LoginFragment{
            val args = Bundle()
            args.putString(BUNDLE_KEY_URL, url)

            val fragment = LoginFragment()
            fragment.arguments = args
            return fragment
        }
    }

    private lateinit var loginViewModel: LoginViewModel
    private var url: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            url = it.getString(BUNDLE_KEY_URL) ?: ""
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        loginViewModel = ViewModelProvider(requireActivity()).get(LoginViewModel::class.java)
        return super.onCreateView(inflater, container, savedInstanceState)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        loginViewModel.loginResult.observe(this, ::onLoginResult)

        binding.login.let {
            it.setOnClickListener { login() }
        }
        binding.container.let {
            it.setOnClickListener {
                hideImm()
            }
        }

        val username = KVUtils.getString(KV_KEY_USER_NAME, "")
        if (username.isNotBlank()) {
            binding.username.setText(username)
        }

        val password = KVUtils.getString(KV_KEY_PASSWORD, "")
        if (password.isNotBlank()) {
            binding.password.setText(password)
        }

        initForgotView()
    }

    private fun initForgotView() {
        binding.forgotPassword.let {
            val forgotText =
                resources.getString(R.string.alchemy_sample_Lark_Demo_ForgotPassword_Text) + resources.getString(
                    R.string.alchemy_sample_Lark_Demo_ResetPassword_Button
                )

            val spannableString = SpannableString(forgotText)
            val resetClickSpan = object : ClickableSpan() {
                override fun onClick(widget: View) {
                    NotAvailableToast.show(requireContext())
                }
            }
            spannableString.setSpan(resetClickSpan, 5, 9, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            it.text = spannableString
            it.movementMethod = LinkMovementMethod.getInstance()
        }
    }

    private fun setLoginButtonLoading() {
        binding.login.isEnabled = false
        binding.login.text = getString(R.string.alchemy_sample_Lark_Demo_LogIn_Button_Loading)
    }

    private fun setLoginButtonNotLoading() {
        binding.login.isEnabled = true
        binding.login.text = getString(R.string.alchemy_sample_Lark_Demo_LogIn_Button)
    }

    private fun onLoginResult(response: Network.NetworkResult<LoginResponse>) {
        Log.i(TAG, "login finish $response")

        setLoginButtonNotLoading()

        when (response) {
            is Network.NetworkResult.Failure -> {
                Toast.makeText(
                    requireContext(),
                    R.string.alchemy_sample_Lark_Demo_IncorrectNumberOrPassword_Toast,
                    Toast.LENGTH_SHORT
                ).show()
            }

            is Network.NetworkResult.Success -> {
                try {
                    // 仅供演示kv-api的功能。
                    KVUtils.putString(
                        KV_KEY_USER_NAME,
                        binding.username.text.toString()
                    )
                    KVUtils.putString(
                        KV_KEY_PASSWORD,
                        binding.password.text.toString()
                    )

                    loginViewModel.setLandUrl(response.content.data.stepInfo.landUrl)
                } catch (e: Exception) {
                    Log.e(TAG, "response error", e)
                    Toast.makeText(
                        requireContext(),
                        R.string.alchemy_sample_Lark_Demo_IncorrectNumberOrPassword_Toast,
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }
        }
    }

    private fun login() {
        hideImm()
        mainScope.launch {
            setLoginButtonLoading()

            val uri = Uri.parse(url)
            val state = uri.getQueryParameter("state")

            loginViewModel.login(binding.username.text.toString(), binding.password.text.toString(), state!!)
        }
    }

    private fun hideImm() {
        if (binding.username.hasFocus() || binding.password.hasFocus()) {
            binding.username.clearFocus()
            binding.password.clearFocus()
            val imm =
                requireContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.toggleSoftInput(0, 0)
        }
    }
}