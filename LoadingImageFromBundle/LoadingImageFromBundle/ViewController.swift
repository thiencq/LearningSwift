//
//  ViewController.swift
//  LoadingImageFromBundle
//
//  Created by Thien Chu on 4/1/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let imageListViewController = segue.destination as? ImageListViewController else {
            return
        }
        
        if segue.identifier == "imageNamed" {
            imageListViewController.imageType = .imageNamed
        }
        else if segue.identifier == "contentOfFile" {
            imageListViewController.imageType = .contentOfFile
        }
    }

}

