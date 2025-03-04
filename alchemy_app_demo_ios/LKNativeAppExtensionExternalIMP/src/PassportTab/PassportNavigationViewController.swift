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
import LKAppLinkExternal
import LKKABridge

class PassportNavigationViewController: UINavigationController {
    private var kaApi: KAAPI?

    static func create(state: String, channel: String) -> PassportNavigationViewController {
        let passwordVerify = PasswordVerify()
        let faceVerify = FaceVerify()
        let rootVC: UIViewController

        // 判断否开启人脸识别，以及是否已经保存过账户密码
        let shouldUseFaceID = PassportStore.shouldUseFaceID() && (PassportStore.userNameAndPassword() != nil)
        if shouldUseFaceID {
            // 如果是的话，显示人脸识别登录界面
            let faceVerifyViewController = FaceVerifyViewController(state: state, faceVerify: faceVerify, passportVerify: passwordVerify)
            rootVC = faceVerifyViewController
        } else {
            // 如果否的话，显示原生登录界面
            let passportViewController = PassportViewController(state: state, passwordVerify: passwordVerify)
            rootVC = passportViewController
        }

        let navi = PassportNavigationViewController(rootViewController: rootVC, passwordVerify: passwordVerify, faceVerify: faceVerify, channel: channel)
        (rootVC as? FaceVerifyViewController)?.delegate = navi
        (rootVC as? PassportViewController)?.delegate = navi
        return navi
    }

    private let passwordVerify: PasswordVerify
    private let faceVerify: FaceVerify

    init(rootViewController: UIViewController, passwordVerify: PasswordVerify, faceVerify: FaceVerify, channel: String) {
        self.passwordVerify = passwordVerify
        self.faceVerify = faceVerify
        kaApi = KAAPI(channel: channel)
        super.init(rootViewController: rootViewController)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func goToAppMainWith(vc: BaseViewController, landURL: PasswordVerify.LandURL) {
        guard let landURL = NSURL(string: landURL), let navi = vc.navigationController else { return }
        vc.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            vc.hideLoading()
        }
        kaApi?.navigator?.open(url: landURL, from: navi)
    }
}

extension PassportNavigationViewController: PassportViewControllerDelegate {
    func loginSucced(_ vc: PassportViewController, userName: String, password: String, landURL: PasswordVerify.LandURL) {
        PassportStore.set(userName: userName, password: password)
        if !PassportStore.shouldUseFaceID() {
            // 如果没有开启faceid，引导开启faceid
            let enableFaceIDVC = EnableFaceIDViewController(faceVerify: faceVerify, landURL: landURL)
            enableFaceIDVC.delegate = self
            vc.navigationController?.pushViewController(enableFaceIDVC, animated: true)
        } else {
            goToAppMainWith(vc: vc, landURL: landURL)
        }
    }
}

extension PassportNavigationViewController: EnableFaceIDViewControllerDelegate {
    func enableSuccess(_ vc: EnableFaceIDViewController, landURL: PasswordVerify.LandURL) {
        PassportStore.setShouldUseFaceID(true)
        goToAppMainWith(vc: vc, landURL: landURL)
    }

    func enableFailed(_: EnableFaceIDViewController, error _: Error, landURL _: PasswordVerify.LandURL) {
        PassportStore.setShouldUseFaceID(false)
    }

    func skip(_ vc: EnableFaceIDViewController, landURL: PasswordVerify.LandURL) {
        PassportStore.setShouldUseFaceID(false)
        goToAppMainWith(vc: vc, landURL: landURL)
    }
}

extension PassportNavigationViewController: FaceVerifyViewControllerDelegate {
    func userNameAndPassword(vc _: FaceVerifyViewController) -> (String, String)? {
        PassportStore.userNameAndPassword()
    }

    func faceIDVerifySuccess(vc: FaceVerifyViewController, userName: String, password: String, landURL: PasswordVerify.LandURL) {
        PassportStore.set(userName: userName, password: password)
        goToAppMainWith(vc: vc, landURL: landURL)
    }

    func phoneLoginClicked(vc: FaceVerifyViewController, state: String) {
        let passportViewController = PassportViewController(state: state, passwordVerify: passwordVerify)
        passportViewController.delegate = self
        vc.navigationController?.pushViewController(passportViewController, animated: true)
    }
}
