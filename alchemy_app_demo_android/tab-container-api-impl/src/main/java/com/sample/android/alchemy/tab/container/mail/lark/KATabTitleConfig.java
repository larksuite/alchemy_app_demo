package com.sample.android.alchemy.tab.container.mail.lark;

import android.content.Context;

import com.ss.android.lark.tab.ITabPageConfig;

import java.util.List;

public class KATabTitleConfig implements ITabPageConfig.ITabTitleConfig {

    @Override
    public boolean isShow() {
        return false;
    }

    @Override
    public List<IFunctionButton> getFunctionButtonList(Context context) {
        return null;
    }

    @Override
    public ITabPageConfig.TabTitleClickListener getClickListener() {
        return null;
    }

}