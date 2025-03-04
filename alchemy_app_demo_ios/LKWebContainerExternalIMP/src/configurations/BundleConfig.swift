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

// swiftlint:disable all
final class BundleConfig: NSObject {
    static let SelfBundle: Bundle = {
        if let url = Bundle.main.url(forResource: "Frameworks/LKWebContainerExternalIMP", withExtension: "framework") {
            return Bundle(url: url)!
        } else {
            // 单测会有问题，所以DEBUG模式不动
            #if DEBUG
                return Bundle(for: BundleConfig.self)
            #else
                return Bundle.main
            #endif
        }
    }()

    private static let LKWebContainerExternalIMPBundleURL = SelfBundle.url(forResource: "LKWebContainerExternalIMP", withExtension: "bundle")!
    private static let LKWebContainerExternalIMPAutoBundleURL = SelfBundle.url(forResource: "LKWebContainerExternalIMPAuto", withExtension: "bundle")!
    static let LKWebContainerExternalIMPBundle = Bundle(url: LKWebContainerExternalIMPBundleURL)!
    static let LKWebContainerExternalIMPAutoBundle = Bundle(url: LKWebContainerExternalIMPAutoBundleURL)!
}

// swiftlint:enable all
