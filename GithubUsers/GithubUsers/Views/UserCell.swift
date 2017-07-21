//
//  UserCell.swift
//  GithubUsers
//
//  Created by Thien Chu on 7/20/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import AlamofireImage

class UserCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func visualize(with user: UserProfile) {
        if let url = URL(string: user.avatarURL) {
            avatarImageView.af_setImage(withURL: url)
        }
        
        titleLabel.text = user.login
        typeLabel.text = user.type
    }
}
