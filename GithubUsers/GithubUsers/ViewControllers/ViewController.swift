//
//  ViewController.swift
//  GithubUsers
//
//  Created by Thien Chu on 7/20/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import Marshal
import Alamofire


class ViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    var usersList = [UserProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUsersList(with completion: @escaping ((_ usersList: [UserProfile]?) -> Void)) {
        guard let url = URL(string: "https://api.github.com/users") else {
            return
        }
        
        Alamofire
            .request(url, method: .get)
            .responseJSON { (response) in
                guard
                    let usersArray = response.result.value as? [[String: Any]] else {
                        completion(nil)
                        return
                }
                
                let users = UserProfile.from(usersArray as NSArray)
                
                completion(users)
        }
    }

    @IBAction func fetchButtonDidTouch(_ sender: Any) {
        getUsersList { [weak self] (usersList) in
            guard
                let weakSelf = self,
                let users = usersList else {
                return
            }
            
            weakSelf.usersList = users
            weakSelf.usersTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        if let userCell = cell as? UserCell {
            userCell.visualize(with: usersList[indexPath.row])
        }
        
        return cell
    }
}
