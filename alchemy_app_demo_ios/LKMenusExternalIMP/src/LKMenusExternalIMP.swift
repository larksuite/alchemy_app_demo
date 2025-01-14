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

import Foundation
import LKKABridge
import LKMenusExternal
import LKMessageExternalIMP
import UIKit

private class LKMenus: KAMenusProtocol {
    var icon: UIImage = if #available(iOS 13.0, *) {
        .init(systemName: "mail") ?? UIImage()
    } else {
        .init()
    }

    var label: String = "下载"

    func canInitialize(_ actionContext: LKMenusExternal.ActionContext) -> Bool {
        actionContext.actionMessages.contains(where: { $0.type == .file })
    }

    func onClick(_ actionContext: LKMenusExternal.ActionContext) {
        LKMessageExternalTemplate.shared?.download(messages: actionContext.actionMessages)
    }
}

private class LKMenusExternalIMP: NSObject {
    override init() {}
}

/// Registry class
@objcMembers
public class LKMenusExternalTemplate: NSObject {
    /// Registry method invoked in Object-C  on loading
    public class func swiftLoad(channel: String) {
        let api = KAAPI(channel: channel)
        api.register(menu: LKMenus.init, cache: true)
    }
}
