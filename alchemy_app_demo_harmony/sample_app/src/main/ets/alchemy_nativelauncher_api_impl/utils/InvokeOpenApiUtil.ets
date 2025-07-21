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
  IAlchemyNativeAppManager,
  IOpenApiContainer,
  OpenApiConfig,
  OpenApiResult,
  OpenApiResultCallback,
  OpenApiResultType
} from "alchemyruntime";

export class InvokeOpenApiUtil {
  private container?: IOpenApiContainer

  initOpenApiContainer(manager: IAlchemyNativeAppManager, containerId: string, openApiConfig: OpenApiConfig) {
    this.container = manager.initOpenApiContainer(containerId, openApiConfig)
  }

  invokeOpenApi(apiName: string, openApiResultCallback: OpenApiResultCallback, params?: object) {
    if (!this.container) {
      const result =
        new OpenApiResult(OpenApiResultType.FAIL, JSON.parse('{"errInfo":"initOpenApiContainer first !!!"}'))
      openApiResultCallback(result)
      return
    }
    this.container.invokeOpenApi(apiName, openApiResultCallback, params)
  }

  refreshContainer(openApiConfig: OpenApiConfig) {
    this.container?.refreshContainer(openApiConfig)
  }
}

export const invokeOpenApiUtil = new InvokeOpenApiUtil()
