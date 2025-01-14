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
import LKShortcutExternal
import UIKit

/// An implementation of protocol `KAShortcutProtocol`
public class WorkplaceOpenShortcut: KAShortcutProtocol {
    /// The identifier of custom shortcut
    public var type: String {
        "workspace_open"
    }

    /// The shortcurt icon
    public var icon: UIApplicationShortcutIcon {
        UIApplicationShortcutIcon(type: .home)
    }

    /// The shortcut name
    public var localizedTitle: String {
        "打开日历"
    }

    /// The shorcut subtitile
    public var localizedSubtitle: String? {
        nil
    }

    /// Opens this link on clicking the shortcut
    public var appLinkURL: String {
        "https://applink.feishu.cn/client/calendar/open"
    }
}

/// Registry class
@objcMembers
public class LKShortcutExternalTemplate: NSObject {
    /// Registry method invoked in Object-C  on loading
    public class func swiftLoad(channel: String) {
        let api = KAAPI(channel: channel)
        api.register(shortcut: WorkplaceOpenShortcut.init, cache: true)
    }
}
