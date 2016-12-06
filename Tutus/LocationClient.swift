//
//  LocationClient.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LocationClient {
    
    init() {
        
    }
    
    var dict = [String : String]()
    
    func createLocation(completion: @escaping ((Dictionary<String,String>) -> Void)) {
        if dict["isEdit"] == "true" {
            print("editing location")
            let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
            let parameters: Parameters = ["location": ["event_id": currentEventObject.id, "description": self.dict["name"]! as String]]
            let urlForRequest = "https://riskmanapi.herokuapp.com/locations/" + self.dict["LocationId"]!
            
            Alamofire.request(urlForRequest, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
                
                let json = JSON(response.result.value!)
                
                completion(self.dict)
            }
        }
        else {
            print("creating location")
            let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
            let parameters: Parameters = ["location": ["event_id": currentEventObject.id, "description": self.dict["name"]! as String]]
            
            Alamofire.request("https://riskmanapi.herokuapp.com/locations", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
                
                let json = JSON(response.result.value!)
                
                completion(self.dict)
            }
        }
    }
    
    func setDict(diction: [String : String] , completion: @escaping (() -> Void)) {
        self.dict = diction
        completion()
    }
    
    
}

