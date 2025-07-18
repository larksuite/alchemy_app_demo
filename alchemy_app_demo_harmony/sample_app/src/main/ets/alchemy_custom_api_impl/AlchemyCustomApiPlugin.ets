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
  IAlchemyCustomApiPlugin,
  CustomApiResult,
  CustomApiResultCallback,
  CustomApiResultType,
  INativeAppPluginContext,
  NativeAppCustomEvent
} from "alchemyruntime";

export class AlchemyCustomApiPlugin implements IAlchemyCustomApiPlugin {
  private nativeAppPluginContext?: INativeAppPluginContext

  onCreate(nativeAppPluginContext: INativeAppPluginContext): void {
    this.nativeAppPluginContext = nativeAppPluginContext
  }

  getPluginApiNames(): string[] {
    return ['testSuccess', 'testFail', 'testContinueCallback']
  }

  handleEvent(apiName: string, callback: CustomApiResultCallback, params?: object | undefined): void {
    switch (apiName) {
      case 'testSuccess':
        callback(new CustomApiResult(CustomApiResultType.SUCCESS, params))
        break
      case 'testFail':
        const obj: object = new Object()
        obj['failReason'] = 'some thing wrong'
        callback(new CustomApiResult(CustomApiResultType.FAIL, obj))
        break
      case 'testContinueCallback':
        let time = 0
        const intervalID = setInterval(() => {
          const obj: object = new Object()
          obj['times'] = time++
          const event = new NativeAppCustomEvent('testContinue', obj)
          this.nativeAppPluginContext?.fireEvent(event)
          if (time === 5) {
            clearInterval(intervalID)
          }
        }, 2000)
        break
    }
  }
}