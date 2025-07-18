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
  Text("自定义KA Tab V2")
}

const globaleKATab = wrapBuilder(testTabBuilder)

export class TestV2KATabPageConfig implements ITabPageConfig {
  /**
   * 获取原生应用ID标识
   * https://open.larkoffice.com/document/native-integration/open-capability/protocol-components/native-integrated-application/nati
   * @returns 原生应用ID
   */
  getAppId(): string {
    return "2"
  }

  getTabContent(): WrappedBuilder<[]> {
    return globaleKATab
  }

  getTabTitleConfig(): ITabTitleConfig {
    return new KAV2TabTitleConfig()
  }

  getTabViewConfig(): ITabViewConfig {
    return new KAV2TabViewConfig()
  }
}

export class KAV2TabTitleConfig implements ITabTitleConfig {
  getClickListener(): TabTitleClickListener {
    return new KAV2TabTitleClickListener()
  }

  getFunctionButtonList(): WrappedBuilder<[string]>[] {
    return []
  }

  isShow(): boolean {
    return true
  }
}

class KAV2TabTitleClickListener implements TabTitleClickListener {
  onClick(uniqueId: number): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KAV2TabTitleClickListener', 'onClick');
  }
}

class KAV2TabViewConfig implements ITabViewConfig {
  getClickListener(): TabViewClickListener {
    return new KAV2TabViewClickListener();
  }

  onShow(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KAV2TabViewConfig', 'onShow');
  }

  onHide(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KAV2TabViewConfig', 'onHide');
  }

  onHandleBack(): boolean {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KAV2TabViewConfig', 'onHandleBack');
    return false
  }
}

class KAV2TabViewClickListener implements TabViewClickListener {
  onSingleClick(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KAV2TabViewClickListener', 'onSingleClick');
  }

  onDoubleClick(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('KAV2TabViewClickListener', 'onDoubleClick');
  }
}