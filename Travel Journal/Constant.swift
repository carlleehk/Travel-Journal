//
//  Constant.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/22/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation

extension FourSquareClient{
    
    struct  Constant {
        
        static let ApiScheme = "https"
        static let ApiHost = "api.foursquare.com"
        static let ApiPath = "/v2"
        static let ClientID = "AAIAEJFVA20B3TJ2ZINLYJWTNN2GZIJJUOKZCWAWMIIANCCZ"
        static let ClientSecret = "QNPUUUC54NYORXHN40FBSSSOO23SEU1YNMSXYQEPTM2RBYKF"
        static let version = "20170320"
        
    }
    
    struct Methods {
        
        static let venues = "/venues/search"
        
    }
    
    struct ParameterKeys {
        
        static let clientID = "client_id"
        static let clientSecret = "client_secret"
        static let longlat = "ll"
        static let near = "near"
        static let limit = "limit"
        static let version = "v"
        
    }
    
    
}
