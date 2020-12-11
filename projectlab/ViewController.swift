//
//  ViewController.swift
//  projectlab
//
//  Created by Kendra Arsena Wijaya on 08/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tes")
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
        performSegue(withIdentifier: "home", sender: self)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        performSegue(withIdentifier: "register", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

