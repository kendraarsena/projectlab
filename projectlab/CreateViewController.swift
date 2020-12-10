//
//  CreateViewController.swift
//  projectlab
//
//  Created by Natalia Fellyana on 08/12/20.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var txtDueDate: UITextField!
    @IBOutlet weak var segAssigned: UISegmentedControl!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var segStatus: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (segAssigned.titleForSegment(at: segAssigned.selectedSegmentIndex) == "Me") {
            lblComment.isHidden = false
            txtComment.isHidden = false
            lblStatus.isHidden = false
            segStatus.isHidden = false
        } else {
            lblComment.isHidden = true
            txtComment.isHidden = true
            lblStatus.isHidden = true
            segStatus.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    func refresh(){
        
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
