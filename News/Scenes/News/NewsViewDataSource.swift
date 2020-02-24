//
//  NewsViewDataSource.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable all

final class NewsViewDataSource: NSObject {
    
    // MARK: - Properties
    
    private unowned let viewModel: NewsViewModel

    // MARK: - Con(De)structor
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Internal methods
    
    func configure(with tableView: UITableView) {
        tableView.backgroundColor = Colors.paleGrey
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleCell.nib, forCellReuseIdentifier: ArticleCell.Identifier)
    }
    
    func configure(with collectionView: UICollectionView) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        
        let flowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        flowLayout.itemSize = CGSize(width: 155, height: 40)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.estimatedItemSize = CGSize(width: 155, height: 40)
        collectionView.collectionViewLayout = flowLayout
    }
}

extension NewsViewDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.Identifier, for: indexPath) as? ArticleCell {
            let item = self.viewModel.articles[indexPath.row]
            itemCell.configure(item)
            return itemCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.viewModel.articles[indexPath.row]
        self.viewModel.delegate?.didSelectItem(item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleCell.height
    }
}

extension NewsViewDataSource : UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.keywords.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: KeywordCell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.Identifier , for: indexPath) as? KeywordCell   {
            let item: KeywordModel = viewModel.keywords[indexPath.row]
            cell.configure(with: item)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension NewsViewDataSource: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.updateKeywords(with: indexPath)
    }
}
