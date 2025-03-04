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

extension UIButton {
    func setupButtonView(icon: String, title: String, backgroundColor: UIColor? = .themeBlue, fontColor: UIColor = .white) {
        layer.cornerRadius = 6
        self.backgroundColor = backgroundColor

        let layout = UILayoutGuide()
        addLayoutGuide(layout)
        layout.snp.makeConstraints { make in
            make.top.bottom.centerX.equalTo(self)
        }

        let iconImage = UIImageView(image: ImageKey(rawValue: icon)?.image.withRenderingMode(.alwaysTemplate))
        layout.owningView?.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.left.equalTo(layout).offset(16)
            make.size.equalTo(20)
            make.centerY.equalTo(layout)
        }
        iconImage.tintColor = fontColor

        let verifyText = UILabel()
        verifyText.text = title
        verifyText.font = UIFont.systemFont(ofSize: 17, weight: .light)
        verifyText.textColor = fontColor
        layout.owningView?.addSubview(verifyText)
        verifyText.snp.makeConstraints { make in
            make.left.equalTo(iconImage.snp.right).offset(4)
            make.right.equalTo(layout).offset(-16)
            make.centerY.equalTo(layout)
            make.width.equalTo(verifyText.intrinsicContentSize.width)
        }
    }
}
