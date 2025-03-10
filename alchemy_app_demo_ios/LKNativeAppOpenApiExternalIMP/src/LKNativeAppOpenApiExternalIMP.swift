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

import LKKABridge
import LKNativeAppOpenApiExternal

/// A class which provides a singleton to invoke the `NativeAppManagerProtocol` ability
public class LKNativeAppPublicKitTemplate: NSObject {
    private var kaapi: KAAPI
    private var openApi: KANativeAppOpenApiDelegate? {
        kaapi.nativeAppOpenApi
    }

    /// A singleton to invoke the `KALoggerProtocol` ability
    public static var shared: LKNativeAppPublicKitTemplate?

    /// Invoke the `showToast` open api
    public func showToast(_ content: String) {
        openApi?.invokeOpenApi(appID: "YOUR_APP_ID", apiName: "showToast", params: ["title": content]) { _ in
            /* handle result*/
        }
    }

    init(channel: String) {
        kaapi = KAAPI(channel: channel)
    }

    /// Initiliazes the singleton on loading Object-C classes
    @objc
    public class func swiftLoad(channel: String) {
        shared = LKNativeAppPublicKitTemplate(channel: channel)
    }
}
