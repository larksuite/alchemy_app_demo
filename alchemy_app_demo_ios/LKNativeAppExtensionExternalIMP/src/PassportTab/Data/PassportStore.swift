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

enum PassportStore {
    private static let faceIDKey = "PassportStore_faceIDKey"
    private static let userNameKey = "PassportStore_userNameKey"
    private static let passwordKey = "PassportStore_passwordKey"

    static func shouldUseFaceID() -> Bool {
        UserDefaults.standard.bool(forKey: faceIDKey)
    }

    static func setShouldUseFaceID(_ shouldUseFaceID: Bool) {
        UserDefaults.standard.set(shouldUseFaceID, forKey: faceIDKey)
    }

    static func set(userName: String, password: String) {
        UserDefaults.standard.set(userName, forKey: userNameKey)
        UserDefaults.standard.set(password, forKey: passwordKey)
    }

    static func userNameAndPassword() -> (String, String)? {
        let userName = UserDefaults.standard.string(forKey: Self.userNameKey)
        let password = UserDefaults.standard.string(forKey: Self.passwordKey)
        if let userName, let password {
            return (userName, password)
        } else {
            return nil
        }
    }
}
