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

export const RouterName_NativeRouterTestPage = 'NativeRouterTestPage'

@Builder
export function nativeRouterTestPageBuilder(params: Map<string, Unknown>) {
  NativeRouterTestPage({})
}

@Entry
@Component
export struct NativeRouterTestPage {
  readonly FULL_WIDTH: string = '100%'
  private nativeRouter =
    KARuntimeManager.getInstance().getAlchemyNativeRouterManager()?.registerNativeRouter('RouterUUId_NativeLauncher',
      NativeRouterScene.NATIVE_LAUNCHER)

  build() {
    Column() {

      Text('NativeRouterTestPage')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .fontSize(20)
        .textAlign(TextAlign.Center)

      Button('nativePageGo')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .onClick(() => {
          this.nativeRouter?.nativePageGo(this.getUniqueId(), RouterName_NativeRouterTestPage)
        })

      Button('nativePageBack')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .onClick(() => {
          this.nativeRouter?.nativePageBack(this.getUniqueId())
        })

      Button('nativePageClear')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .onClick(() => {
          this.nativeRouter?.nativePageClear(this.getUniqueId())
        })

    }
    .height('100%')
    .backgroundColor($r('sys.color.titlebar_icon_background_color'))
    .padding(10)
  }
}