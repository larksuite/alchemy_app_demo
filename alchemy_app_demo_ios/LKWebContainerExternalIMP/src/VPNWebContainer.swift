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
import LKWebContainerExternal
import SnapKit

/// An implementation of protocol `KAWebContainerProtocol`
@objc public class VPNWebContainer: NSObject {
    /// Init method
    override public init() {
        super.init()
    }

    func connect() -> Bool {
        true
    }
}

@objc
extension VPNWebContainer: KAWebContainerProtocol {
    /// Method on closing the web page
    public func onClose(url _: String) {}

    /// Method on changing table visibility
    public func onTabVisibilityChanged(selected _: Bool, tabParams _: LKWebContainerExternal.TabParams) {}

    /// Set error page config
    public func errorPageConfig() -> LKWebContainerExternal.KAWebContainerErrorPageConfig? {
        nil
    }

    /// Method on openning a web page
    public func onOpen(url: String, onSuccess: @escaping () -> Void, onFail: @escaping (_ code: Int) -> Void) {
        if url != "http://www.feishu.cn", url != "https://www.feishu.cn" {
            onSuccess()
            return
        }

        let alertController = UIAlertController(
            title: I18nKey.Lark_Demo_VPN_Connect_Title.localizedString,
            message: I18nKey.Lark_Demo_VPN_Connect_Desc.localizedString,
            preferredStyle: .alert
        )

        let controller = UIApplication.shared.keyWindow?.rootViewController
        let confirmAction = UIAlertAction(title: I18nKey.Lark_Demo_VPN_Connect_Button.localizedString, style: .default) { _ in
            if self.connect() {
                onSuccess()
            } else {
                controller?.showToast()
            }
        }

        let cancelAction = UIAlertAction(title: I18nKey.Lark_Demo_VPN_Connect_Cancel_Button.localizedString, style: .cancel) { _ in
            onFail(-1)
        }
        cancelAction.setValue(UIColor(hex: 0x1F2329), forKey: "titleTextColor")
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        controller?.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    func showToast() {
        let toast = UIView()
        view.addSubview(toast)
        let height: CGFloat = 40
        view.addSubview(toast)
        toast.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-106)
            make.centerX.equalToSuperview()
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
        icon.image = iconImage("exclamationmark.circle")
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
        toastLabel.text = "VPN 连接失败，无法打开应用，请重试"

        UIView.animate(withDuration: 0.2, delay: 2.0, options: .curveEaseOut, animations: {
            toast.alpha = 0.0
        }, completion: { _ in
            toast.removeFromSuperview()
        })
    }
}

extension UIColor {
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

enum I18nKey: String {
    // swiftlint:disable identifier_name
    case Lark_Demo_VPN_Connect_Title
    case Lark_Demo_VPN_Connect_Desc
    case Lark_Demo_VPN_Connect_Button
    case Lark_Demo_VPN_Connect_Cancel_Button
    // swiftlint:enable identifier_name

    static func localizedString(with key: Self) -> String {
        NSLocalizedString(key.rawValue, bundle: BundleConfig.LKWebContainerExternalIMPAutoBundle, comment: "")
    }

    var localizedString: String {
        Self.localizedString(with: self)
    }
}
