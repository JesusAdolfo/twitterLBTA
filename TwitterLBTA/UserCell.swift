//
//  UserCell.swift
//  TwitterLBTA
//
//  Created by Jesus Adolfo on 2/3/17.
//
//

import LBTAComponents

class UserCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet{
            guard let user = datasourceItem as? User else { return }
            nameLabel.text = user.name
            usernameLabel.text = user.username
            bioTextView.text = user.bioText
            profileImageView.image = user.profileImage
        }
    }
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "chaplin")
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Charles Chaplin"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //        label.backgroundColor = .green
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@chaplin"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        //        label.backgroundColor = .purple
        return label
    }()
    
    let bioTextView : UITextView = {
        let textView = UITextView()
        textView.text = "Ribeye shoulder shankle cow jerky meatloaf. Ribeye turkey strip steak, kielbasa ball tip corned beef frankfurter shoulder porchetta bacon."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .clear
        //        textView.backgroundColor = .orange
        return textView
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = twitterBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(twitterBlue, for: .normal)
        button.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        //        button.backgroundColor = .cyan
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        //        backgroundColor = .yellow
        backgroundColor = .white
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        nameLabel.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right:  followButton.leftAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        usernameLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        bioTextView.anchor(usernameLabel.bottomAnchor, left: usernameLabel.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: -4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        followButton.anchor(topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120, heightConstant: 34)
        
        
        
    }
    
    
}

