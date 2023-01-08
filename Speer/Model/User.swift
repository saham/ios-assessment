import Foundation
import UIKit
class User:Codable {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatarUrl"
        case userName = "userName"
        case name = "name"
        case description = "description"
        case following = "following"
        case follower = "follower"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        userName = try container.decodeIfPresent(String.self, forKey: .userName)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        following = try container.decodeIfPresent([User].self, forKey: .following)
        follower = try container.decodeIfPresent([User].self, forKey: .follower)
        // We fetch User image as early as possible such that the image can be used on multiple screens
        downloadImage()
    }
    var avatarUrl: String?
    var userName: String?
    var name: String?
    var description: String?
    var following: [User]?
    var follower: [User]?
    var userImage: UIImage?
    func downloadImage() {
        // This added to prevent loading an image from a the URL every time we need it
        if let urlString = self.avatarUrl, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
              guard let imageData = data else { return }
                self.userImage = UIImage(data: imageData)
            }.resume()
          }
    }
}
