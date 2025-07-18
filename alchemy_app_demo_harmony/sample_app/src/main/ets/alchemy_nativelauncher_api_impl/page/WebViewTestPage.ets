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

import { Unknown } from "alchemyruntime"
import { KARuntimeManager } from "../../core/KARuntimeManager"

export const RouterName_WebViewTestPage = 'WebViewTestPage'

@Builder
export function webViewTestPageBuilder(params: Map<string, Unknown>) {
  WebViewTestPage({})
}

@Entry
@Component
export struct WebViewTestPage {
  readonly FULL_WIDTH: string = '100%'
  private alchemyWebView = KARuntimeManager.getInstance().getAlchemyWebView()

  build() {
    Column() {

      Text('setCookie(\'https://...Lark_Debug_Page5.html\',\'myKey=AlchemyWebView_Cookie\')')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .fontSize(20)
        .textAlign(TextAlign.Center)

      Button('setCookie')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .onClick(() => {
          this.alchemyWebView?.setCookie('your_test_html','myKey=AlchemyWebView_Cookie')
        })

      Text('appendUserAgent(\'AlchemyWebView_UserAgent\')')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .fontSize(20)
        .textAlign(TextAlign.Center)

      Button('appendUserAgent')
        .width(this.FULL_WIDTH)
        .margin({ top: 20 })
        .onClick(() => {
          this.alchemyWebView?.appendUserAgent('AlchemyWebView_UserAgent')
        })

    }
    .height('100%')
    .backgroundColor($r('sys.color.titlebar_icon_background_color'))
    .padding(10)
  }
}