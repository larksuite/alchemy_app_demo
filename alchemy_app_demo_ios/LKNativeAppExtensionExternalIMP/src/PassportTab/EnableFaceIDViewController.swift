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
import SnapKit
import UIKit

protocol EnableFaceIDViewControllerDelegate: AnyObject {
    func enableSuccess(_ vc: EnableFaceIDViewController, landURL: PasswordVerify.LandURL)
    func enableFailed(_ vc: EnableFaceIDViewController, error: Error, landURL: PasswordVerify.LandURL)
    func skip(_ vc: EnableFaceIDViewController, landURL: PasswordVerify.LandURL)
}

class EnableFaceIDViewController: BaseViewController {
    private let landURL: PasswordVerify.LandURL

    private let buttonHeight = 48
    private let contentPadding = 24

    private let faceVerify: FaceVerify

    private let contentLayout = UILayoutGuide()
    private let verifyIcon = UIImageView()
    private let verifyLabel = UILabel()
    private let verifyButton = UIButton()
    private let skipLabel = UILabel()

    private var activityIndicator: UIActivityIndicatorView?

    weak var delegate: EnableFaceIDViewControllerDelegate?

    init(faceVerify: FaceVerify, landURL: PasswordVerify.LandURL) {
        self.faceVerify = faceVerify
        self.landURL = landURL
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(skipLabel)
        skipLabel.text = "跳过"
        skipLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        skipLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-contentPadding)
            make.width.equalTo(skipLabel.intrinsicContentSize.width)
        }
        skipLabel.textColor = UIColor.themeBlue
        skipLabel.isUserInteractionEnabled = true
        let skipGesture = UITapGestureRecognizer(target: self, action: #selector(tapSkip))
        skipLabel.addGestureRecognizer(skipGesture)

        view.addLayoutGuide(contentLayout)
        contentLayout.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(contentPadding)
            make.height.equalTo(304)
        }

        view.addSubview(verifyIcon)
        view.addSubview(verifyIcon)
        verifyIcon.image = ImageKey.facial.image
        verifyIcon.snp.makeConstraints { make in
            make.top.equalTo(contentLayout)
            make.centerX.equalTo(contentLayout)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }

        view.addSubview(verifyLabel)
        verifyLabel.text = "开启人脸识别，安全快捷登录"
        verifyLabel.font = .systemFont(ofSize: 16, weight: .light)
        verifyLabel.textAlignment = .center
        verifyLabel.textColor = UIColor(hex: 0x1F2329)
        verifyLabel.snp.makeConstraints { make in
            make.top.equalTo(verifyIcon.snp.bottom).offset(22)
            make.left.right.equalTo(contentLayout)
        }

        view.addSubview(verifyButton)
        verifyButton.setupButtonView(icon: "icon_scan_outlined", title: "开启人脸识别")
        verifyButton.addTarget(self, action: #selector(verifyButtonClicked), for: .touchUpInside)
        verifyButton.snp.makeConstraints { make in
            make.left.right.equalTo(contentLayout)
            make.top.equalTo(verifyLabel.snp.bottom).offset(140)
            make.height.equalTo(buttonHeight)
        }
    }

    @objc
    private func tapSkip() {
        delegate?.skip(self, landURL: landURL)
    }

    @objc
    private func verifyButtonClicked() {
        showLoading()
        faceVerify.verify { [weak self] result in
            self?.hideLoading()
            guard let self else { return }
            switch result {
            case .success:
                showToast(state: .success, text: "开启成功，即将进入应用")
                delegate?.enableSuccess(self, landURL: landURL)
            case let .failure(error):
                showToast(state: .failure, text: "开启失败，请重试或跳过")
                delegate?.enableFailed(self, error: error, landURL: landURL)
            }
        }
    }
}
