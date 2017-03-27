//
//  FlickRConstant.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/27/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation

extension FlickRClient{
    
    struct Constants {
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "/services/rest"
        
        static let SearchBBoxHalfWidth = 1.0
        static let SearchBBoxHalfHeight = 1.0
        static let SearchLatRange = (-90.0, 90.0)
        static let SearchLonRange = (-180.0, 180.0)
    }
    
}
