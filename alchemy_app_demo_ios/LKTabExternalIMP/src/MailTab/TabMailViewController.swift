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

import CoreGraphics
import Foundation
import LKKABridge
import LKMessageExternalIMP
import SnapKit
import UIKit

/// The ViewContoller of a mail page
public class TabMailViewController: UIViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.text = "Future Property Auctions"
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }

        let subTitleLabel = UILabel()
        view.addSubview(subTitleLabel)
        subTitleLabel.text = "From: \n2月16日"
        subTitleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        subTitleLabel.numberOfLines = 2
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(titleLabel)
        }

        let border = UIView()
        view.addSubview(border)
        border.backgroundColor = .gray
        border.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(subTitleLabel)
            make.height.equalTo(1)
        }

        let clipIconImage = UIImageView()
        if #available(iOS 13.0, *) {
            clipIconImage.image = UIImage(systemName: "paperclip")
        }
        view.addSubview(clipIconImage)
        clipIconImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.left.equalTo(border)
            make.top.equalTo(border.snp.bottom).offset(20)
        }
        clipIconImage.tintColor = .gray

        let attachLabel = UILabel()
        view.addSubview(attachLabel)
        attachLabel.text = "attachment.txt"
        attachLabel.font = .systemFont(ofSize: 16, weight: .regular)
        attachLabel.textColor = .blue
        attachLabel.snp.makeConstraints { make in
            make.centerY.equalTo(clipIconImage)
            make.left.equalTo(clipIconImage.snp.right).offset(10)
        }
        attachLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forward))
        attachLabel.addGestureRecognizer(tapGesture)
    }

    @objc
    func forward() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        let fileName = "attachment.txt"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if !FileManager.default.fileExists(atPath: fileURL.path) {
            let content = "Hello, this is a sample attachment!"

            do {
                try content.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {}
        }

        LKMessageExternalTemplate.shared?.forward(path: fileURL.path)
    }
}
