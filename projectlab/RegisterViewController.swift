//
//  RegisterViewController.swift
//  projectlab
//
//  Created by Kendra Arsena Wijaya on 08/12/20.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        let username = txtUsername.text!
        let password = txtPassword.text!
        let email = txtEmail.text!
        let phone = txtPhone.text!
        
        if (username.isEmpty || password.isEmpty || email.isEmpty || phone.isEmpty) {
            showAlert(title: "Error", message: "All fields must be filled!")
        } else if (username.count < 4 || username.count > 12) {
            showAlert(title: "Error", message: "Username length between 4 and 12")
        } else if (password.count < 4 || password.count > 12) {
            showAlert(title: "Error", message: "Password length between 4 and 12")
        } else if (!email.contains("@") || !email.hasSuffix(".com")) {
            showAlert(title: "Error", message: "Email must contains @ and ends with .com")
        } else if (phone.count != 12) {
            showAlert(title: "Error", message: "Phone number must be 12 digits")
        } else {
            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.synchronize()
            performSegue(withIdentifier: "login", sender: self)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
