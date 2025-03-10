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
import LKNativeAppExtensionExternal

/// An implementation of protocol `LKNativeAppExtension` and `LKNativeAppExtensionPageRoute`
public class PassportPageRoute: NSObject, KANativeAppExtensionProtocol {
    /// The channel id
    public static var channel: String?

    /// Returns your app login token (usually an app_id)
    public func appId() -> String {
        "YOUR_APP_LOGIN_TOKEN"
    }

    /// Initializes the channel id on loading Object-C classes
    @objc
    public static func swiftLoad(channel: String) {
        Self.channel = channel
        let api = KAAPI(channel: channel)
        api.register(nativeApp: PassportPageRoute.init, cache: true)
    }

    /// Page route to the custom login ViewController
    public func pageRoute(_ link: URL!, from: UIViewController!) {
        let state = URLComponents(url: link!, resolvingAgainstBaseURL: false)?
            .queryItems?
            .first(where: { $0.name == "state" })?
            .value ?? ""
        let rootVC = PassportNavigationViewController.create(state: state, channel: Self.channel ?? "")
        rootVC.modalPresentationStyle = .fullScreen
        from.present(rootVC, animated: true)
    }
}
