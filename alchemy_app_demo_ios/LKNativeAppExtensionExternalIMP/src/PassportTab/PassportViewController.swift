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

protocol PassportViewControllerDelegate: AnyObject {
    func loginSucced(_ vc: PassportViewController, userName: String, password: String, landURL: PasswordVerify.LandURL)
}

class PassportViewController: BaseViewController, UITextViewDelegate {
    private let state: String
    private let passportVerify: PasswordVerify

    private let contentLayout = UILayoutGuide()
    private let titleLabel = UILabel()
    private let phoneTextField = UITextField()
    private let passwordTextField = PasswordTextField()
    private let loginButton = UIButton()
    private let agreeCheckBox = CheckBoxButton()
    private let agreeText = UITextView()
    private let forgotPasswordText = UITextView()

    weak var delegate: PassportViewControllerDelegate?

    init(state: String, passwordVerify: PasswordVerify) {
        self.state = state
        passportVerify = passwordVerify
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addLayoutGuide(contentLayout)
        contentLayout.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(24)
        }

        contentLayout.owningView?.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentLayout)
        }
        titleLabel.text = I18nKey.Lark_Demo_Welcome_Title.localizedString
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)

        contentLayout.owningView?.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.left.right.equalTo(contentLayout)
            make.height.equalTo(48)
        }
        phoneTextField.setContent(icon: "icon_phone_outlined", placeholder: "请输入手机号")
        phoneTextField.autocapitalizationType = .none

        contentLayout.owningView?.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(12)
            make.left.right.equalTo(contentLayout)
            make.height.equalTo(48)
        }
        passwordTextField.setContent(icon: "icon_lock_outlined", placeholder: "请输入密码")

        contentLayout.owningView?.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.left.right.equalTo(contentLayout)
            make.height.equalTo(48)
        }
        loginButton.layer.cornerRadius = 6
        loginButton.backgroundColor = UIColor.themeBlue
        loginButton.setTitle("立即登录", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)

        contentLayout.owningView?.addSubview(agreeCheckBox)
        agreeCheckBox.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.left.equalTo(contentLayout)
            make.height.equalTo(19)
            make.width.equalTo(16)
        }

        let textViewLineHeight: CGFloat = 22

        contentLayout.owningView?.addSubview(agreeText)
        agreeText.snp.makeConstraints { make in
            make.top.equalTo(agreeCheckBox)
            make.left.equalTo(agreeCheckBox.snp.right).offset(8)
            make.right.equalToSuperview()
            make.height.equalTo(22)
        }
        let agreeAttributedString = NSMutableAttributedString(string: "我已阅读并同意 服务协议 和 隐私政策")
        agreeAttributedString.addAttribute(.link, value: "ServiceProtocol", range: NSRange(location: 8, length: 4))
        agreeAttributedString.addAttribute(.link, value: "PrivacyPolicy", range: NSRange(location: 15, length: 4))
        agreeText.setStyleWithText(text: agreeAttributedString, lineHeight: textViewLineHeight)
        agreeText.delegate = self

        view.addSubview(forgotPasswordText)
        forgotPasswordText.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-181)
            make.width.equalTo(forgotPasswordText.intrinsicContentSize.width)
            make.centerX.equalToSuperview()
            make.height.equalTo(textViewLineHeight)
        }
        let forgotPasswordAttributedString = NSMutableAttributedString(string: "忘记密码？点击重置")
        forgotPasswordAttributedString.addAttribute(.link, value: "ResetPassword", range: NSRange(location: 5, length: 4))
        forgotPasswordText.setStyleWithText(text: forgotPasswordAttributedString, lineHeight: textViewLineHeight)
        forgotPasswordText.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    func textView(_: UITextView, shouldInteractWith _: URL, in _: NSRange) -> Bool {
        showToast()
        return false
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc
    private func loginButtonClicked() {
        let phone = phoneTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        guard !phone.isEmpty, !password.isEmpty else {
            showToast(state: .failure, text: "账户名和密码不能为空")
            return
        }

        guard agreeCheckBox.isSelected else {
            showToast(state: .failure, text: "需要同意用户协议")
            return
        }

        showLoading()
        passportVerify.checkPassword(phone: phone, password: password, state: state) { result in
            DispatchQueue.main.async {
                self.hideLoading()
                switch result {
                case let .success(landURL):
                    self.showToast(state: .success, text: "登录成功") {
                        self.delegate?.loginSucced(self, userName: phone, password: password, landURL: landURL)
                    }
                case let .failure(error):
                    self.showToast(text: "登录失败: \(error.localizedDescription)")
                }
            }
        }
    }
}
