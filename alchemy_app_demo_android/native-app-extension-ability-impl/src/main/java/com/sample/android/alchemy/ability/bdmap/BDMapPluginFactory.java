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

package com.sample.android.alchemy.ability.bdmap;

import com.ss.android.lark.extension_interfaces.INativeAppPlugin;
import com.ss.android.lark.extension_interfaces.INativeAppPluginFactory;

import java.util.Arrays;
import java.util.List;

/**
 * 这是一个用于创建百度地图插件的工厂类，实现了 INativeAppPluginFactory 接口。
 * 该工厂类负责提供插件的名称、支持的 API 名称，并创建具体的插件实例。
 */
@com.ss.android.lark.extension_interfaces.NativeAppPluginFactory
public class BDMapPluginFactory implements INativeAppPluginFactory {

    /**
     * 获取插件的名称。
     *
     * @return 返回插件的名称。
     */
    @Override
    public String getPluginName() {
        return Constants.PluginName.BD_MAP;
    }

    /**
     * 获取插件支持的 API 名称列表。
     *
     * @return 返回一个包含插件支持的 API 名称的列表，这里包含获取位置和获取附近餐厅信息的 API。
     */
    @Override
    public List<String> getPluginApiNames() {
        return Arrays.asList(Constants.JsApi.GET_LOCATION, Constants.JsApi.GET_RESTAURANTS);
    }

    /**
     * 创建百度地图插件的实例。
     *
     * @return 返回一个新的 BDMapPlugin 实例，用于处理与百度地图相关的功能。
     */
    @Override
    public INativeAppPlugin createPlugin() {
        return new BDMapPlugin();
    }
}
