//
//  page2.swift
//  week11_lab2
//
//  Created by Jason on 2019-11-22.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class page2: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
    
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var ageText: UITextField!
    
    @IBAction func addinfomation(_ sender: UIButton) {
        let ref = Database.database().reference()
        ref.childByAutoId().setValue(["username": nameText.text!, "userage": ageText.text!,])

    }

    
    
    
    
}
