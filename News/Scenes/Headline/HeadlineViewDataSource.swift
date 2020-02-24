//
//  HeadlineViewDataSource.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

final class HeadlineViewDataSource: NSObject {
    
    // MARK: - Properties
    
    private unowned let viewModel: HeadlineViewModel

    // MARK: - Con(De)structor
    
    init(viewModel: HeadlineViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Internal methods
    
    func configure(with tableView: UITableView) {
        tableView.backgroundColor = Colors.paleGrey
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleCell.nib, forCellReuseIdentifier: ArticleCell.Identifier)
    }
}

extension HeadlineViewDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.Identifier, for: indexPath) as? ArticleCell {
            let item = self.viewModel.items[indexPath.row]
            itemCell.configure(item)
            return itemCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.viewModel.items[indexPath.row]
        self.viewModel.delegate?.didSelectItem(item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleCell.height
    }
}
