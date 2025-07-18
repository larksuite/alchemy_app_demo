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
  IAlchemyApp,
  IAlchemyGlobalKVStorage,
  IAlchemyPassport,
  IAlchemyStatistics,
  IAlchemyUserConfig,
  IAlchemyUserKVStorage,
  IAlchemyNativeRouterManager,
  IAlchemyNativeAppManager,
  IAlchemyWebView,
  IAlchemyLifeCycle,
  IAlchemyNativeAppExtension,
  IAlchemyCustomApiPlugin,
  ITabPageConfig,
  IAlchemyNativeLauncher,
  IAlchemyWebContainer,
} from 'alchemyruntime';
import { IAlchemyLogger } from 'alchemyruntime';
import { AlchemyCustomApiPlugin } from '../../alchemy_custom_api_impl/AlchemyCustomApiPlugin';
import { TestKATabPageConfig } from '../../alchemy_ka_tab_api_impl/TestKATabPageConfig';
import { TestV2KATabPageConfig } from '../../alchemy_ka_tab_api_impl/TestV2KATabPageConfig';
import { AlchemyLifeCycleImpl } from '../../alchemy_lifecycle_api_impl/AlchemyLifeCycleImpl';
import { AlchemySecondLifeCycleImpl } from '../../alchemy_lifecycle_api_impl/AlchemySecondLifeCycleImpl';
import {
  AlchemyNativeAppExtensionImpl
} from '../../alchemy_nativeapp_extension_api_impl/AlchemyNativeAppExtensionImpl';
import { TestAlchemyLauncher0 } from '../../alchemy_nativelauncher_api_impl/TestAlchemyLauncher0';
import { TestAlchemyLauncher1 } from '../../alchemy_nativelauncher_api_impl/TestAlchemyLauncher1';
import { TestAlchemyLauncher2 } from '../../alchemy_nativelauncher_api_impl/TestAlchemyLauncher2';
import { TestAlchemyWebContainer0 } from '../../alchemy_webcontainer_api_impl/TestAlchemyWebContainer0';
import { TestAlchemyWebContainer1 } from '../../alchemy_webcontainer_api_impl/TestAlchemyWebContainer1';

/**
 * 持有所有飞书能力和协议接口
 */
export class AlchemyInterfaceHolder {
  // 全局空间，能力组件
  private alchemyLogger?: IAlchemyLogger;
  private alchemyPassport?: IAlchemyPassport;
  private alchemyGlobalKVStorage?: IAlchemyGlobalKVStorage;
  private alchemyApp?: IAlchemyApp;
  private alchemyNativeRouterManager?: IAlchemyNativeRouterManager;
  private globalNativeAppManager?: IAlchemyNativeAppManager;
  // 全局空间，协议组件
  private alchemyLifeCycle = new AlchemyLifeCycleImpl();
  private alchemySecondLifeCycle = new AlchemySecondLifeCycleImpl();
  private alchemyNativeAppExtension = new AlchemyNativeAppExtensionImpl();

  // 用户空间，能力组件
  private alchemyUserConfig?: IAlchemyUserConfig;
  private alchemyUserKVStorage?: IAlchemyUserKVStorage;
  private alchemyStatistics?: IAlchemyStatistics;
  private nativeAppManager?: IAlchemyNativeAppManager;
  private alchemyWebView?: IAlchemyWebView;
  // 用户空间，协议组件
  private tabPageConfigList = [new TestKATabPageConfig(), new TestV2KATabPageConfig()];
  private testAlchemyLauncher0 = new TestAlchemyLauncher0();
  private testAlchemyLauncher1 = new TestAlchemyLauncher1();
  private testAlchemyLauncher2 = new TestAlchemyLauncher2();
  private testAlchemyWebContainer0 = new TestAlchemyWebContainer0();
  private testAlchemyWebContainer1 = new TestAlchemyWebContainer1();
  private alchemyCustomApi = new AlchemyCustomApiPlugin();

  public getAlchemyLifeCycle(): IAlchemyLifeCycle {
    return this.alchemyLifeCycle;
  }

  public getSecondAlchemyLifeCycle(): IAlchemyLifeCycle {
    return this.alchemySecondLifeCycle;
  }

  public getAlchemyNativeAppExtension(): IAlchemyNativeAppExtension {
    return this.alchemyNativeAppExtension;
  }

  public getAlchemyCustomApiPlugin(): IAlchemyCustomApiPlugin {
    return this.alchemyCustomApi;
  }

  public getTabPageConfigList(): ITabPageConfig[] | undefined {
    return this.tabPageConfigList
  }

  public getTestAlchemyLauncher0(): IAlchemyNativeLauncher {
    return this.testAlchemyLauncher0;
  }

  public getTestAlchemyLauncher1(): IAlchemyNativeLauncher {
    return this.testAlchemyLauncher1;
  }

  public getTestAlchemyLauncher2(): IAlchemyNativeLauncher {
    return this.testAlchemyLauncher2;
  }

  public getTestAlchemyWebContainer0(): IAlchemyWebContainer {
    return this.testAlchemyWebContainer0
  }

  public getTestAlchemyWebContainer1(): IAlchemyWebContainer {
    return this.testAlchemyWebContainer1
  }

  public setAlchemyUserConfig(alchemyUserConfig: IAlchemyUserConfig | undefined) {
    if (alchemyUserConfig) {
      this.alchemyUserConfig = alchemyUserConfig;
    }
  }

  public getAlchemyUserConfig(): IAlchemyUserConfig | undefined {
    return this.alchemyUserConfig;
  }

  public setAlchemyLogger(alchemyLogger: IAlchemyLogger | undefined) {
    if (alchemyLogger) {
      this.alchemyLogger = alchemyLogger;
    }
  }

  public getAlchemyLogger(): IAlchemyLogger | undefined {
    return this.alchemyLogger;
  }

  public setAlchemyGlobalKVStorage(alchemyGlobalKVStorage: IAlchemyGlobalKVStorage | undefined) {
    if (alchemyGlobalKVStorage) {
      this.alchemyGlobalKVStorage = alchemyGlobalKVStorage;
    }
  }

  public getAlchemyGlobalKVStorage(): IAlchemyGlobalKVStorage | undefined {
    return this.alchemyGlobalKVStorage
  }

  public setAlchemyUserKVStorage(alchemyUserKVStorage: IAlchemyUserKVStorage | undefined) {
    if (alchemyUserKVStorage) {
      this.alchemyUserKVStorage = alchemyUserKVStorage;
    }
  }

  public getAlchemyUserKVStorage(): IAlchemyUserKVStorage | undefined {
    return this.alchemyUserKVStorage
  }

  public setAlchemyStatistics(alchemyStatistics: IAlchemyStatistics | undefined) {
    if (alchemyStatistics) {
      this.alchemyStatistics = alchemyStatistics;
    }
  }

  public getAlchemyStatistics(): IAlchemyStatistics | undefined {
    return this.alchemyStatistics
  }

  public setAlchemyPassport(alchemyPassport: IAlchemyPassport | undefined) {
    if (alchemyPassport) {
      this.alchemyPassport = alchemyPassport;
    }
  }

  public getAlchemyPassport(): IAlchemyPassport | undefined {
    return this.alchemyPassport;
  }

  public setAlchemyApp(alchemyApp:  IAlchemyApp | undefined) {
    this.alchemyApp = alchemyApp;
  }

  public getAlchemyApp(): IAlchemyApp | undefined {
    return this.alchemyApp;
  }

  public setAlchemyNativeRouterManager(alchemyNativeRouterManager: IAlchemyNativeRouterManager | undefined) {
    if (alchemyNativeRouterManager) {
      this.alchemyNativeRouterManager = alchemyNativeRouterManager;
    }
  }

  public getAlchemyNativeRouterManager(): IAlchemyNativeRouterManager | undefined {
    return this.alchemyNativeRouterManager;
  }

  public setGlobalNativeAppManager(globalNativeAppManager: IAlchemyNativeAppManager | undefined) {
    if (globalNativeAppManager) {
      this.globalNativeAppManager = globalNativeAppManager;
    }
  }

  public getGlobalNativeAppManager(): IAlchemyNativeAppManager | undefined {
    return this.globalNativeAppManager;
  }

  public setNativeAppManager(nativeAppManager: IAlchemyNativeAppManager | undefined) {
    if (nativeAppManager) {
      this.nativeAppManager = nativeAppManager;
    }
  }

  public getNativeAppManager(): IAlchemyNativeAppManager | undefined {
    return this.nativeAppManager;
  }
  public setAlchemyWebView(alchemyWebView: IAlchemyWebView | undefined) {
    if (alchemyWebView) {
      this.alchemyWebView = alchemyWebView;
    }
  }

  public getAlchemyWebView(): IAlchemyWebView | undefined {
    return this.alchemyWebView;
  }
}