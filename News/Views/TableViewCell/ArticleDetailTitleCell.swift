//
//  ArticleDetailTitleCell.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

class ArticleDetailTitleCell: UITableViewCell, ImageDownloaderDelegate {
    
    // MARK: - Vars
    static let Identifier = "ArticleDetailTitleCell"
    
    static var nib: UINib {
        return UINib(nibName: Identifier, bundle: nil )
    }
    
    static var height: CGFloat {
        return 200.0
    }
    
    var imageDownloader: ImageDownloader?

    // MARK: - Outlets
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Configure
    func configure(_ article: ArticleModel?) {
        guard let article = article else { return }
        titleLabel.text = article.title
        sourceLabel.text = article.source?.name
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
