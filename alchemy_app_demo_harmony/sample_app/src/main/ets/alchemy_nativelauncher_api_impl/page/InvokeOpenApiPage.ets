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
  NativeRouterScene,
  OpenApiConfig,
  OpenApiResult,
  OpenApiResultType,
  Unknown
} from 'alchemyruntime'
import { supportApiArray } from '../model/SupportApiModel'
import { router } from '@kit.ArkUI'
import { invokeOpenApiUtil } from '../utils/InvokeOpenApiUtil'
import { RouterName_InvokeOpenApiPage2 } from './InvokeOpenApiPage2'
import { KARuntimeManager } from '../../core/KARuntimeManager'

export const RouterName_InvokeOpenApiPage = 'InvokeOpenApiPage1'

@Builder
export function invokeOpenApiPageBuilder(params: Map<string, Unknown>) {
  InvokeOpenApiPage({ appIdStr: params.get('appId') as string })
}

@Entry({ routeName: 'ZZY_InvokeOpenApiPage' })
@Component
struct InvokeOpenApiPage {
  pathStack: NavPathStack = new NavPathStack();
  readonly FULL_WIDTH: string = '100%'
  @State @Watch('initOpenApiContainer') useGlobal: boolean = false
  @State apiNameStr: string = 'login'
  @State appIdStr: string = 'YOUR_APP_ID'
  @State uuidStr: string = ''
  @State paramsStr: string = ''
  @State resultStr: string = 'resultType: \nresultData:'
  private nativeRouter =
    KARuntimeManager.getInstance().getAlchemyNativeRouterManager()?.registerNativeRouter('RouterUUId_NativeLauncher',
      NativeRouterScene.NATIVE_LAUNCHER)

  build() {
    Navigation(this.pathStack) {
      Scroll() {
        Column() {
          Row() {
            Text('use global channel scope component: ')
              .fontSize(16)
              .fontColor($r('sys.color.titlebar_icon_color'))
            Checkbox()
              .checkBoxStyle()
              .onChange((isChecked: boolean) => {
                this.useGlobal = isChecked
              })
          }
          .checkBoxContainerStyle()

          Text('appId:')
            .hintTextStyle()
          Stack({ alignContent: Alignment.End }) {
            TextArea({ text: $$this.appIdStr })
              .textInputStyle()
            Button('Del', { type: ButtonType.Capsule, stateEffect: false })
              .smallButtonStyle()
              .margin({ top: 4, right: 10 })
              .onClick(() => {
                this.appIdStr = ''
              })
          }

          Text('uuid:')
            .hintTextStyle()
          Stack({ alignContent: Alignment.End }) {
            TextArea({ text: $$this.uuidStr })
              .textInputStyle()
            Button('Del', { type: ButtonType.Capsule, stateEffect: false })
              .smallButtonStyle()
              .margin({ top: 4, right: 10 })
              .onClick(() => {
                this.uuidStr = ''
              })
          }

          Row() {
            Text('apiName:')
              .hintTextStyle()
              .width(80)
            Button('SupportApis', { type: ButtonType.Capsule, stateEffect: false })
              .smallButtonStyle()
              .onClick(() => this.openActionSheet())
          }
          .width(this.FULL_WIDTH)
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Bottom)

          TextArea({ text: $$this.apiNameStr })
            .textInputStyle()

          Text('params:')
            .hintTextStyle()
          TextArea({ text: $$this.paramsStr })
            .textInputStyle()
            .align(Alignment.TopStart)
            .height(100)

          Button('initOpenApiContainer first !!!')
            .width(this.FULL_WIDTH)
            .margin({ top: 20 })
            .onClick(() => this.initOpenApiContainer())

          Button('InvokeOpenApi')
            .width(this.FULL_WIDTH)
            .margin({ top: 20 })
            .onClick(() => this.invokeOpenApi())

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

          Button('test refreshContainer')
            .width(this.FULL_WIDTH)
            .margin({ top: 20 })
            .onClick(() => {
              try {
                // this.pathStack.pushPathByName('ZZY_InvokeOpenApiPage_2', null)
                this.nativeRouter?.nativePageGo(this.getUniqueId(), RouterName_InvokeOpenApiPage2)
              } catch (err) {

              }
            })

          // Button('testRouter')
          //   .width(this.FULL_WIDTH)
          //   .margin({ top: 20 })
          //   .onClick(() => {
          //     router.pushUrl({
          //       url: '@bundle:com.ss.feishu/zzy_hsp_component_a/ets/pages/InvokeOpenApiPage2'
          //     });
          //   })

        }
        .backgroundColor($r('sys.color.titlebar_icon_background_color'))
        .padding(10)
      }
    }
    .mode(NavigationMode.Stack)
  }

  openActionSheet() {
    this.getUIContext().showActionSheet({
      title: 'SupportApiList',
      message: '',
      autoCancel: true,
      confirm: {
        value: 'Confirm',
        action: () => {
        }
      },
      cancel: () => {
      },
      alignment: DialogAlignment.Bottom,
      offset: { dx: 0, dy: -10 },
      sheets: this.getSheetInfoArray()
    })
  }

  getSheetInfoArray(): Array<SheetInfo> {
    const sheetInfoArray: SheetInfo[] = []
    supportApiArray.forEach((apiModel) => {
      const sheetInfo: SheetInfo = {
        title: apiModel.apiName,
        action: (): void => {
          this.apiNameStr = apiModel.apiName
          this.paramsStr = apiModel.params
        }
      }
      sheetInfoArray.push(sheetInfo)
    })
    return sheetInfoArray
  }

  initOpenApiContainer() {
    const manager =
      this.useGlobal ? KARuntimeManager.getInstance().getGlobalNativeAppManager() :
      KARuntimeManager.getInstance().getNativeAppManager()
    if (!manager) {
      this.showToast('manager is undefined')
      return
    }
    const openApiConfig: OpenApiConfig = {
      uiContext: this.getUIContext(),
      componentUniqueId: this.getUniqueId()
    }
    invokeOpenApiUtil.initOpenApiContainer(manager, this.appIdStr, openApiConfig)
    this.showToast('manager init success')
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
      console.info('InvokeOpenApiPage getUniqueId = ' + this.getUniqueId())
      const params = this.paramsStr.length > 0 ? JSON.parse(this.paramsStr) as object : undefined
      invokeOpenApiUtil.invokeOpenApi(this.apiNameStr, nativeAppApiCallback, params)
    } catch (e) {
      this.resultStr = 'resultType: FAIL \nresultData: params parse error'
    }
  }

  testLogin() {
    const appId = 'YOUR_APP_ID' //开发者后台申请的打开原生集成应用能力的应用ID
    const manager = KARuntimeManager.getInstance().getNativeAppManager()
    const nativeAppApiCallback = (result: OpenApiResult) => {
      if (result.resultType === OpenApiResultType.SUCCESS) {
        //请求成功时，result.resultData的数据结构，可参考飞书开放平台官网
        if (result.resultData) {
          const loginToken = result.resultData['code'] as string
          this.resultStr = loginToken
        }
      } else {
        if (result.resultData) {
          //Errno错误码可参考:https://open.larkoffice.com/document/client-docs/block/api/introduce-of-errno
          const errno = result.resultData['errno'] as number
          const errString = result.resultData['errString'] as string
          this.resultStr = errno + ':' + errString
        }
      }
    }
    const openApiConfig: OpenApiConfig = {
      uiContext: this.getUIContext(),
      componentUniqueId: this.getUniqueId()
    }
    const openApiContainer = manager?.initOpenApiContainer(appId, openApiConfig)
    openApiContainer?.invokeOpenApi('login', nativeAppApiCallback)
  }

  showToast(msg: string) {
    this.getUIContext().getPromptAction().showToast({
      message: msg,
      duration: 2000,
    });
  }
}

@Extend(Text)
function hintTextStyle() {
  .width('100%')
  .margin({ top: 20 })
  .fontSize(16)
  .fontColor($r('sys.color.titlebar_icon_color'))
}

@Extend(TextArea)
function textInputStyle() {
  .width('100%')
  .margin({ top: 4 })
  .backgroundColor(Color.White)
  .borderRadius(10)
  .fontSize(16)
}

@Extend(Button)
function smallButtonStyle() {
  .height(20)
  .padding({
    left: 10,
    right: 10,
    top: 0,
    bottom: 0
  })
  .fontSize(12)
}

@Extend(Row)
function checkBoxContainerStyle() {
  .width('100%')
  .margin({ top: 10 })
  .justifyContent(FlexAlign.Start)
  .alignItems(VerticalAlign.Center)
}

@Extend(Checkbox)
function checkBoxStyle() {
  .select(false)
  .height(20)
  .width(20)
}

