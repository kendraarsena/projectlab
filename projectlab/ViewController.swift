//
//  ViewController.swift
//  projectlab
//
//  Created by Kendra Arsena Wijaya on 08/12/20.
//

import UIKit

var welcome:String = ""

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
        let usernameStored = UserDefaults.standard.string(forKey: "username")
        let passwordStored = UserDefaults.standard.string(forKey: "password")
        
        if((txtUsername.text!.isEmpty) || (txtPassword.text!.isEmpty)){
            showAlert(title: "Error", message: "All fields must be filled!")
        }
        else if((txtUsername.text! != usernameStored) || (txtPassword.text! != passwordStored)){
            showAlert(title: "Error", message: "Username / Password is incorrect")
        }
        else{
            welcome = "Welcome, \(txtUsername.text as! String)"
            performSegue(withIdentifier: "home", sender: self)
        }
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        performSegue(withIdentifier: "register", sender: self)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

