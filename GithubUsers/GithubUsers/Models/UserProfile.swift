//
//  UserProfile.swift
//  GithubUsers
//
//  Created by Thien Chu on 7/20/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import Mapper


struct UserProfile: Mappable {
    var userID: Int
    var login: String
    var avatarURL: String
    var type: String
    var gravatarID: String?
    
    
    init(map: Mapper) throws {
        try userID = map.from("id")
        try login = map.from("login")
        try avatarURL = map.from("avatar_url")
        try type = map.from("type")
        try gravatarID = map.optionalFrom("gravatar_id")
    }
}
