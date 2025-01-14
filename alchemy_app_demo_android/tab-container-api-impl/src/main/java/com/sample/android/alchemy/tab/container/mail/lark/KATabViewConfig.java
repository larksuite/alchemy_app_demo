package com.sample.android.alchemy.tab.container.mail.lark;

import com.ss.android.lark.tab.ITabPageConfig;

public class KATabViewConfig implements ITabPageConfig.ITabViewConfig {

    @Override
    public ITabPageConfig.TabViewClickListener getClickListener() {
        return new ITabPageConfig.TabViewClickListener() {
            @Override
            public void onSingleClick() {
            }

            @Override
            public void onDoubleClick() {
            }
        };
    }

}
