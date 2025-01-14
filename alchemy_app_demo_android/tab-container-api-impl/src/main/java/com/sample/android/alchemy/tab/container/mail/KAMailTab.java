package com.sample.android.alchemy.tab.container.mail;

import androidx.fragment.app.Fragment;

import com.sample.android.alchemy.tab.container.mail.lark.KATabFragment;
import com.sample.android.alchemy.tab.container.mail.lark.KATabTitleConfig;
import com.sample.android.alchemy.tab.container.mail.lark.KATabViewConfig;
import com.ss.android.lark.tab.ITabPageConfig;
import com.ss.android.lark.tab.TabPageConfig;

@TabPageConfig
public class KAMailTab implements ITabPageConfig {

    @Override
    public String getAppId() {
        return "YOUR_APP_ID";
    }

    @Override
    public ITabViewConfig getTabViewConfig() {
        return new KATabViewConfig();
    }

    @Override
    public boolean interceptBackPress() {
        return false;
    }

    @Override
    public Fragment getTabContent() {
        return new KATabFragment();
    }

    @Override
    public ITabTitleConfig getTabTitleConfig() {
        return new KATabTitleConfig();
    }
}
