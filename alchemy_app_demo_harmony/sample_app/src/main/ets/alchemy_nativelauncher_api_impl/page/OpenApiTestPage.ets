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

import { NativeRouterScene, Unknown } from "alchemyruntime"
import { KARuntimeManager } from "../../core/KARuntimeManager"
import { RouterName_InvokeOpenApiPage } from "./InvokeOpenApiPage"
import { RouterName_NativeRouterTestPage } from "./NativeRouterTestPage"
import { RouterName_WebViewTestPage } from "./WebViewTestPage"

export const RouterName_OpenApiTestPage = 'OpenApiTestPage'

@Builder
export function openApiTestPageBuilder(params: Map<string, Unknown>) {
  OpenApiTestPage({ appIdStr: params.get('appId') as string })
}

@Entry
@Component
export struct OpenApiTestPage {
  @Require appIdStr: string = ''
  readonly FULL_WIDTH: string = '100%'
  private nativeRouter =
    KARuntimeManager.getInstance().getAlchemyNativeRouterManager()?.registerNativeRouter('RouterUUId_NativeLauncher',
      NativeRouterScene.NATIVE_LAUNCHER)

  build() {
    Column() {

      Text('OpenPlatform Test')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .fontSize(20)
        .textAlign(TextAlign.Center)

      Button('Test InvokeOpenApi')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .onClick(() => {
          const params: Map<string, string> = new Map()
          params.set('appId', this.appIdStr)
          this.nativeRouter?.nativePageGo(this.getUniqueId(), RouterName_InvokeOpenApiPage, params)
        })

      Button('Test NativeRouter')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .onClick(() => {
          this.nativeRouter?.nativePageGo(this.getUniqueId(), RouterName_NativeRouterTestPage)
        })

      Button('Test AlchemyWebView')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .onClick(() => {
          this.nativeRouter?.nativePageGo(this.getUniqueId(), RouterName_WebViewTestPage)
        })

    }
    .height('100%')
    .backgroundColor($r('sys.color.titlebar_icon_background_color'))
    .padding(10)
  }
}