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

class SidebarSlideAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool = true

    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key: UITransitionContextViewControllerKey = isPresenting ? .to : .from
        guard let presentedController = transitionContext.viewController(forKey: key) else {
            return
        }

        let presentedFrame = transitionContext.finalFrame(for: presentedController)
        let dismissedFrame = presentedFrame.offsetBy(dx: -presentedFrame.width, dy: 0)

        if isPresenting {
            transitionContext.containerView.addSubview(presentedController.view)
            presentedController.view.snp.makeConstraints { make in
                make.width.equalTo(348)
                make.top.left.height.equalToSuperview()
            }
        }

        let wasCancelled = transitionContext.transitionWasCancelled
        let fromFrame = isPresenting ? dismissedFrame : presentedFrame
        let toFrame = isPresenting ? presentedFrame : dismissedFrame

        presentedController.view.frame = fromFrame
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            presentedController.view.frame = toFrame
        } completion: { _ in
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
