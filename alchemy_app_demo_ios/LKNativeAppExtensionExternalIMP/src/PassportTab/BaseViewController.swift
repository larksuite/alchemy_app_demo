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

import UIKit

class BaseViewController: UIViewController {
    enum ToastState: Int {
        case success
        case failure
        case warning
    }

    private var activityIndicator: UIActivityIndicatorView?
    private let shadowView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setBackground()
        addCopyrightView()
    }

    func showLoading() {
        if let activityIndicator {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        let activityIndicator = UIActivityIndicatorView()
        self.activityIndicator = activityIndicator
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }

    func hideLoading() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }

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
        case .success: icon.image = ImageKey.icon_yes_outlined.image
        case .failure: icon.image = ImageKey.icon_more_outlined.image
        case .warning: icon.image = ImageKey.icon_warning_outlined.image
        }

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

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            toast.removeFromSuperview()
            dismissCompletion?()
        }
    }

    private func setBackground() {
        let background = UIImageView(image: ImageKey.background.image)
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addCopyrightView() {
        let label = UILabel()
        view.addSubview(label)
        label.text = "Copyright © 2024 Demo 科技有限公司"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor(hex: 0x8F959E)
        label.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-101)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
