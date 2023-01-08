import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    var FollowerAction: (() -> ())?
    var FollowingAction: (() -> ())?
    
    // MARK: - Outlet
    @IBOutlet weak var AvatarImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var FollowerCountLabel: UILabel!
    @IBOutlet weak var FollowingCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Function
    func config(user: User) {
        let FollowersGesture = UITapGestureRecognizer(target: self, action: #selector(FollowersTapped))
        FollowerCountLabel.addGestureRecognizer(FollowersGesture)
        let FollowingGesture = UITapGestureRecognizer(target: self, action: #selector(FollowingTapped))
        FollowingCountLabel.addGestureRecognizer(FollowingGesture)
        
        if let description = user.description {
            DescriptionLabel.text = "Description: \(description)"
        }
        if let name = user.name {
            NameLabel.text = "Name: \(name)"
        }
        if let userName = user.userName {
            UserNameLabel.text = "User Name: \(userName)"
        }
        AvatarImageView.layer.cornerRadius = AvatarImageView.frame.width / 2
        AvatarImageView.image = user.userImage
        
        if let followingCount = user.following?.count {
            FollowingCountLabel.text = "\(followingCount) Following"
        }
        
        if let followerCount = user.follower?.count {
            FollowerCountLabel.text = "\(followerCount) Followers"
        }
    }
    @objc func FollowersTapped() {
        if let action = FollowerAction {
            action()
        }
    }
    @objc func FollowingTapped() {
        if let action = FollowingAction {
             action()
        }
    }
}
