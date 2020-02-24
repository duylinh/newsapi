//
//  KeywordCell.swift
//  News
//
//  Created by Tran Duy Linh on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

class KeywordCell: UICollectionViewCell {
    
    static let Identifier: String = "KeywordCell"
    
    @IBOutlet var roundedView: RoundedView!
    @IBOutlet var checkImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func configure(with item: KeywordModel) {
        self.backgroundColor = .white
        
        let tintColor: UIColor = .black
        
        self.roundedView.backgroundColor = Colors.paleGrey
        self.roundedView.borderColor = Colors.navyBlueTwo
        self.roundedView.borderWidth = 0.4
        
        self.checkImageView.image = item.isSelected ?
            UIImage(named: "ic_check_dark_on")?.tint(with: tintColor)
            : UIImage(named: "ic_check_dark_off")
        
        self.titleLabel.text = item.keyword
        self.titleLabel.textColor = .black
    }
}
