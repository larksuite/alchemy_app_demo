package com.sample.android.alchemy.app.login

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.sample.android.alchemy.app.login.network.Network
import com.sample.android.alchemy.app.login.network.Network.NetworkResult
import com.sample.android.alchemy.app.login.network.login.response.LoginResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class LoginViewModel : ViewModel() {
    private val _landUrlData: MutableLiveData<String> = MutableLiveData()
    val landUrlData: LiveData<String> = _landUrlData

    fun setLandUrl(landUrl: String) {
        _landUrlData.postValue(landUrl)
    }

    private val _loginResult: MutableLiveData<NetworkResult<LoginResponse>> = MutableLiveData()
    val loginResult: LiveData<NetworkResult<LoginResponse>> = _loginResult

    fun login(username: String, password: String, state: String) {
        viewModelScope.launch(Dispatchers.IO) {
            _loginResult.postValue(
                Network.login(
                    username,
                    password,
                    state
                )
            )
        }
    }
}