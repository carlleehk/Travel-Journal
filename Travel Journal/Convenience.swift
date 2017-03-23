//
//  Convenience.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/22/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation

extension FourSquareClient{
    
    func getVenue(lat: Double?, long: Double?, searchString: String?, completionHandlerForGetVenue:@escaping (_ result: [venue]?, _ error: NSError?) -> Void){
        
        let parameters: [String: String]
        
        if searchString == nil {
            parameters = [ParameterKeys.longlat: "\(lat!),\(long!)", ParameterKeys.limit: "50", ParameterKeys.clientID: Constant.ClientID, ParameterKeys.clientSecret: Constant.ClientSecret, ParameterKeys.version: Constant.version]
        } else{
            parameters = [ParameterKeys.near: searchString!, ParameterKeys.limit: "50", ParameterKeys.clientID: Constant.ClientID, ParameterKeys.clientSecret: Constant.ClientSecret, ParameterKeys.version: Constant.version]
        }
        
        taskForGetMethod(parameters: parameters as [String : AnyObject]) { (results, error) in
            if let error = error{
                completionHandlerForGetVenue(nil, error)
            } else{
                guard let info = results?["response"]! as? [String: Any], let venues = info["venues"] as? [[String: Any]] else{
                    print("... \(error?.localizedDescription)")
                    return
                }
                
                let data = venue.venues(results: venues)
                venue.venuet = data
                completionHandlerForGetVenue(data, nil)
            }
            
        }
    }
    
}
