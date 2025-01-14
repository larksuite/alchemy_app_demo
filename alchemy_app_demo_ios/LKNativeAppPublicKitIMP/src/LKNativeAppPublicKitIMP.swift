/*
 * Copyright (c) 2025 Lark Technologies Pte. Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import NativeAppPublicKit

/// A class which provides a singleton to invoke the `NativeAppManagerProtocol` ability
public class LKNativeAppPublicKitTemplate: NSObject {
    static let manager = NativeAppConnectManager.shared.getNativeAppManager()

    /// Invoke the `showToast` open api
    public static func showToast(_ content: String) {
        manager?.invokeOpenApi(appID: "YOUR_APP_ID", apiName: "showToast", params: ["title": content]) { _ in
            /* handle result*/
        }
    }
}
