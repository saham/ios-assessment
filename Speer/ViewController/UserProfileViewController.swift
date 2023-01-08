import UIKit

class UserProfileViewController: UIViewController {
    
    // MARK: - Variables
    var user: User?
    
    // MARK: - Outlet
    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var FollowerCountLabel: UILabel!
    @IBOutlet weak var FollowingCountLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    // MARK: - Functions
    func config() {
        guard let user = user else {return}
        ProfileImageView.image = user.userImage
        if let description = user.description {
            DescriptionLabel.text = "Description: \(description)"
        }
        if let name = user.name {
            NameLabel.text = "Name: \(name)"
        }
        if let userName = user.userName {
            UserNameLabel.text = "User Name: \(userName)"
        }
        
        if let followerCount = user.follower?.count{
            FollowerCountLabel.text = "\(followerCount) Followers"
        }
        
        if let followingCount = user.following?.count{
            FollowingCountLabel.text = "\(followingCount) Following"
        }
        
    }
}
