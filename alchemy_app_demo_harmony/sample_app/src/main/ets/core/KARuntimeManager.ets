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
  IAlchemyLifeCycle,
  IAlchemyPassport,
  IAlchemyStatistics,
  IAlchemyUserConfig,
  IAlchemyUserKVStorage,
  IAlchemyNativeAppExtension,
  TrimisContainerWrapperInterface,
  ITabPageConfig,
  IAlchemyWebContainer,
  IAlchemyCustomApiPlugin,
  IAlchemyNativeRouterManager,
  IAlchemyNativeAppManager,
  IAlchemyWebView,
  IAlchemyNativeLauncher,
} from 'alchemyruntime';
import { IAlchemyLogger } from 'alchemyruntime';
import { AlchemyInterfaceHolder } from './holder/AlchemyInterfaceHolder';
import { GlobalComponentHandler } from './handler/GlobalComponentHandler';
import { UserComponentHandler } from './handler/UserComponentHandler';

/**
 * 负责AlchemyRuntime的初始化，以及对客户提供能力
 */
export class KARuntimeManager {
  private static instance: KARuntimeManager;

  private interfaceHolder: AlchemyInterfaceHolder;
  private globalComponentHandler: GlobalComponentHandler;
  private userComponentHandler: UserComponentHandler;

  private constructor() {
    this.interfaceHolder = new AlchemyInterfaceHolder();
    this.globalComponentHandler = new GlobalComponentHandler(this.interfaceHolder);
    this.userComponentHandler = new UserComponentHandler(this.interfaceHolder);
  }

  public static getInstance(): KARuntimeManager {
    if (!KARuntimeManager.instance) {
      KARuntimeManager.instance = new KARuntimeManager();
    }
    return KARuntimeManager.instance;
  }

  /**
   * 加载全局模块
   */
  loadGlobalModule(runtime: TrimisContainerWrapperInterface): void {
    // 初始化全局能力组件
    this.globalComponentHandler.initAbilityComponents(runtime);

    // 注册全局协议组件
    this.globalComponentHandler.registerProtocolComponents(runtime);

    // 演示全局功能
    this.globalComponentHandler.testComponents();

    this.interfaceHolder.getAlchemyLogger()?.info("KARuntimeManager", "loadGlobalModule completed");
  }

  /**
   * 加载用户模块
   */
  loadUserModule(runtime: TrimisContainerWrapperInterface): void {
    // 初始化用户能力组件
    this.userComponentHandler.initAbilityComponents(runtime);

    // 注册用户协议组件
    this.userComponentHandler.registerProtocolComponents(runtime);

    // 演示用户功能
    this.userComponentHandler.testComponents();

    this.interfaceHolder.getAlchemyLogger()?.info("KARuntimeManager", "loadUserModule completed");
  }

  public getAlchemyLifeCycle(): IAlchemyLifeCycle {
    return this.interfaceHolder.getAlchemyLifeCycle();
  }

  public getSecondAlchemyLifeCycle(): IAlchemyLifeCycle {
    return this.interfaceHolder.getSecondAlchemyLifeCycle();
  }

  public getAlchemyNativeAppExtension(): IAlchemyNativeAppExtension {
    return this.interfaceHolder.getAlchemyNativeAppExtension();
  }

  public getAlchemyCustomApiPlugin(): IAlchemyCustomApiPlugin {
    return this.interfaceHolder.getAlchemyCustomApiPlugin();
  }

  public getTabPageConfigList(): ITabPageConfig[] | undefined {
    return this.interfaceHolder.getTabPageConfigList();
  }

  public getTestAlchemyLauncher0(): IAlchemyNativeLauncher {
    return this.interfaceHolder.getTestAlchemyLauncher0();
  }

  public getTestAlchemyLauncher1(): IAlchemyNativeLauncher {
    return this.interfaceHolder.getTestAlchemyLauncher1();
  }

  public getTestAlchemyLauncher2(): IAlchemyNativeLauncher {
    return this.interfaceHolder.getTestAlchemyLauncher2();
  }

  public getTestAlchemyWebContainer0(): IAlchemyWebContainer {
    return this.interfaceHolder.getTestAlchemyWebContainer0();
  }

  public getTestAlchemyWebContainer1(): IAlchemyWebContainer {
    return this.interfaceHolder.getTestAlchemyWebContainer1()
  }

  public getAlchemyUserConfig(): IAlchemyUserConfig | undefined {
    return this.interfaceHolder.getAlchemyUserConfig();
  }

  public getAlchemyLogger(): IAlchemyLogger | undefined {
    return this.interfaceHolder.getAlchemyLogger();
  }

  public getAlchemyGlobalKVStorage(): IAlchemyGlobalKVStorage | undefined {
    return this.interfaceHolder.getAlchemyGlobalKVStorage();
  }

  public getAlchemyUserKVStorage(): IAlchemyUserKVStorage | undefined {
    return this.interfaceHolder.getAlchemyUserKVStorage();
  }

  public getAlchemyStatistics(): IAlchemyStatistics | undefined {
    return this.interfaceHolder.getAlchemyStatistics();
  }

  public getAlchemyPassport(): IAlchemyPassport | undefined {
    return this.interfaceHolder.getAlchemyPassport();
  }

  public getAlchemyApp(): IAlchemyApp | undefined {
    return this.interfaceHolder.getAlchemyApp();
  }

  public getAlchemyNativeRouterManager(): IAlchemyNativeRouterManager | undefined {
    return this.interfaceHolder.getAlchemyNativeRouterManager();
  }

  public getGlobalNativeAppManager(): IAlchemyNativeAppManager | undefined {
    return this.interfaceHolder.getGlobalNativeAppManager();
  }

  public getNativeAppManager(): IAlchemyNativeAppManager | undefined {
    return this.interfaceHolder.getNativeAppManager();
  }

  public getAlchemyWebView(): IAlchemyWebView | undefined {
    return this.interfaceHolder.getAlchemyWebView();
  }
}