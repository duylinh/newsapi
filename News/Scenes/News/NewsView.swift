//
//  NewsView.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

final class NewsView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private lazy var viewModel: NewsViewModel = {
        return .init()
    }()
    
    private lazy var dataSource: NewsViewDataSource = {
        return NewsViewDataSource(viewModel: self.viewModel)
    }()
    
    private var index: Int = 0
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        viewModel.delegate = self
        
        dataSource.configure(with: tableView)
        
        dataSource.configure(with: collectionView)
        viewModel.fetchKeywords()
        viewModel.index = 0
    }
}

extension NewsView: NewsViewModelDelegate {
    func fetchNewsAndDidUpdateTable(_ viewModel: NewsViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didSelectItem(_ item: ArticleModel) {
        
    }
    
    func loadKeywordsAndDidUpdateKeysCollection(_ viewModel: NewsViewModel) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showAlertError(_ error: ErrorViewModel) {
        
    }
}
