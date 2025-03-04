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
import LKMessageExternal
import LKNativeAppPublicKitIMP

/// A class which provides a singleton to invoke the `KAMessageNavigator` ability
@objcMembers
public class LKMessageExternalTemplate: NSObject {
    private var kaapi: KAAPI
    private var navigator: KAMessageNavigator? {
        kaapi.messageNavigator
    }

    /// A singleton to invoke the `KAMessageNavigator` ability
    public static var shared: LKMessageExternalTemplate?

    init(channel: String) {
        kaapi = KAAPI(channel: channel)
    }

    /// Invokes the `forward` method in `KAMessageNavigator` ability
    public func forward(path: String) {
        let body = MessageBody()
        body.filePath = path
        let msg = KAMessage(type: .file, body: body)

        navigator?.forward(message: msg)
    }

    /// Invokes the `dowload` method in `KAMessageNavigator` ability
    public func download(messages: [ActionMessage]) {
        func onSuccess(info: [MessageInfo]) {
            let infos = info.map { info in
                info.name
            }

            let suc = { (_: String) in
                LKNativeAppPublicKitTemplate.showToast("download succeeds")
            }

            let err = { (_: Error) in
                LKNativeAppPublicKitTemplate.showToast("download fails")
            }
            if info.isEmpty {
                LKNativeAppPublicKitTemplate.showToast("no available resource")
            } else {
                navigator?.downloadResource(messageInfo: info[0], onSuccess: suc, onError: err)
            }
        }

        func onError(error _: Error) {
            LKNativeAppPublicKitTemplate.showToast("get resource fails")
        }

        navigator?.getResources(messages: messages, onSuccess: onSuccess, onError: onError)
    }

    /// Initiliazes the singleton on loading Object-C classes
    public static func swiftLoad(channel: String) {
        LKMessageExternalTemplate.shared = LKMessageExternalTemplate(channel: channel)
    }
}

class MessageBody: KAFileMessageProtocol {
    var filePath: String = ""
}
