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

extension UITextView {
    func setStyleWithText(text: NSAttributedString, lineHeight: CGFloat = 22) {
        attributedText = text
        textColor = .black
        tintColor = UIColor.themeBlue
        font = UIFont.systemFont(ofSize: 14, weight: .light)
        backgroundColor = .none

        isEditable = false
        isScrollEnabled = false
        let padding = (lineHeight - (font?.lineHeight ?? lineHeight)) / 2
        textContainerInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        textContainer.lineFragmentPadding = 0
    }
}
