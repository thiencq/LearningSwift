//
//  RSSParser.swift
//  RSSFun
//
//  Created by Thien Chu on 7/21/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit

class RSSParser: NSObject {
    // MARK: Class's properties
    var xmlParser: XMLParser!
    var currentElement = ""
    var foundCharacters = ""
    var currentData = [String:String]()
    var parsedData = [[String:String]]()
    var isHeader = true
    
    func startParsing(withContentOf url: URL, andCompletion completion: ((Bool) -> Void)?) {
        let parser = XMLParser(contentsOf: url)
        
        parser?.delegate = self
        
        if let flag = parser?.parse() {
            parsedData.append(currentData)
            if let completion = completion {
                completion(flag)
            }
        }
    }
}

extension RSSParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        // news items start at <item> tag, we're not interested in header
        if currentElement == "item" || currentElement == "entry" {
            // at this point we're working with n+1 entry
            if isHeader == false {
                parsedData.append(currentData)
            }
            
            isHeader = false
            
        }
        
        if isHeader == false {
            // handle article thumbnails
            if currentElement == "media:thumbnail" || currentElement == "media:content" {
                foundCharacters += attributeDict["url"] ?? ""
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isHeader == false {
            if currentElement == "title" || currentElement == "link" || currentElement == "description" || currentElement == "content" || currentElement == "pubDate" || currentElement == "author" || currentElement == "dc:creator" || currentElement == "content:encoded" {
                
                foundCharacters += string
                
//                foundCharacters = foundCharacters.deleteHTML(tags: ["a", "p", "div", "img"])
                
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard !foundCharacters.isEmpty else {
            return
        }
        
        foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
        currentData[currentElement] = foundCharacters
        foundCharacters = ""
    }
}

