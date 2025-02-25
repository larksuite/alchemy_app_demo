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

/**
 * 常量。
 */
object Constants {
    /**
     * 插件名称。
     */
    object PluginName {
        /**
         * 地图插件名称。
         */
        const val BD_MAP = "BD_MAP"
    }

    /**
     * Js API 名称。
     */
    object JsApi {
        /**
         * 获取当前位置。
         */
        const val GET_LOCATION = "GET_LOCATION"

        /**
         * 获取附近餐厅信息。
         */
        const val GET_RESTAURANTS = "GET_RESTAURANTS"
    }

    /**
     * Json key。
     */
    object Key {
        /**
         * 地址。
         */
        const val ADDR = "addr"

        /**
         * 经度。
         */
        const val LONGITUDE = "longitude"

        /**
         * 纬度。
         */
        const val LATITUDE = "latitude"

        /**
         * 名称。
         */
        const val NAME = "name"

        /**
         * 类型。
         */
        const val TYPE = "type"

        /**
         * 距离。
         */
        const val DISTANCE = "distance"

        /**
         * 餐厅列表。
         */
        const val RESTAURANTS = "restaurants"

    }
}