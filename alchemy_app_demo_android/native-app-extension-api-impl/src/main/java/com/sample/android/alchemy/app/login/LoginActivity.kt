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