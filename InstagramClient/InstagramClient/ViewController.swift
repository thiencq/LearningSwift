//
//  ViewController.swift
//  InstagramClient
//
//  Created by Thien Chu on 4/22/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [Config.APIEndpoint.oauthURL, Config.Credential.clientID, Config.Credential.redirectURL, Config.Credential.scope])
        
        guard
            let url = URL(string: authURL) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else {
            return false
        }
        
        if url.absoluteString.contains("#access_token="){
            guard let accessToken = url.absoluteString.components(separatedBy: "#access_token=").last else {
                return false
            }
            print("Access Token: \(accessToken)")
            
            let userDefault = UserDefaults()
            userDefault.set(accessToken: accessToken)
            userDefault.synchronize()
            
            self.performSegue(withIdentifier: "presentFollowersVC", sender: nil)
            
            return false
        }
        
        return true
    }
}

