import UIKit

class FollowingFollowerViewController: UIViewController {
    // MARK: - Variables
    var users: [User] = []
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

// MARK: - TableView
extension FollowingFollowerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        cell.config(user: user)
        cell.accessoryType = .none
        return cell
    }
    
    
}
