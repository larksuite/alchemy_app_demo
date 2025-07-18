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

import { TrimisContainerWrapperInterface } from 'alchemyruntime';
import { AlchemyInterfaceHolder } from '../holder/AlchemyInterfaceHolder';

/**
 * 全局空间容器组件Handler，能力和协议组件的初始化和注册
 */
export class GlobalComponentHandler {
  private interfaceHolder: AlchemyInterfaceHolder;

  constructor(interfaceHolder: AlchemyInterfaceHolder) {
    this.interfaceHolder = interfaceHolder;
  }

  /**
   * 初始化全局能力组件
   */
  initAbilityComponents(runtime: TrimisContainerWrapperInterface): void {
    this.interfaceHolder.setAlchemyLogger(runtime.getAlchemyLogger());
    this.interfaceHolder.setAlchemyPassport(runtime.getGlobalAlchemyPassport());
    this.interfaceHolder.setAlchemyGlobalKVStorage(runtime.getAlchemyGlobalKVStorage());
    this.interfaceHolder.setAlchemyApp(runtime.getAlchemyApp());
    this.interfaceHolder.setAlchemyNativeRouterManager(runtime.getAlchemyNativeRouterManager());
    this.interfaceHolder.setGlobalNativeAppManager(runtime.getGlobalNativeAppManager());
  }

  /**
   * 注册全局协议组件
   */
  registerProtocolComponents(runtime: TrimisContainerWrapperInterface): void {
    runtime.setAlchemyLifeCycle(this.interfaceHolder.getAlchemyLifeCycle());
    runtime.setAlchemyLifeCycle(this.interfaceHolder.getSecondAlchemyLifeCycle());
    runtime.setNativeAppExtension(this.interfaceHolder.getAlchemyNativeAppExtension());
  }

  /**
   * 测试部分全局空间组件功能
   */
  testComponents(): void {
    // test alchemyLogger
    const logger = this.interfaceHolder.getAlchemyLogger();
    logger?.info('GlobalComponentHandler', 'test alchemyLogger');

    // test alchemyGlobalKVStorage
    const alchemyGlobalKVStorage = this.interfaceHolder.getAlchemyGlobalKVStorage();
    alchemyGlobalKVStorage?.put("alchemyGlobal0", "globalKVStorage0")
    logger?.info('GlobalComponentHandler', `test alchemyGlobalKVStorage  r: ${alchemyGlobalKVStorage?.get("alchemyGlobal0", "default")}`);

    // test alchemyApp
    const alchemyApp = this.interfaceHolder.getAlchemyApp()
    logger?.info('GlobalComponentHandler', `test alchemyApp  r: ${alchemyApp}`);
  }
}