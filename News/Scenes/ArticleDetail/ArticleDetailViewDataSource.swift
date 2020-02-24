//
//  ArticleDetailViewDataSource.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable all

final class ArticleDetailViewDataSource: NSObject {
    
    // MARK: - Properties
    
    private unowned let viewModel: ArticleDetailViewModel

    // MARK: - Con(De)structor
    
    init(viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Internal methods
    
    func configure(with tableView: UITableView) {
        tableView.backgroundColor = Colors.paleGrey
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ArticleDetailCell.nib, forCellReuseIdentifier: ArticleDetailCell.Identifier)
        tableView.register(ArticleDetailTitleCell.nib, forCellReuseIdentifier: ArticleDetailTitleCell.Identifier)
    }
}

extension ArticleDetailViewDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let itemCell = tableView.dequeueReusableCell(withIdentifier: ArticleDetailTitleCell.Identifier, for: indexPath) as? ArticleDetailTitleCell {
                itemCell.configure(self.viewModel.article)
                return itemCell
            }
            break
        case 1:
            if let itemCell = tableView.dequeueReusableCell(withIdentifier: ArticleDetailCell.Identifier, for: indexPath) as? ArticleDetailCell {
                itemCell.configure(self.viewModel.article)
                return itemCell
            }
            break
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = self.viewModel.article else { return }
        viewModel.delegate?.didSelectOnView(article)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return ArticleDetailTitleCell.height
        case 1:
            return ArticleDetailCell.height
        default:
            return 0
        }
        
    }
}
