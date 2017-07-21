//
//  ArticleModel.swift
//  RSSFun
//
//  Created by Thien Chu on 7/21/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import Mapper


struct ArticleModel: Mappable {
    var title: String
    var description: String
    var link: String
    var pubDate: String
    var coverURL: String?
    
    init(map: Mapper) throws {
        title = try map.from("title")
        description = try map.from("description")
        link = try map.from("link")
        pubDate = try map.from("pubDate")
        coverURL = try? map.from("url")
    }
}
