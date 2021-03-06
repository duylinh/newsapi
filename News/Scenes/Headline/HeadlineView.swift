//
//  HeadlineView.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

final class HeadlineView: BaseController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private lazy var viewModel: HeadlineViewModel = {
        return .init()
    }()
    
    private lazy var dataSource: HeadlineViewDataSource = {
        return HeadlineViewDataSource(viewModel: self.viewModel)
    }()
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top News"
        viewModel.delegate = self
        dataSource.configure(with: tableView)
        displayLoading()
        viewModel.fetchData()
    }
}

extension HeadlineView: HeadlineViewModelDelegate {
    func fetchDataAndDidUpdate(_ viewModel: HeadlineViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideLoading()
        }
    }
    
    func didSelectItem(_ article: ArticleModel) {
        let controller = ArticleDetailView.instantiate()
        self.navigationController?.push(controller, animated: false, completion: {
            controller.article = article
        })
    }
    
    func showAlertError(_ error: ErrorViewModel) {
        self.hideLoading()
    }
}
