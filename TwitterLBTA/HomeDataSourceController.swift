//
//  HomeDataSourceController.swift
//  TwitterLBTA
//
//  Created by Jesus Adolfo on 2/3/17.
//
//

import LBTAComponents
import TRON
import SwiftyJSON


class HomeDataSourceController: DatasourceController {
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView?.backgroundColor = .red
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        
        setupNavigationBarItems()
        
//        let homeDataSource = HomeDataSource()
//        self.datasource = homeDataSource
        
        fetchHomeFeed()
        
    }
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    class Home: JSONDecodable {
        
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
            self.users = users
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
    
    fileprivate func fetchHomeFeed(){
        //fetching JSON with TRON
        let request: APIRequest <HomeDataSource, JSONError> = tron.request("/twitter/home")
        
        request.perform(withSuccess: { (home) in
            print("Successfuly fetched our JSON :)")
            
            print(home.users.count)
        }) { (err) in
            print("We had an error fetching JSON :( ", err)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let user = self.datasource?.item(indexPath) as? User{
            //getting height estimation based on bioText
            let approximateWidthOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
            let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
            
            //font needs to be the same size as the calculated items font otherwise it won't work..
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15) ]
            
            let estimatedFrame = NSString(string: user.bioText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil )
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 66)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 64)
    }
    
}
