package com.sample.android.alchemy.ability.bdmap;

import com.ss.android.lark.extension_interfaces.INativeAppPlugin;
import com.ss.android.lark.extension_interfaces.INativeAppPluginFactory;

import java.util.Arrays;
import java.util.List;

@com.ss.android.lark.extension_interfaces.NativeAppPluginFactory
public class BDMapPluginFactory implements INativeAppPluginFactory {

    @Override
    public String getPluginName() {
        return Constants.PluginName.BD_MAP;
    }

    @Override
    public List<String> getPluginApiNames() {
        return Arrays.asList(Constants.JsApi.GET_LOCATION, Constants.JsApi.GET_RESTAURANTS);
    }

    @Override
    public INativeAppPlugin createPlugin() {
        return new BDMapPlugin();
    }
}
