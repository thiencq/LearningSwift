//
//  Config.swift
//  InstagramClient
//
//  Created by Thien Chu on 4/22/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit

struct Config {
    struct APIEndpoint {
        static let oauthURL = "https://api.instagram.com/oauth/authorize/"
        static let userURL = "https://api.instagram.com/v1/users"
    }
    
    struct Credential {
        static let clientID = "ecb2ba4ba8f94503987ee60122711e72"
        static let clientSecret = "503c665841f9463da85e34941c85c842"
        static let redirectURL = "https://www.instagram.com/"
        static let scope = "likes+comments+relationships+follower_list"
    }
    
    struct StoryboardFlow {
        static let presentFollowersVC = "presentFollowersVC"
    }
}

extension UserDefaults {
    struct Keys {
        private init() {}
        
        static let accessToken = "accessToken"
    }
    
    var accessToken: String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: UserDefaults.Keys.accessToken) as? String
    }
    
    func set(accessToken: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(accessToken, forKey: UserDefaults.Keys.accessToken)
    }
}
