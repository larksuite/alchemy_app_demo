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

protocol FaceVerifyViewControllerDelegate: AnyObject {
    func faceIDVerifySuccess(vc: FaceVerifyViewController, userName: String, password: String, landURL: PasswordVerify.LandURL)
    func phoneLoginClicked(vc: FaceVerifyViewController, state: String)
    func userNameAndPassword(vc: FaceVerifyViewController) -> (String, String)?
}

class FaceVerifyViewController: BaseViewController {
    private let buttonHeight = 48
    private let contentPadding = 24

    private let faceVerify: FaceVerify
    private let passportVerify: PasswordVerify
    private let state: String

    private let contentLayout = UILayoutGuide()
    private let verifyIcon = UIImageView()
    private let verifyLabel = UILabel()
    private let verifyButton = UIButton()
    private let phoneLoginButton = UIButton()

    weak var delegate: FaceVerifyViewControllerDelegate?
    init(state: String, faceVerify: FaceVerify, passportVerify: PasswordVerify) {
        self.state = state
        self.faceVerify = faceVerify
        self.passportVerify = passportVerify
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        view.addLayoutGuide(contentLayout)
        contentLayout.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(contentPadding)
            make.height.equalTo(304)
        }

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
        verifyButton.setupButtonView(icon: "icon_scan_outlined", title: "人脸识别")
        verifyButton.addTarget(self, action: #selector(verifyButtonClicked), for: .touchUpInside)
        verifyButton.snp.makeConstraints { make in
            make.left.right.equalTo(contentLayout)
            make.top.equalTo(verifyLabel.snp.bottom).offset(140)
            make.height.equalTo(buttonHeight)
        }

        view.addSubview(phoneLoginButton)
        phoneLoginButton.setupButtonView(
            icon: "icon_phone_outlined",
            title: "手机号登录",
            backgroundColor: .none,
            fontColor: .themeBlue
        )
        phoneLoginButton.addTarget(self, action: #selector(phoneLoginButtonClicked), for: .touchUpInside)
        phoneLoginButton.snp.makeConstraints { make in
            make.left.right.equalTo(contentLayout)
            make.top.equalTo(verifyButton.snp.bottom).offset(20)
            make.height.equalTo(buttonHeight)
        }
    }

    @objc
    private func verifyButtonClicked(withSkip _: Bool = true) {
        showLoading()

        faceVerify.verify { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                guard let (userName, password) = delegate?.userNameAndPassword(vc: self) else {
                    hideLoading()
                    showToast(state: .failure, text: "登录失败,没有保存过账号密码，请使用手机号登录")
                    return
                }

                passportVerify.checkPassword(phone: userName, password: password, state: state) { result in
                    DispatchQueue.main.async {
                        self.hideLoading()
                        switch result {
                        case let .success(landURL):
                            self.showToast(state: .success, text: "登录成功") {
                                self.delegate?.faceIDVerifySuccess(vc: self, userName: userName, password: password, landURL: landURL)
                            }
                        case let .failure(error):
                            self.showToast(state: .failure, text: "登录失败: \(error.localizedDescription)")
                        }
                    }
                }
            case let .failure(error):
                hideLoading()
                showToast(state: .failure, text: "登录失败，请重试或使用手机号登录")
            }
        }
    }

    @objc
    private func phoneLoginButtonClicked() {
        delegate?.phoneLoginClicked(vc: self, state: state)
    }
}
