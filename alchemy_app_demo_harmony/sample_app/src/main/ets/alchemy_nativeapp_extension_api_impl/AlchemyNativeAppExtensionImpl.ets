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

import { IAlchemyNativeAppExtension } from "alchemyruntime";
import { KARuntimeManager } from "../core/KARuntimeManager";

export class AlchemyNativeAppExtensionImpl implements IAlchemyNativeAppExtension {
  init(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('AlchemyNativeAppExtensionImpl', 'init');
  }

  destroy(): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('AlchemyNativeAppExtensionImpl', 'destroy');
  }

  getAppId(): string {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('AlchemyNativeAppExtensionImpl', 'getAppId: YOUR_APP_ID');
    return "YOUR_APP_ID"
  }

  pageRoute(linkUrl: string): void {
    KARuntimeManager.getInstance().getAlchemyLogger()?.info('AlchemyNativeAppExtensionImpl', `pageRoute: ${linkUrl}`);
  }
}