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

package com.sample.android.alchemy.ability.bdmap

import android.content.Context
import android.util.Log
import com.baidu.location.BDAbstractLocationListener
import com.baidu.location.BDLocation
import com.baidu.location.LocationClient
import com.baidu.location.LocationClientOption
import com.baidu.mapapi.CoordType
import com.baidu.mapapi.SDKInitializer
import com.baidu.mapapi.common.BaiduMapSDKException
import com.baidu.mapapi.model.LatLng
import com.baidu.mapapi.search.core.SearchResult
import com.baidu.mapapi.search.poi.*
import com.baidu.mapapi.utils.DistanceUtil
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

/**
 * BDMapService 类用于与百度地图服务进行交互，提供获取当前位置和附近餐厅信息的功能。
 *
 * @param context 应用的上下文对象，用于初始化百度地图相关服务。
 */
class BDMapService(context: Context) {
    companion object {
        const val TAG = "BDMapService"
    }

    private var mLocationClient: LocationClient? = null
    private var mPoiSearch: PoiSearch? = null
    private val mRestaurants = mutableListOf<RestaurantBean>()
    private var mPoiDetailSearchCount = 0
    private var mCurrentLatLng: LatLng? = null
    private var mCurrentLocationCallback: ((JSONObject?) -> Unit)? = null
    private var mNearbyRestaurantsCallback: ((JSONObject?) -> Unit)? = null

    init {
        mLocationClient = try {
            LocationClient.setAgreePrivacy(true)
            LocationClient(context.applicationContext).apply {
                locOption = defaultLocClientOption
                registerLocationListener(LocListener())
            }
        } catch (e: Exception) {
            Log.i(TAG, "init mLocationClient failed, err: " + e.message)
            null
        }

        mPoiSearch = try {
            SDKInitializer.setAgreePrivacy(context.applicationContext, true)
            SDKInitializer.initialize(context.applicationContext)
            SDKInitializer.setCoordType(CoordType.BD09LL)
            PoiSearch.newInstance().apply {
                setOnGetPoiSearchResultListener(PoiListener())
            }
        } catch (e: BaiduMapSDKException) {
            Log.i(TAG, "init mPoiSearch failed, err: " + e.message)
            null
        }
    }

    private val defaultLocClientOption: LocationClientOption
        get() = LocationClientOption().apply {
            coorType = "bd09ll"
            scanSpan = 5000
            setIsNeedAddress(true)
            setIsNeedLocationDescribe(true)
            setNeedDeviceDirect(false)
            isLocationNotify = false
            isIgnoreKillProcess = true
            setIsNeedLocationDescribe(true)
            setIsNeedLocationPoiList(true)
            SetIgnoreCacheException(false)
            locationMode = LocationClientOption.LocationMode.Hight_Accuracy
            isNeedAltitude = false
            setFirstLocType(LocationClientOption.FirstLocType.SPEED_IN_FIRST_LOC)
        }

    fun getCurrentLocation(callback: (JSONObject?) -> Unit) {
        mLocationClient?.start()
        mCurrentLocationCallback = callback
    }

    fun getNearbyRestaurants(callback: (JSONObject?) -> Unit) {
        mLocationClient?.start()
        mNearbyRestaurantsCallback = callback
    }

    private fun searchNearbyRestaurants(latLng: LatLng?) {
        val option = PoiNearbySearchOption().apply {
            location(latLng)
            keyword("美食")
            radius(1000)
            pageNum(0)
        }
        mPoiSearch?.searchNearby(option)
    }

    private inner class LocListener : BDAbstractLocationListener() {
        override fun onReceiveLocation(location: BDLocation?) {
            location.let {
                if (location?.locType == BDLocation.TypeGpsLocation || location?.locType == BDLocation.TypeNetWorkLocation) {
                    try {
                        val currentLocation = JSONObject().apply {
                            put(Constants.Key.addr, location.addrStr)
                            put(Constants.Key.longitude, location.longitude)
                            put(Constants.Key.latitude, location.latitude)
                        }
                        mCurrentLatLng = LatLng(location.latitude, location.longitude)
                        mCurrentLocationCallback?.invoke(currentLocation)
                        searchNearbyRestaurants(mCurrentLatLng)
                        mLocationClient?.stop()
                    } catch (e: JSONException) {
                        e.printStackTrace()
                    }
                }
            }
        }
    }

    private inner class PoiListener : OnGetPoiSearchResultListener {
        override fun onGetPoiResult(poiResult: PoiResult?) {
            if (poiResult?.error == SearchResult.ERRORNO.NO_ERROR) {
                mRestaurants.clear()
                mPoiDetailSearchCount = 0
                poiResult.allPoi?.forEach { poiInfo ->
                    val option = PoiDetailSearchOption().apply {
                        poiUid(poiInfo.uid)
                    }
                    mPoiSearch?.searchPoiDetail(option)
                    mPoiDetailSearchCount++
                }
            }
        }

        override fun onGetPoiDetailResult(poiDetailResult: PoiDetailResult?) {
            if (poiDetailResult?.error == SearchResult.ERRORNO.NO_ERROR) {
                mCurrentLatLng?.let { currentLatLng ->
                    val distance =
                        DistanceUtil.getDistance(currentLatLng, poiDetailResult.location).toInt()
                    val restaurant = RestaurantBean(
                        name = poiDetailResult.name ?: "",
                        type = poiDetailResult.tag?.split(";")?.getOrNull(1) ?: "",
                        distance = distance
                    )
                    mRestaurants.add(restaurant)
                }
            }
            mPoiDetailSearchCount--
            if (mPoiDetailSearchCount == 0) {
                val jsonArray = JSONArray().apply {
                    mRestaurants.forEach { restaurant ->
                        put(JSONObject().apply {
                            put(Constants.Key.name, restaurant.name)
                            put(Constants.Key.type, restaurant.type)
                            put(Constants.Key.distance, restaurant.distance)
                        })
                    }
                }
                val storeJson = JSONObject().apply {
                    put(Constants.Key.restaurants, jsonArray)
                }
                mNearbyRestaurantsCallback?.invoke(storeJson)
            }
        }

        override fun onGetPoiDetailResult(poiDetailSearchResult: PoiDetailSearchResult?) {}
        override fun onGetPoiIndoorResult(poiIndoorResult: PoiIndoorResult?) {}
    }
}