//
//  ViewController.swift
//  week11_lab2
//
//  Created by Jason on 2019-11-20.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      // [START auth_listener]
      handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        // [START_EXCLUDE]
       // self.setTitleDisplay(user)
        //self.tableView.reloadData()
        // [END_EXCLUDE]
      }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // [START remove_auth_listener]
       Auth.auth().removeStateDidChangeListener(handle!)
       // [END remove_auth_listener]
     }

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var textStatus: UILabel!
    @IBAction func signuoButton(_ sender: Any) {
        guard let email = self.emailField.text, let password = self.passwordField.text else
        {
            self.textStatus.text = "email/password can't be empty"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
                 // [START_EXCLUDE]
                   guard let user = authResult?.user, error == nil else {
                    self.textStatus.text = error!.localizedDescription
                     return
                   }
            let strMessage = "\(user.email!) created"
            self.textStatus.text = strMessage
            print(strMessage)
                 
                 // [END_EXCLUDE]
               }
        }
    

    
    @IBAction func loginButton(sender: AnyObject) {
        guard let email = self.emailField.text, let password = self.passwordField.text else
        {
            self.textStatus.text = "email/password can't be empty"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // [START_EXCLUDE]
            if let error = error {
                self?.textStatus.text = "Login failed"
              return
            }
           else
            {
                self?.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
    
    
}

