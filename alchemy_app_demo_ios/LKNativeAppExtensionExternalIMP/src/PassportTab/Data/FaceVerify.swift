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
import LocalAuthentication

class FaceVerify {
    enum FaceVerifyError: Error {
        case enableFailed
        case veriryFailed
    }

    func verify(callback: @escaping (Result<Void, FaceVerifyError>) -> Void) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if context.biometryType == .faceID {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "正在进行FaceID认证") { success, _ in
                    DispatchQueue.main.async {
                        success ? callback(.success(())) : callback(.failure(.veriryFailed))
                    }
                }
            } else {
                callback(.failure(.enableFailed))
            }
        } else {
            callback(.failure(.enableFailed))
        }
    }
}
