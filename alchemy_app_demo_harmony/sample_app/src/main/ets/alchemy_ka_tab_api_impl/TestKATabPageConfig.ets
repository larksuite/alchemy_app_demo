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

import {
  ITabPageConfig,
  ITabTitleConfig,
  ITabViewConfig,
  TabTitleClickListener,
  TabViewClickListener
} from "alchemyruntime";
import { KARuntimeManager } from "../core/KARuntimeManager";

@Builder
function testTabBuilder() {
  Text("自定义KA Tab")
}

const globaleKATab = wrapBuilder(testTabBuilder)

@Builder
function testMenuBuilder(appKey: string) {
  Text("自定义菜单")
}

const customMenu = wrapBuilder(testMenuBuilder)

export class TestKATabPageConfig implements ITabPageConfig {
  /**
   * 获取原生应用ID标识
   * https://open.larkoffice.com/document/native-integration/open-capability/protocol-components/native-integrated-application/nati
   * @returns 原生应用ID
   */
  getAppId(): string {
    return "1"
  }

  getTabContent(): WrappedBuilder<[]> {
    return globaleKATab
  }

  getTabTitleConfig(): ITabTitleConfig {
    return new KATabTitleConfig()
  }

  getTabViewConfig(): ITabViewConfig {
    return new KATabViewConfig()
  }
}

export class KATabTitleConfig implements ITabTitleConfig {
  getClickListener(): TabTitleClickListener {
    return new KATabTitleClickListener()
  }

  getFunctionButtonList(): WrappedBuilder<[string]>[] {
    return [customMenu]
  }

  isShow(): boolean {
    return false
  }
}

export class KATabTitleClickListener implements TabTitleClickListener {
  onClick(uniqueId: number): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KATabTitleClickListener', 'onClick');
  }
}

export class KATabViewConfig implements ITabViewConfig {
  getClickListener(): TabViewClickListener {
    return new KATabViewClickListener();
  }

  onShow(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KATabViewConfig', 'onShow');
  }

  onHide(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KATabViewConfig', 'onHide');
  }

  onHandleBack(): boolean {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KATabViewConfig', 'onHandleBack');
    return false
  }
}

export class KATabViewClickListener implements TabViewClickListener {
  onSingleClick(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KATabViewClickListener', 'onSingleClick');
  }

  onDoubleClick(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KATabViewClickListener', 'onDoubleClick');
  }
}