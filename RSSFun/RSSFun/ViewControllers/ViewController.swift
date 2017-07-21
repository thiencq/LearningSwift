//
//  ViewController.swift
//  RSSFun
//
//  Created by Thien Chu on 7/21/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var feedsList = [ArticleModel]()
    let parser = RSSParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadFeeds { [weak self] (feeds) in
            self?.feedsList = feeds
            self?.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let articleVC = segue.destination as? ArticleDetailViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
            articleVC.link = feedsList[indexPath.row].link
        }
    }

    fileprivate func loadFeeds(with completion: ((_ feedsList: [ArticleModel]) -> Void)?) {
        guard let url = URL(string: AppConfig.rssURL) else {
            return
        }
        
        parser.startParsing(withContentOf: url) { (isFinished) in
            let feeds = ArticleModel.from(self.parser.parsedData as NSArray) ?? []
            
            if let completion = completion {
                completion(feeds)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        
        if let articleCell = cell as? ArticleCell {
            articleCell.visualize(with: self.feedsList[indexPath.row])
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "presentArticleDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
