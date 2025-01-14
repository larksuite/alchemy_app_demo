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
import LKTabExternal

/// An implementation of protocol `KATabProtocol`
@objc
public class MySwiftTab: NSObject {
    func createTabRootViewController() -> UIViewController {
        TabRootViewController(nibName: nil, bundle: nil)
    }

    func createFirstButton(tabViewController _: UIViewController) -> UIButton? {
        let button = UIButton(type: .system)
        button.setTitle("first", for: .normal)
        return button
    }

    func createSecondButton(tabViewController _: UIViewController) -> UIButton? {
        let button = UIButton(type: .system)
        button.setTitle("second", for: .normal)
        return button
    }

    func singleClick() {}

    func doubleClick() {}
}

@objc
extension MySwiftTab: KATabProtocol {
    /// The id of the application bounded to the tab
    public var appId: String { "YOUR_APP_ID_RELATED_TOKEN" }
    /// Whether to show the navigation bar
    public var showNaviBar: Bool { false }
    /// The navigation title
    public var naviBarTitle: String? { "三方邮件" }
    /// The root ViewController of the tab
    public var tabViewController: () -> UIViewController { createTabRootViewController }
    /// The first button in navigation bar
    public var firstNaviBarButton: ((UIViewController) -> UIButton?)? { createFirstButton }
    /// The second button in navigation bar
    public var secondNaviBarButton: ((UIViewController) -> UIButton?)? { createSecondButton }
    /// Custom method on single click
    public var tabSingleClick: (() -> Void)? { singleClick }
    /// Custom method on double click
    public var tabDoubleClick: (() -> Void)? { doubleClick }
}

/// Registry class
@objcMembers
public class LKTabExternalTemplate: NSObject {
    /// Registry method invoked in Object-C  on loading
    public class func swiftLoad(channel: String) {
        let api = KAAPI(channel: channel)
        api.register(tab: MySwiftTab.init, cache: true)
    }
}
