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
  AlchemyWebContainerCallback,
  ErrorPageButtonConfig,
  ErrorPageConfig,
  IAlchemyWebContainer,
  TabParams
} from "alchemyruntime";

export class TestAlchemyWebContainer0 implements IAlchemyWebContainer {
  onOpen(url: string, componentUniqueId: number, callback: AlchemyWebContainerCallback): void {
    console.info('TestAlchemyWebContainer0 onOpen: ' + url)
    setTimeout(() => {
      if (url.includes('baidu')) {
        callback.onFail(-1)
      } else if (url.includes('huawei')) {

      } else {
        callback.onSuccess()
      }
    }, 500)
  }

  onClose(url: string): void {
    console.info('TestAlchemyWebContainer0 onClose: ' + url)
  }

  getErrorPageConfig(): ErrorPageConfig {
    console.info('TestAlchemyWebContainer0 getErrorPageConfig: ')
    const pageConfig = new ErrorPageConfig()
    pageConfig.customTitle = 'AlchemyWebContainer0_customTitle'
    pageConfig.customContentTitle = 'AlchemyWebContainer0_customContentTitle'
    pageConfig.customContent = 'AlchemyWebContainer0_customContent'
    const vpnBtnConfig = new ErrorPageButtonConfig()
    vpnBtnConfig.hideBtn = false
    vpnBtnConfig.customText = 'vpnBtnConfig_customText'
    vpnBtnConfig.customEvent = 'vpnBtnConfig_customEvent'
    vpnBtnConfig.customExtraString = 'vpnBtnConfig_customExtraString'
    pageConfig.customVPNBtnConfig = vpnBtnConfig
    const refreshBtnConfig = new ErrorPageButtonConfig()
    refreshBtnConfig.hideBtn = false
    refreshBtnConfig.customText = 'refreshBtnConfig_customText'
    refreshBtnConfig.customEvent = 'refreshBtnConfig_customEvent'
    refreshBtnConfig.customExtraString = 'refreshBtnConfig_customExtraString'
    pageConfig.customVPNBtnConfig = refreshBtnConfig
    return new ErrorPageConfig()
  }

  onTabVisibilityChanged(selected: boolean, tabParams: TabParams): void {
    console.info('TestAlchemyWebContainer0 onTabVisibilityChanged: ')
  }
}