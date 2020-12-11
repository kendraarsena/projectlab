//
//  ReadViewController.swift
//  projectlab
//
//  Created by Kendra Arsena on 11/12/20.
//

import UIKit

class ReadViewController: UIViewController {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblPublish: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    var newstitle:String?
    var content:String?
    var publish:String?
    var writer:String?
    var index:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = newstitle
        lblPublish.text = publish
        lblContent.text = content
        lblWriter.text = writer
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            let dest = segue.destination as! EditViewController
            dest.newstitle = newstitle
            dest.content = content
            dest.publish = publish
            dest.writer = writer
            dest.index = index!
        }
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
