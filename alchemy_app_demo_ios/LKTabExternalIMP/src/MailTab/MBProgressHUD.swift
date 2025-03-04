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
import SnapKit
import UIKit

/// The root ViewController of custom tab page
@objc
public class TabRootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tableView: UITableView!
    private var sidebar: TabSidebarController!
    private let cellIdentifier = "TableRootViewCell"

    /// Initialize ViewController
    override public func viewDidLoad() {
        sidebar = TabSidebarController(rootController: self)

        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let topBar = UIView()
        view.addSubview(topBar)
        topBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }

        let menuButton = UIButton()
        topBar.addSubview(menuButton)
        menuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.size.equalTo(38)
        }
        menuButton.setImage(iconImage("line.3.horizontal"), for: .normal)
        menuButton.tintColor = .gray
        menuButton.imageView?.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.center.equalToSuperview()
        }
        menuButton.backgroundColor = UIColor(hex: 0xEFF0F1)
        menuButton.layer.cornerRadius = 6
        menuButton.addTarget(self, action: #selector(presentSidebar), for: .touchUpInside)

        let searchBar = UISearchBar()
        topBar.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(menuButton.snp.top)
            make.height.equalTo(menuButton.snp.height)
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(menuButton.snp.right).offset(12)
        }
        searchBar.placeholder = "搜索"
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 6
        var searchTextField: UITextField?
        if #available(iOS 13.0, *) {
            searchTextField = searchBar.searchTextField
        } else {
            if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
                searchTextField = searchField
            }
        }
        searchTextField?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom) // .offset(UIDevice.current.userInterfaceIdiom == .pad  ? 0:-95)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(TabRootViewCell.self, forCellReuseIdentifier: cellIdentifier)

        let actionButton = UIButton()
        view.addSubview(actionButton)
        let actionButtionSize: CGFloat = 64
        actionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(tableView.snp.bottom).offset(-30)
            make.size.equalTo(actionButtionSize)
        }
        actionButton.layer.cornerRadius = actionButtionSize / 2
        actionButton.backgroundColor = UIColor(hex: 0xFF811A)
        actionButton.tintColor = UIColor.white
        actionButton.setImage(iconImage("rectangle.and.pencil.and.ellipsis"), for: .normal)
        actionButton.imageView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(32)
        }
        actionButton.tintColor = .white
        actionButton.addTarget(self, action: #selector(createMail), for: .touchUpInside)
    }

    // MARK: - UITableViewDataSource

    /// Return the number of rows in the table
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        30
    }

    /// Return a cell in the table
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let rootCell = cell as? TabRootViewCell else {
            return cell
        }
        rootCell.setStyle(row: indexPath.row)
        return rootCell
    }

    // MARK: - UITableViewDelegate

    /// Event handler on selecting
    public func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        let newViewController = TabMailViewController()
        navigationController?.pushViewController(newViewController, animated: false)
    }
}

extension TabRootViewController {
    @objc
    private func presentSidebar() {
        present(sidebar, animated: true)
    }

    @objc
    private func createMail() {
        showToast()
    }
}

private class TabRootViewCell: UITableViewCell {
    static let colors: [UInt] = [0x25B0E7, 0x35BD4B, 0xFF811A, 0xDF58A5, 0x8D55ED, 0x336DF4, 0x5B65F5]

    let avatar: UIView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(avatar)
        let avatarSize: CGFloat = 40
        avatar.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.size.equalTo(avatarSize)
        }
        avatar.layer.cornerRadius = avatarSize / 2

        let avatarLabel = UILabel()
        avatar.addSubview(avatarLabel)
        avatarLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        avatarLabel.text = "F"
        avatarLabel.font = .systemFont(ofSize: 24, weight: .medium)
        avatarLabel.textColor = UIColor.white

        let labelTime = UILabel()
        addSubview(labelTime)
        labelTime.text = "2月16日"
        labelTime.font = .systemFont(ofSize: 10)
        labelTime.snp.updateConstraints { make in
            make.top.equalTo(avatar.snp.top)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(labelTime.intrinsicContentSize.width)
        }

        let labelTitle = UILabel()
        addSubview(labelTitle)
        labelTitle.text = "Future Property Auctions NEW ENTRY - FORMER HILL FORTRESS set..."
        labelTitle.numberOfLines = 2
        labelTitle.font = .systemFont(ofSize: 14)
        labelTitle.textColor = UIColor(hex: 0x1F2329)
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.top)
            make.left.equalTo(avatar.snp.right).offset(12)
            make.right.equalTo(labelTime.snp.left).offset(-20)
        }

        let labelDetail = UILabel()
        addSubview(labelDetail)
        labelDetail.text = "Email Summary (Hidden) Future Property Auct..."
        labelDetail.font = .systemFont(ofSize: 12, weight: .light)
        labelDetail.textColor = UIColor(hex: 0x8F959E)
        labelDetail.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(4)
            make.left.equalTo(labelTitle.snp.left)
            make.width.equalTo(labelTitle.snp.width)
            make.bottom.equalToSuperview().offset(-16)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setStyle(row: Int) {
        avatar.backgroundColor = UIColor(hex: Self.colors[row % Self.colors.count])
    }
}
