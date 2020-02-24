//
//  ArticleDetailView.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

final class ArticleDetailView: BaseController {
    
    internal static func instantiate() -> ArticleDetailView {
        return Storyboard.Article.instantiate(type: ArticleDetailView.self)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private lazy var viewModel: ArticleDetailViewModel = {
        return .init()
    }()
    
    private lazy var dataSource: ArticleDetailViewDataSource = {
        return ArticleDetailViewDataSource(viewModel: self.viewModel)
    }()
    
    var article: ArticleModel? {
        didSet {
            viewModel.article = article
        }
    }
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        self.backBarImage = "ic_back"
        viewModel.delegate = self
        dataSource.configure(with: tableView)
    }
}

extension ArticleDetailView: ArticleDetailViewModelDelegate {
    
    func didUpdateTableView(_ viewModel: ArticleDetailViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideLoading()
        }
    }
    
    func didSelectOnView(_ item: ArticleModel) {
        
    }
}
