//
//  ArticleCell.swift
//  RSSFun
//
//  Created by Thien Chu on 7/21/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func visualize(with article: ArticleModel) {
        if  let coverURL = article.coverURL,
            let url = URL(string: coverURL) {
            coverImageView.af_setImage(withURL: url)
        }
        titleLabel.text = article.title
        descriptionLabel.text = article.pubDate
    }
}
