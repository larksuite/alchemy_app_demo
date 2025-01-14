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

enum I18nKey: String {
    // swiftlint:disable identifier_name
    case Lark_Demo_ActionNotSupportedInDemo_Toast
    case Lark_Demo_EmptyNumberOrPassword_Toast
    case Lark_Demo_EnterPassword_Placeholder
    case Lark_Demo_EnterPhoneNumber_Placeholder
    case Lark_Demo_FaceID_Confirmed_Toast
    case Lark_Demo_FaceID_Enable_Button
    case Lark_Demo_FaceID_Enable_Text
    case Lark_Demo_FaceID_Enbaled_Toast
    case Lark_Demo_FaceID_FailRetry_Button
    case Lark_Demo_FaceID_Fail_Toast
    case Lark_Demo_FaceID_Recognizing_Toast
    case Lark_Demo_FaceID_Skip_Button
    case Lark_Demo_FaceID_UsePhone_Button
    case Lark_Demo_ForgotPassword_Text
    case Lark_Demo_IncorrectNumberOrPassword_Toast
    case Lark_Demo_LogIn_Button
    case Lark_Demo_ResetPassword_Button
    case Lark_Demo_Welcome_Title
    // swiftlint:enable identifier_name
    static func localizedString(with key: Self) -> String {
        NSLocalizedString(key.rawValue, bundle: BundleConfig.LKNativeAppExtensionIMPAutoBundle, comment: "")
    }

    var localizedString: String {
        Self.localizedString(with: self)
    }
}
