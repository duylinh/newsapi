//
//  ProfileView.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

final class ProfileView: BaseController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private lazy var viewModel: ProfileViewModel = {
        return .init()
    }()
    
    private lazy var dataSource: ProfileViewDataSource = {
        return ProfileViewDataSource(viewModel: self.viewModel)
    }()
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.rightBarTitle = "Keyword"
        self.leftBarTitle = "Register"
        
        viewModel.delegate = self
        dataSource.configure(with: collectionView)
        displayLoading()
        viewModel.fetchKeywordsActive()
    }
    
    // MARK: - Actions
    
    override func rightMenuAction() {
        let controller = self.setPopupVC(storyboradID: "Popup", viewControllerID: "BottomKeywordPopup") as? BottomKeywordPopup
        controller?.delegate = self
        controller?.popupAlign = .bottom
        controller?.popupAnimation = .bottom
        controller?.touchDismiss = true
        var bottomInset: CGFloat = 0
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            bottomInset = window.safeAreaInsets.bottom
        }
        let height: CGFloat = Screen.Width == 320.0 ? 320.0 : 280.0
        controller?.popupSize = CGSize(width: self.view.frame.width, height: height + bottomInset)
        self.presentPopup(controller: controller, completion: nil)
        delay(0.01) {
            controller?.fetchKeywordsFromLocalDB()
        }
    }
    
    override func leftMenuAction() {
        let controller = RegisterController.instantiate()
        self.present(controller, animated: false) {
            
        }
    }
}

extension ProfileView: ProfileViewModelDelegate {
    func loadKeywordsAndDidUpdateKeysCollection(_ viewModel: ProfileViewModel) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.hideLoading()
        }
    }
}

extension ProfileView: BottomKeywordPopupDelegate {
    func saveKeywords(_ keywords: [KeywordModel]) {
        defer {
            self.viewModel.keywords = keywords
//            let coreDataManager = CoreDataManager.shared
//            coreDataManager.fetchAllKeywords { (results) in
//                for key in keywords {
//                    for item in results {
//                        coreDataManager.updateKeyword(for: item, keyword: key.keyword, isSelected: key.isSelected) { (_) in }
//                    }
//                }
//            }
        }
        self.dismissPopup { (_) in }
    }
}
