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

final class BundleConfig: NSObject {
    static let SelfBundle: Bundle = {
        if let url = Bundle.main.url(forResource: "Frameworks/LKNativeAppExtensionIMP", withExtension: "framework") {
            return Bundle(url: url)!
        } else {
            #if DEBUG
                return Bundle(for: BundleConfig.self)
            #else
                return Bundle.main
            #endif
        }
    }()

    private static let LKNativeAppExtensionIMPBundleURL = SelfBundle.url(forResource: "LKNativeAppExtensionIMP", withExtension: "bundle")!
    private static let LKNativeAppExtensionIMPAutoBundleURL = SelfBundle.url(forResource: "LKNativeAppExtensionIMPAuto", withExtension: "bundle")!
    static let LKNativeAppExtensionIMPBundle = Bundle(url: LKNativeAppExtensionIMPBundleURL)!
    static let LKNativeAppExtensionIMPAutoBundle = Bundle(url: LKNativeAppExtensionIMPAutoBundleURL)!
}
