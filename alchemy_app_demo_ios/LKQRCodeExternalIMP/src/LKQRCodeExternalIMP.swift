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
import LKLoggerExternalIMP
import LKNativeAppOpenApiExternalIMP
import LKQRCodeExternal

class LKQRCode: KAQRCodeApiDelegate {
    private static let tag = "AlchemyAppQRCode"

    static func log(_ msg: String) {
        LKLoggerExternalTemplate.shared?.log(tag: tag, msg)
    }

    func interceptHandle(result _: String) -> Bool {
        false
    }

    func handle(result: String) -> Bool {
        Self.log("handle result")
        LKNativeAppPublicKitTemplate.shared?.showToast(result)
        return false
    }
}

/// Registry class
@objcMembers
public class LKQRCodeExternalTemplate: NSObject {
    /// Registry method invoked in Object-C  on loading
    public class func swiftLoad(channel: String) {
        let api = KAAPI(channel: channel)
        api.register(qrcodeAPIDelegate: LKQRCode.init, cache: true)
    }
}
