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

import { ConfigParams, TrimisContainerWrapperInterface } from 'alchemyruntime';
import { AlchemyInterfaceHolder } from '../holder/AlchemyInterfaceHolder';

/**
 * 用户容器空间组件Handler，能力和协议组件的初始化和注册
 */
export class UserComponentHandler {
  private interfaceHolder: AlchemyInterfaceHolder;

  constructor(interfaceHolder: AlchemyInterfaceHolder) {
    this.interfaceHolder = interfaceHolder;
  }

  /**
   * 初始化用户能力组件
   */
  initAbilityComponents(runtime: TrimisContainerWrapperInterface): void {
    this.interfaceHolder.setAlchemyUserConfig(runtime.getAlchemyUserConfig());
    this.interfaceHolder.setAlchemyUserKVStorage(runtime.getAlchemyUserKVStorage());
    this.interfaceHolder.setAlchemyStatistics(runtime.getAlchemyStatistics());
    this.interfaceHolder.setNativeAppManager(runtime.getNativeAppManager());
    this.interfaceHolder.setAlchemyWebView(runtime.getAlchemyWebView());
  }

  /**
   * 注册用户协议组件
   */
  registerProtocolComponents(runtime: TrimisContainerWrapperInterface): void {
    runtime.setTabPageConfig(this.interfaceHolder.getTabPageConfigList());
    runtime.setAlchemyNativeLauncher(this.interfaceHolder.getTestAlchemyLauncher0());
    runtime.setAlchemyNativeLauncher(this.interfaceHolder.getTestAlchemyLauncher1());
    runtime.setAlchemyNativeLauncher(this.interfaceHolder.getTestAlchemyLauncher2());
    runtime.setAlchemyWebContainer(this.interfaceHolder.getTestAlchemyWebContainer0());
    runtime.setAlchemyWebContainer(this.interfaceHolder.getTestAlchemyWebContainer1());
    runtime.setAlchemyCustomApiPlugin(this.interfaceHolder.getAlchemyCustomApiPlugin());
  }

  /**
   * 测试部分用户空间组件功能
   */
  testComponents(): void {
    const logger = this.interfaceHolder.getAlchemyLogger();

    // test alchemyUserKVStorage
    const alchemyUserKVStorage = this.interfaceHolder.getAlchemyUserKVStorage();
    alchemyUserKVStorage?.put("alchemyUser0", "userKVStorage0")
    logger?.info('GlobalComponentHandler', `test alchemyUserKVStorage  r: ${alchemyUserKVStorage?.get("alchemyUser0", "default")}`);

    //  test alchemyStatistics
    const alchemyStatistics = this.interfaceHolder.getAlchemyStatistics()
    const configParams: ConfigParams = {
      "user_unique_id": "123.0",
    };
    alchemyStatistics?.initConfig("418165", "klink.volceapplog.com", "toblog.volceapplog.com", configParams)
    alchemyStatistics?.sendEvent("zzzz", "111")
    alchemyStatistics?.sendEventJson("hhhh", { "qqqqq": "q1", "wwwww": "w1" })
    logger?.info('GlobalComponentHandler', "loadUserModule test alchemyStatistics.sendEventJson");
  }
}