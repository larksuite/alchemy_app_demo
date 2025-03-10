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
import LKKACore
import LKLifecycleExternal
import LKLoggerExternalIMP
import UIKit

/// Implements callback functions in lifecycle
public class LKLifecycleTest: KALifecycleProtocol {
    private static let tag = "AlchemyAppLifecycle"

    static func log(_ msg: String) {
        LKLoggerExternalTemplate.shared?.log(tag: tag, msg)
    }

    /// Executes on start
    public func start() {}

    /// Executes on resume
    public func resume() {}

    /// Executes on pause
    public func pause() {}

    /// Executes on finishing login
    public func onLoginSuccess() {
        Self.log("User login success")
    }

    /// Executes on login failure
    public func onLoginFail() {
        Self.log("User login fail")
    }

    /// Executes on logging out
    public func onLogout() {
        Self.log("User log out")
    }
}

/// Registry class
@objcMembers
public class LKLifecycleExternalTemplate: NSObject {
    /// Initializes `LKLifecycleIMP` on loading Object-C classes
    public class func swiftLoad(channel: String) {
        let api = KAAPI(channel: channel)
        api.register(lifecycle: LKLifecycleTest.init, cache: true)
    }
}
