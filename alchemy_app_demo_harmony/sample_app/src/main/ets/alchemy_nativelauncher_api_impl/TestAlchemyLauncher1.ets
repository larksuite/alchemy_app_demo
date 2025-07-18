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

import { IAlchemyNativeLauncher, NativeRouterScene, NativeRouterConfig } from "alchemyruntime";
import { invokeOpenApiPageBuilder, RouterName_InvokeOpenApiPage } from "./page/InvokeOpenApiPage";
import { invokeOpenApiPage2Builder, RouterName_InvokeOpenApiPage2 } from "./page/InvokeOpenApiPage2";
import { nativeRouterTestPageBuilder, RouterName_NativeRouterTestPage } from "./page/NativeRouterTestPage";
import { openApiTestPageBuilder, RouterName_OpenApiTestPage } from "./page/OpenApiTestPage";
import { KARuntimeManager } from "../core/KARuntimeManager";
import { webViewTestPageBuilder, RouterName_WebViewTestPage } from "./page/WebViewTestPage";

export class TestAlchemyLauncher1 implements IAlchemyNativeLauncher {
  getNativeAppId(): string {
    return 'YOUR_APP_ID'
  }

  launchNativeApp(componentUniqueId: number, linkUrl: string): void {
    const nativeRouterManger = KARuntimeManager.getInstance().getAlchemyNativeRouterManager()
    if (nativeRouterManger) {
      const nativeRouter = nativeRouterManger.registerNativeRouter('RouterUUId_NativeLauncher', NativeRouterScene.NATIVE_LAUNCHER)
      nativeRouter?.registerNativePage(this.getNativeRouterConfigs())
      const params: Map<string, string> = new Map()
      params.set('appId', this.getNativeAppId())
      nativeRouter?.nativePageGo(componentUniqueId, RouterName_OpenApiTestPage, params)
    }
  }

  private getNativeRouterConfigs(): NativeRouterConfig[] {
    const configArray: NativeRouterConfig[] = []
    const routerConfig1: NativeRouterConfig = {
      routeName: RouterName_InvokeOpenApiPage,
      builder: wrapBuilder(invokeOpenApiPageBuilder)
    }
    configArray.push(routerConfig1)
    const routerConfig2: NativeRouterConfig = {
      routeName: RouterName_InvokeOpenApiPage2,
      builder: wrapBuilder(invokeOpenApiPage2Builder)
    }
    configArray.push(routerConfig2)
    const routerConfig3: NativeRouterConfig = {
      routeName: RouterName_NativeRouterTestPage,
      builder: wrapBuilder(nativeRouterTestPageBuilder)
    }
    configArray.push(routerConfig3)
    const routerConfig4: NativeRouterConfig = {
      routeName: RouterName_OpenApiTestPage,
      builder: wrapBuilder(openApiTestPageBuilder)
    }
    configArray.push(routerConfig4)
    const routerConfig5: NativeRouterConfig = {
      routeName: RouterName_WebViewTestPage,
      builder: wrapBuilder(webViewTestPageBuilder)
    }
    configArray.push(routerConfig5)
    return configArray
  }
}