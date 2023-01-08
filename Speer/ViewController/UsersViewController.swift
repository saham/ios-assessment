import UIKit

class UsersViewController: UIViewController {
    
    // MARK: - Variables
    var AllUsers: [User] = [] // These could be optional but for simplicity, an empty array is used
    var FilteredUsers: [User] = [] // These could be optional but for simplicity, an empty array is used
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        AllUsers = getAllUsers()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "NotFoundTableViewCell", bundle: nil), forCellReuseIdentifier: "NotFoundCell")
        tableView.separatorStyle = .singleLine
        
    }
}
// MARK: - Functions
func loadJson(fromURLString urlString: String,
                      completion: @escaping ([User]?, Error?) -> Void) {
    // This method will be used if we want to fetch JSON from URL
    if let url = URL(string: urlString) {
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            
            if let data = data {
                let json = try! JSONDecoder().decode([User].self, from: data)
                completion(json, nil)
            }
        }
        
        urlSession.resume()
    }
}
func getAllUsers()->[User] {
    // No URL was given to fetch user. Therefore, I created Users.json and data is read from the local file
    // It's assumed JSON file has no error try! is used.
    // do block is not used
    if let path = Bundle.main.path(forResource: "Users", ofType: "json"), let data = NSData(contentsOfFile: path) as? Data {
            return try! JSONDecoder().decode([User].self, from: data)
    }
    return [User]()
}
// MARK: - TableView
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let text = searchBar.text, text.isEmpty || !FilteredUsers.isEmpty  {
            // We navigate when search is not initiated OR search result is not empty
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let DVC = storyboard.instantiateViewController(withIdentifier: "userProfileVC") as? UserProfileViewController {
                DVC.user = FilteredUsers.count > 0 ? FilteredUsers[indexPath.row] : AllUsers[indexPath.row]
                navigationController?.pushViewController(DVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let text = searchBar.text, text.isEmpty {
            return AllUsers.count
        } else if FilteredUsers.count == 0 {
            // User has searched but no result found
            return 1
        }else {
            return FilteredUsers.isEmpty ? AllUsers.count : FilteredUsers.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let text = searchBar.text, !text.isEmpty, FilteredUsers.isEmpty {
            // We show Not Found if user is searching but no result is shown
            // When App starts FilteredUser is empty but user has not searched
            // We do not want to show "Not Found" view
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotFoundCell", for: indexPath) as! NotFoundTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
            let user = FilteredUsers.isEmpty  ? AllUsers[indexPath.row] : FilteredUsers[indexPath.row]
            cell.config(user: user)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            cell.FollowingAction = {
                if let DVC = storyboard.instantiateViewController(withIdentifier: "FollowingFollowerVC") as? FollowingFollowerViewController {
                    DVC.users = user.following ?? []
                    self.navigationController?.pushViewController(DVC, animated: true)
                }
            }
            cell.FollowerAction = {
                if let DVC = storyboard.instantiateViewController(withIdentifier: "FollowingFollowerVC") as? FollowingFollowerViewController {
                    DVC.users = user.follower ?? []
                    self.navigationController?.pushViewController(DVC, animated: true)
                }
            }
            
            return cell
        }
       
    }
}
extension UsersViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text{
            FilteredUsers = AllUsers.filter({$0.name?.contains(searchText) ?? false })
        }
        tableView.reloadData()
    }
}
