//
//  FollowerCell.swift
//  InstagramClient
//
//  Created by Thien Chu on 4/30/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import AlamofireImage

class FollowerCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func visualize(with profile: UserProfile) {
        nameLabel.text = profile.fullName
        if let url = URL(string:profile.profilePicture) {
            avatarImageView.af_setImage(withURL: url)
        }
    }
}
