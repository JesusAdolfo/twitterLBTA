//
//  HomeDataSource.swift
//  TwitterLBTA
//
//  Created by Jesus Adolfo on 2/3/17.
//
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDataSource: Datasource, JSONDecodable {
    
    let users: [User]
    
    required init(json: JSON) throws {
        print("Now ready to parse json! \n", json)
        
        
        var users = [User]()
        
        let array = json["users"].array
        for userJson in array! {
            
            let name = userJson["name"].stringValue
            let username = userJson["username"].stringValue
            let bio = userJson["bio"].stringValue
            
            let user = User(name: name, username: username, bioText: bio, profileImage: UIImage())
            
            users.append(user)
        }
        
        let tweetsJsonArray = json["tweets"].array
        for tweetJson in tweetsJsonArray! {
            let userJson = tweetJson["user"]
            
            let name = userJson["name"].stringValue
            let username = userJson["username"].stringValue
            let bio = userJson["bio"].stringValue
            
            let user = User(name: name, username: username, bioText: bio, profileImage: UIImage())
            let message = tweetJson["message"].stringValue
            
            let tweet = Tweet(user: user, message: message)
            
            print(tweet.user.username)
            
        }
        
        self.users = users
    }
    

    let words = ["cell1", "cell2", "cell3"]
    
    let tweets: [Tweet] = {
        let chaplinUser = User(name: "Chaplin", username: "@cchaplin", bioText: "I do not have much patience with a thing of beauty that must be explained to be understood. If it does need additional interpretation by someone other than the creator, then I question whether it has fulfilled its purpose.", profileImage: #imageLiteral(resourceName: "chaplin") )
        let tweet = Tweet(user: chaplinUser, message: "Tweet lol :). I do not have much patience with a thing of beauty that must be explained to be understood. If it does need additional interpretation by someone other than the creator, then I question whether it has fulfilled its purpose")
        
        let tweet2 = Tweet(user: chaplinUser, message: "And anotther tweet")
        return [tweet, tweet2]
    }()
    
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    //specify the cells to use
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        
        //if it is the second section
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        
        //if section is TweetCell
        if section == 1 {
            return tweets.count
        }
        //else
        return users.count
    }
}
