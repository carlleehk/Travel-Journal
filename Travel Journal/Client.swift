//
//  Client.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/22/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import Foundation

class FourSquareClient: NSObject{
    
    var session = URLSession.shared
    
    override init() {
        super.init()
    }
    
    func taskForGetMethod(parameters: [String: AnyObject], completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask{
        
        
        let request = NSMutableURLRequest(url: foursquareURL(parameters: parameters, withPathExtension: FourSquareClient.Methods.venues) as URL)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            
            guard (error == nil) else{
                sendError(error: (error?.localizedDescription)!)
                return
            }
            
            guard let statcode = (response as? HTTPURLResponse)?.statusCode, statcode >= 200 && statcode <= 299 else{
                sendError(error: "Your request returned a status code other than 2XX.")
                return
            }
            
            guard let data = data else{
                sendError(error: "No data was returned by the request")
                return
            }
            
            self.convertDataWithCompletionHandler(data: data, completionHandlerForConverData: completionHandlerForGET)
            
        }
        
        task.resume()
        return task
        
    }
    
    func convertDataWithCompletionHandler(data: Data, completionHandlerForConverData: (_ result:AnyObject?, _ error: NSError?) -> Void){
        
        
        let parseData: Any
        
        do{
            parseData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

        } catch {
            print("error")
            return
        }
        
        completionHandlerForConverData(parseData as AnyObject?, nil)
        
    }
    
    
    private func foursquareURL(parameters: [String: AnyObject], withPathExtension: String? = nil) -> NSURL{
        
        let components = NSURLComponents()
        components.scheme = FourSquareClient.Constant.ApiScheme
        components.host = FourSquareClient.Constant.ApiHost
        components.path = FourSquareClient.Constant.ApiPath + (withPathExtension ?? "")
        components.queryItems = [NSURLQueryItem] () as [URLQueryItem]?
        
        for (key, value) in parameters{
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem as URLQueryItem)
        }
        print("the url is: \((components.url)!)")
        return components.url! as NSURL
        
    }
    
    class func sharedInstance() -> FourSquareClient {
        struct Singleton {
            static var sharedInstance = FourSquareClient()
        }
        return Singleton.sharedInstance
    }
    
    
}
