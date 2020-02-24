//
//  ProfileViewDataSource.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable all

final class ProfileViewDataSource: NSObject {
    
    // MARK: - Properties
    
    private unowned let viewModel: ProfileViewModel

    // MARK: - Con(De)structor
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Internal methods
    
    func configure(with collectionView: UICollectionView) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.roundCorners(.allCorners, radius: 8.0)
        
        let flowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        flowLayout.itemSize = CGSize(width: 155, height: 40)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.estimatedItemSize = CGSize(width: 155, height: 40)
        collectionView.collectionViewLayout = flowLayout
    }
}

extension ProfileViewDataSource : UICollectionViewDataSource {
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

extension ProfileViewDataSource: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.updateKeywords(with: indexPath)
    }
}
