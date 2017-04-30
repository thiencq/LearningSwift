//
//  UserProfile.swift
//  InstagramClient
//
//  Created by Thien Chu on 4/30/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import Mapper

struct UserProfile: Mappable {
    let username: String
    let profilePicture: String
    let fullName: String
    
    init(map: Mapper) throws {
        try username = map.from("username")
        try profilePicture = map.from("profile_picture")
        try fullName = map.from("full_name")
    }
}
