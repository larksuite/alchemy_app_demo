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

class PasswordTextField: UITextField {
    private let iconSecure = UIImageView()
    private let iconHide = ImageKey.icon_hide_video_outlined.image
    private let iconShow = ImageKey.icon_show_video_outlined.image

    override init(frame: CGRect) {
        super.init(frame: frame)
        isSecureTextEntry = true
        iconSecure.image = iconHide

        rightViewMode = .always
        let iconSecureView = UIView()
        iconSecureView.addSubview(iconSecure)
        iconSecure.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        rightView = iconSecureView

        iconSecure.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchSecureState))
        iconSecure.addGestureRecognizer(tapGesture)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func switchSecureState() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            iconSecure.image = iconHide
        } else {
            iconSecure.image = iconShow
        }
    }
}
