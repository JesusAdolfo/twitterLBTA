//
//  Service.swift
//  TwitterLBTA
//
//  Created by Jesus Adolfo on 2/8/17.
//
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")

    static let sharedInstance = Service()
    
    
    //fetching JSON with TRON
    func fetchHomeFeed(completion: @escaping (HomeDataSource) -> ()){
        print("Fetching home feed")
        let request: APIRequest <HomeDataSource, JSONError> = tron.request("/twitter/home")
        
        
        
        request.perform(withSuccess: { (homeDataSource) in
            print("Successfuly fetched our JSON :)")
            completion(homeDataSource)
        }) { (err) in
            print("We had an error fetching JSON :( ", err)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
}
