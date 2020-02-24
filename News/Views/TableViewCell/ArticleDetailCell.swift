//
//  ArticleDetailCell.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

class ArticleDetailCell: UITableViewCell {

    // MARK: - Vars
    static let Identifier = "ArticleDetailCell"
    
    static var nib: UINib {
        return UINib(nibName: Identifier, bundle: nil )
    }
    
    static var height: CGFloat {
        return 300.0
    }
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Configure
    func configure(_ article: ArticleModel?) {
        guard let article = article else { return }
        descriptionLabel.text = article.description
        contentLabel.text = article.content
    }
}
