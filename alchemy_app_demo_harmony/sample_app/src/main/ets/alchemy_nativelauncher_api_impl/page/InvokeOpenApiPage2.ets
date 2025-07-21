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

import { Unknown, OpenApiConfig, OpenApiResult } from 'alchemyruntime'
import { KARuntimeManager } from '../../core/KARuntimeManager';
import { invokeOpenApiUtil } from '../utils/InvokeOpenApiUtil';

export const RouterName_InvokeOpenApiPage2 = 'InvokeOpenApiPage2'

@Builder
export function invokeOpenApiPage2Builder(params: Map<string, Unknown>) {
  InvokeOpenApiPage2({})
}

@Entry({ routeName: 'ZZY_InvokeOpenApiPage_2' })
@Component
struct InvokeOpenApiPage2 {
  readonly FULL_WIDTH: string = '100%'
  @State useGlobal: boolean = false
  @State apiNameStr: string = 'previewImage'
  @State appIdStr: string = 'YOUR_APP_ID'
  @State paramsStr: string = '{"urls":["https://sf3-scmcdn2-cn.feishucdn.com/ee/lark/open/web/static/app-banner.05b68b58.png"],"header":{"testHeader":"1234567890"},"current":"","shouldShowSaveOption":false}'
  @State resultStr: string = 'resultType: \nresultData:'

  build() {
    Scroll(){
      Column() {
        TextArea({ text: $$this.apiNameStr })
          .textInputStyle()

        Text('params:')
          .hintTextStyle()
        TextArea({ text: $$this.paramsStr })
          .textInputStyle()
          .align(Alignment.TopStart)
          .height(100)

        Text('初始化OpenApiContainer，未传入componentUniqueId，调用previewImage无法正常跳转 预览页面')
          .margin({ top: 20 })
          .fontSize(16)
          .fontColor($r('sys.color.titlebar_icon_color'))

        Button('initOpenApiContainer first , no componentUniqueId')
          .width(this.FULL_WIDTH)
          .margin({ top: 20 })
          .onClick(() => this.initOpenApiContainer())

        Button('Invoke previewImage')
          .width(this.FULL_WIDTH)
          .margin({ top: 20 })
          .onClick(() => this.invokeOpenApi())

        Text('refreshContainer，补全componentUniqueId，再次调用previewImage可正常跳转 预览页面')
          .margin({ top: 20 })
          .fontSize(16)
          .fontColor($r('sys.color.titlebar_icon_color'))

        Button('refreshContainer')
          .width(this.FULL_WIDTH)
          .margin({ top: 20 })
          .onClick(() => {
            const openApiConfig: OpenApiConfig = {
              uiContext: this.getUIContext(),
              componentUniqueId: this.getUniqueId()
            }
            invokeOpenApiUtil.refreshContainer(openApiConfig)
          })

        Text('result:')
          .hintTextStyle()
        Text(this.resultStr)
          .width('100%')
          .height(200)
          .margin({ top: 4 })
          .padding({ top: 8, left: 18 })
          .fontSize(16)
          .align(Alignment.TopStart)
          .backgroundColor(Color.White)
          .borderRadius(10)

      }
      .backgroundColor($r('sys.color.titlebar_icon_background_color'))
      .padding(10)
    }
  }

  initOpenApiContainer() {
    const manager =
      this.useGlobal ? KARuntimeManager.getInstance().getGlobalNativeAppManager() :
      KARuntimeManager.getInstance().getNativeAppManager()
    if (!manager) {
      return
    }
    const openApiConfig: OpenApiConfig = {
      uiContext: this.getUIContext(),
    }
    invokeOpenApiUtil.initOpenApiContainer(manager, this.appIdStr, openApiConfig)
  }

  invokeOpenApi() {
    const manager =
      this.useGlobal ? KARuntimeManager.getInstance().getGlobalNativeAppManager() :
      KARuntimeManager.getInstance().getNativeAppManager()
    if (!manager) {
      this.resultStr = 'resultType: FAIL \nresultData: manager is undefined'
      return
    }
    const nativeAppApiCallback = (result: OpenApiResult) => {
      const resultType = result.resultType === 0 ? 'SUCCESS' : 'FAIL'
      this.resultStr = 'resultType: ' + resultType + '\nresultData: ' + JSON.stringify(result.resultData)
    }
    try {
      console.info('InvokeOpenApiPage2 getUniqueId = ' + this.getUniqueId())
      const params = this.paramsStr.length > 0 ? JSON.parse(this.paramsStr) as object : undefined
      invokeOpenApiUtil.invokeOpenApi(this.apiNameStr, nativeAppApiCallback, params)
    } catch (e) {
      this.resultStr = 'resultType: FAIL \nresultData: params parse error'
    }
  }
}

@Extend(Text)
function hintTextStyle() {
  .width('100%')
  .margin({ top: 20 })
  .fontSize(16)
  .fontColor($r('sys.color.titlebar_icon_background_color'))
}

@Extend(TextArea)
function textInputStyle() {
  .width('100%')
  .margin({ top: 4 })
  .backgroundColor(Color.White)
  .borderRadius(10)
  .fontSize(16)
}
