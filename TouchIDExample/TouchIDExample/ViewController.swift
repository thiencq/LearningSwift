//
//  ViewController.swift
//  TouchIDExample
//
//  Created by Thien Chu on 4/13/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit
import LocalAuthentication


class ViewController: UIViewController {
    
    let context = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func useTouchIDButtonDidTouched(_ sender: Any) {
        var error:NSError?
        
        // Check if device support Touch ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            // Hide "Enter Password" option
            context.localizedFallbackTitle = ""
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Touch ID usage description", reply: { (success, error) in
                if let error = error {
                    self.showError(with: error.localizedDescription)
                    return
                }
                
                // Touch ID verified
                /*
                 * This callback block in another thread, you must update UI in the main thread
                */
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "presentSecondVC", sender: nil)
                }
            })
        }
        else {
            /* Device doesn't support Touch ID
             * or the device reach max limit retry
             */
            showError(with: error?.localizedDescription)
        }
    }
    
    func showError(with message:String?) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

