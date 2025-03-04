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

extension UIColor {
    static var themeBlue: UIColor { UIColor(hex: 0x1456F0) }

    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0xFF00) >> 8) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

func iconImage(_ name: String) -> UIImage? {
    if #available(iOS 13.0, *) {
        UIImage(systemName: name)
    } else {
        nil
    }
}

@objc
enum ToastState: Int {
    case success
    case failure
    case warning
}

extension UIViewController {
    @objc
    func showToast(container: UIViewController? = nil, state: ToastState = .warning, text: String = "Demo 内暂不支持操作", dismissCompletion: (() -> Void)? = nil) {
        let toast = UIView()
        view.addSubview(toast)
        let height: CGFloat = 40
        let container = container ?? self
        toast.snp.makeConstraints { make in
            make.bottom.equalTo(container.view.safeAreaLayoutGuide.snp.bottom).offset(-41)
            make.centerX.equalTo(container.view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(height)
        }
        toast.backgroundColor = UIColor(hex: 0x1F2329)
        toast.layer.cornerRadius = height / 2

        let icon = UIImageView()
        toast.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
            make.left.equalToSuperview().offset(20)
        }
        switch state {
        case .success: icon.image = iconImage("checkmark.circle")
        case .failure: icon.image = iconImage("xmark.circle")
        case .warning: icon.image = iconImage("exclamationmark.circle")
        }
        icon.tintColor = .white

        let toastLabel = UILabel()
        toast.addSubview(toastLabel)
        toastLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(icon.snp.right).offset(8)
        }
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.text = text

        UIView.animate(withDuration: 0.2, delay: 2.0, options: .curveEaseOut, animations: {
            toast.alpha = 0.0
        }, completion: { _ in
            toast.removeFromSuperview()
            dismissCompletion?()
        })
    }

    func addCopyrightView() {
        let label = UILabel()
        view.addSubview(label)
        label.text = "Copyright © 2024 Demo 科技有限公司"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor(hex: 0x8F959E)
        label.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-101)
            make.width.equalTo(label.intrinsicContentSize.width)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
