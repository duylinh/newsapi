//
//  ArticleCell.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell, ImageDownloaderDelegate {

    // MARK: - Vars
    static let Identifier = "ArticleCell"
    
    static var nib: UINib {
        return UINib(nibName: Identifier, bundle: nil )
    }
    
    static var height: CGFloat {
        return 150.0
    }
    var imageDownloader: ImageDownloader?
    
    // MARK: IBOutlets
    
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = defaultBackgroundColor
        self.contentView.backgroundColor = defaultBackgroundColor
        self.articleImageView.layer.cornerRadius = CGFloat(8)
    }
    
    // MARK: - Configure
    func configure(_ article: ArticleModel) {
        nameLabel.text = article.title
        descriptionLabel.text = article.description
        articleImageView.image = UIImage(named: "no_image")
        if let url = URL(string: article.urlToImage ?? "") {
            self.imageDownloader = ImageDownloader(imageURL: url)
            self.imageDownloader?.delegate = self
            self.imageDownloader?.downloadImage()
        }

    }
    
    func didFinishDownloading(_ sender: ImageDownloader) {
        articleImageView.image = imageDownloader?.image
    }

}
