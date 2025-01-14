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
import UIKit

class SidebarPresentationController: UIPresentationController {
    override var shouldRemovePresentersView: Bool {
        false
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        if let containerView {
            containerView.insertSubview(dimmingView, at: 0)
            dimmingView.snp.makeConstraints { make in
                make.bottom.top.equalTo(0)
                make.size.equalTo(containerView.snp.size)
            }
        }
    }

    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedController))
        view.addGestureRecognizer(tapRecognizer)

        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissPresentedController))
        swipeRecognizer.direction = .left
        view.addGestureRecognizer(swipeRecognizer)

        return view
    }()

    @objc private func dismissPresentedController() {
        presentedViewController.dismiss(animated: true)
    }
}
