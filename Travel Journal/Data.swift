//
//  Data.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/22/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

struct venue{
    
    var name: String?
    var contact: Dictionary<String, Any>?
    var location: Dictionary<String, Any>?
    var categories: Dictionary<String, Any>?
    var url: String?
    
    static var venuet: [venue] = []
    
    static var venueDictionary: [[String: Any]] = []
    
    init(dictionary: [String: Any]){
        
        name = dictionary["name"] as? String
        contact = dictionary["contact"] as? Dictionary
        location = dictionary["location"] as? Dictionary
        categories = dictionary["categories"] as? Dictionary
        url = dictionary["url"] as? String
        
    }
    
    static func venues(results: [[String: Any]]) -> [venue]{
        
        var data = [venue]()
        
        for result in results{
            data.append(venue(dictionary: result))
        }
        
        return data
    }
    
}
