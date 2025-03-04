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

enum ImageKey: String {
    // swiftlint:disable identifier_name
    case unchecked
    case photo
    case icon_yes_outlined
    case icon_show_video_outlined
    case icon_scan_outlined
    case icon_phone_outlined
    case icon_more_close_outlined
    case icon_more_outlined
    case icon_warning_outlined
    case icon_lock_outlined
    case icon_hide_video_outlined
    case facial
    case checked
    case background
    // swiftlint:enable identifier_name

    static func image(with key: Self) -> UIImage {
        UIImage(named: key.rawValue,
                in: BundleConfig.LKNativeAppExtensionIMPBundle,
                compatibleWith: nil) ?? UIImage()
    }

    var image: UIImage {
        Self.image(with: self)
    }
}
