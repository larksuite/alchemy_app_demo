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
import LKKACore
import LKLoggerExternalIMP
import UIKit

/// Implements callback functions in lifecycle
public class LKLifecycleTest {
    private static let tag = "AlchemyAppLifecycle"

    static func log(_ msg: String) {
        LKLoggerExternalTemplate.shared?.log(tag: tag, msg)
    }

    func start() {}

    func resume() {}

    func pause() {}

    func onLoginSuccess() {
        Self.log("User login success")
    }

    func onLoginFail() {
        Self.log("User login fail")
    }

    func onLogout() {
        Self.log("User log out")
    }
}

/// Registry class
@objcMembers
public class LKLifecycleExternalTemplate: NSObject {
    static let shared = LKLifecycleExternalTemplate()
    fileprivate let imp = LKLifecycleIMP()

    /// Initializes `LKLifecycleIMP` on loading Object-C classes
    public class func swiftLoad() {
        _ = shared
    }
}

/// Registers the lifecycle observer functions on initialization
public class LKLifecycleIMP {
    private let lifecycle: LKLifecycleTest = .init()

    init() {
        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(LKLifecycle.start), object: nil, queue: nil) { _ in
            self.lifecycle.start()
        }

        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(LKLifecycle.resume), object: nil, queue: nil) { _ in
            self.lifecycle.resume()
        }

        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(LKLifecycle.pause), object: nil, queue: nil) { _ in
            self.lifecycle.pause()
        }

        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(LKLifecycle.onLoginSuccess), object: nil, queue: nil) { _ in
            self.lifecycle.onLoginSuccess()
        }

        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(LKLifecycle.onLoginFail), object: nil, queue: nil) { _ in
            self.lifecycle.onLoginFail()
        }

        _ = NotificationCenter.default.addObserver(forName: NSNotification.Name(LKLifecycle.onLogout), object: nil, queue: nil) { _ in
            self.lifecycle.onLogout()
        }
    }
}
