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

@objc
class TabSidebarController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let transitionManager = SidebarTransitionManager()
    private let cellIdentifier = "TabSidebarCell"
    private let borderHeight: CGFloat = 1
    static let sectionRowNumber = [1, 6, 1]

    private var rootController: TabRootViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-16)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none

        tableView.register(SidebarUITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    init(rootController: TabRootViewController) {
        self.rootController = rootController
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = transitionManager
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        Self.sectionRowNumber[section]
    }

    func numberOfSections(in _: UITableView) -> Int {
        Self.sectionRowNumber.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        guard let sidebarCell = cell as? SidebarUITableViewCell else {
            return cell
        }
        sidebarCell.setView(indexPath.section, indexPath.row)
        return sidebarCell
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        8 + borderHeight
    }

    func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 0 ? 0 : 8
    }

    func tableView(_: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section != 0 {
            let separator = UIView()
            view.addSubview(separator)
            separator.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(borderHeight)
            }
            separator.backgroundColor = UIColor(hex: 0xDEE0E3)
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            showToast(container: rootController)
        }
    }
}

private class SidebarUITableViewCell: UITableViewCell {
    static let menuList = [
        MenuInfo(icon: "envelope.fill", label: "收件箱"),
        MenuInfo(icon: "flag.fill", label: "红旗邮件"),
        MenuInfo(icon: "pencil.circle.fill", label: "草稿箱"),
        MenuInfo(icon: "paperplane.fill", label: "已发送"),
        MenuInfo(icon: "trash.fill", label: "已删除"),
        MenuInfo(icon: "exclamationmark.circle.fill", label: "垃圾邮件"),
        MenuInfo(icon: "plus.circle.fill", label: "新建"),
    ]

    let mailIcon = UIView()
    let menuIcon = UIImageView()
    let label = UILabel()

    var isTitle = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        addSubview(label)
        setMenu(0, withInit: true)

        mailIcon.backgroundColor = UIColor(hex: 0xFF811A)
        mailIcon.layer.cornerRadius = 9

        let mailIconImage = UIImageView(image: iconImage("mail.stack"))
        mailIconImage.tintColor = .white
        mailIcon.addSubview(mailIconImage)
        mailIconImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(22)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView(_ section: Int, _ row: Int) {
        switch section {
        case 0:
            setTitle()
        case 1:
            setMenu(row, withInit: isTitle)
        case 2:
            setMenu(row + TabSidebarController.sectionRowNumber[1], withInit: isTitle)
        default: break
        }
    }

    func setTitle() {
        if isTitle {
            return
        }
        menuIcon.removeFromSuperview()
        isTitle = true

        addSubview(mailIcon)
        mailIcon.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
            make.size.equalTo(38)
        }

        label.text = "第三方邮件"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.snp.remakeConstraints { make in
            make.left.equalTo(mailIcon.snp.right).offset(8)
            make.centerY.equalTo(mailIcon.snp.centerY)
        }
    }

    func setMenu(_ index: Int, withInit: Bool) {
        isTitle = false

        if withInit {
            mailIcon.removeFromSuperview()

            addSubview(menuIcon)
            menuIcon.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(4)
                make.centerY.equalToSuperview()
                make.size.equalTo(16)
            }

            label.font = .systemFont(ofSize: 16)
            label.snp.remakeConstraints { make in
                make.left.equalTo(menuIcon.snp.right).offset(10)
                make.centerY.equalToSuperview()
            }
        }

        menuIcon.image = iconImage(Self.menuList[index].icon)
        menuIcon.tintColor = .gray
        label.text = Self.menuList[index].label
    }
}

private struct MenuInfo {
    let icon: String
    let label: String
}
