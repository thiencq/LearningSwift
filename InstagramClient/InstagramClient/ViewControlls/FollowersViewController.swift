//
//  FollowersViewController.swift
//  InstagramClient
//
//  Created by Thien Chu on 4/30/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import Alamofire

class FollowersViewController: UIViewController {

    @IBOutlet weak var followersTableView: UITableView!
    
    var profileList = [UserProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getFollowers { (profileList) in
            self.profileList = profileList ?? []
            DispatchQueue.main.async {
                self.followersTableView .reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getFollowers(with completion: @escaping ((_ followers: [UserProfile]?) -> Void)) {
        let userDefault = UserDefaults.standard
        guard
            let accessToken = userDefault.accessToken,
            let url = URL(string: String(format: "%@/self/followed-by?access_token=%@", Config.APIEndpoint.userURL, accessToken)) else {
                completion(nil)
                return
        }
        
        Alamofire
            .request(url, method: .get)
            .responseJSON { (response) in
                guard
                    let value = response.result.value as? [String: Any],
                    let data = value["data"] as? [[String: Any]] else {
                        completion(nil)
                        return
                }
                
                completion(UserProfile.from(data as NSArray))
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FollowersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerCell", for: indexPath)
        
        if let cell = cell as? FollowerCell {
            cell.visualize(with: profileList[indexPath.row])
        }
        
        return cell
    }
}
