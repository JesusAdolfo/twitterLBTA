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
    
    let users: [User] = {
        let chaplinUser = User(name: "Chaplin", username: "@cchaplin", bioText: "I do not have much patience with a thing of beauty that must be explained to be understood. If it does need additional interpretation by someone other than the creator, then I question whether it has fulfilled its purpose.", profileImage: #imageLiteral(resourceName: "chaplin") )
        
        let einsteinUser = User(name: "Einstein", username: "@mc2", bioText: "imagination is more important than knowledge.The important thing is not to stop questioning. Curiosity has its own reason for existing.Anyone who has never made a mistake has never tried anything new. Anyone who has never made a mistake has never tried anything new Anyone who has never made a mistake has never tried anything new!", profileImage: #imageLiteral(resourceName: "einstein"))
        
        return [chaplinUser, einsteinUser]
    }()
    

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
