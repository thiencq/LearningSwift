//
//  Utilities.swift
//  RSSFun
//
//  Created by Thien Chu on 7/21/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func extractMatches(for tag: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: "(?i)</?\(tag)\\b[^<]*>")
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteHTML(tag: String) -> String {
        return self.replacingOccurrences(of: "(?i)</?\(tag)\\b[^<]*>", with: "", options: .regularExpression, range: nil)
    }
    
    func deleteHTML(tags: [String]) -> String {
        var mutableString = self
        for tag in tags {
            mutableString = mutableString.deleteHTML(tag: tag)
        }
        return mutableString
    }
}
