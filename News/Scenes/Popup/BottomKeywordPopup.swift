//
//  BottomKeywordPopup.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit
// swiftlint:disable all
protocol BottomKeywordPopupDelegate: class {
    func saveKeywords(_ keywords: [KeywordModel])
}

class BottomKeywordPopup: UIViewController {
    
    private var keywords: [KeywordModel] = [] {
        didSet {
            collectionView.reloadData()
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.layoutSubviews()
        }
    }
    
    weak var delegate: BottomKeywordPopupDelegate!
    
    // MARK: - Outlets
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var containViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Configure
    fileprivate func configure() {
        configureContainView()
        configureCollectionView()
        configureTitleLabel()
        configureDismissButton()
        configureConstraints()
    }
    
    fileprivate func configureCollectionView() {
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
    
    fileprivate func configureTitleLabel() {
        self.titleLabel.textColor = .black
        self.titleLabel.text = "Add/remove keywords to your keyword list by select/ deselect keywords below."
    }
    
    fileprivate func configureDismissButton() {
        self.saveButton.backgroundColor = Colors.mustard
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.saveButton.clipsToBounds = true
        self.saveButton.layer.cornerRadius = 10.0
    }
    
    fileprivate func configureConstraints() {
        self.containViewHeightConstraint.constant = Screen.Width == 320.0 ?  320.0 : 280.0
        UIView.animate(withDuration: 0.01) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func configureContainView() {
        self.containView.backgroundColor = .white
        self.containView.roundCorners([.topLeft, .topRight], radius: 25.0)
        
        self.view.backgroundColor = .white
        self.view.roundCorners([.topLeft, .topRight], radius: 25.0)
    }
    
    // MARK: - Fetch
    func fetchKeywordsFromLocalDB() {
        CoreDataManager.shared.fetchAllKeywords { (results) in
            var keys: [KeywordModel] = []
            for item in results {
                guard let keyword = item.keyword else { return }
                let key = KeywordModel(keyword: keyword, isSelected: item.isSelected)
                keys.append(key)
            }
            self.keywords = keys
        }
    }
    
    // MARK: - Action
    @IBAction func doneButtonTapped(_ sender: Any?) {
        self.delegate.saveKeywords(self.keywords)
    }
}

extension BottomKeywordPopup : UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: KeywordCell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.Identifier, for: indexPath) as? KeywordCell   {
            let item: KeywordModel = keywords[indexPath.row]
            cell.configure(with: item)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension BottomKeywordPopup: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.keywords[indexPath.row].isSelected = !self.keywords[indexPath.row].isSelected
        self.collectionView.reloadItems(at: [indexPath])
    }
}
