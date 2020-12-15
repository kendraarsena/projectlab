//
//  EditViewController.swift
//  projectlab
//
//  Created by Kendra Arsena on 11/12/20.
//

import UIKit
import CoreData

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContent: UITextField!
    @IBOutlet weak var txtPublish: UITextField!
    @IBOutlet weak var txtWriter: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var newstitle:String?
    var content:String?
    var publish:String?
    var writer:String?
    var thumbnail: Data?
    var index:Int?
    
    let datePicker = UIDatePicker()
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtWriter.text = writer
        txtTitle.text = newstitle
        txtPublish.text = publish
        txtContent.text = content
        image.image = UIImage(data: thumbnail!)
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        createDatePicker()
    }
    
    func updateData(){
        let oldTitle = arrNews[index!].title
        let newTitle = txtTitle.text!
        let newContent = txtContent.text!
        let newPublish = txtPublish.text!
        let newWriter = txtWriter.text!
        let newImage = self.image.image?.pngData()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        request.predicate = NSPredicate(format: "title==%@", oldTitle!)
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            for data in results {
                data.setValue(newTitle, forKey: "title")
                data.setValue(newWriter, forKey: "writer")
                data.setValue(newContent, forKey: "content")
                data.setValue(newPublish, forKey: "publishDate")
                data.setValue(newImage, forKey: "image")
            }
            
            try context.save()
        } catch {
            print("update failed")
        }
    }
    
    @IBAction func btnUpload(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        
        image.image = userPickedImage
        picker.dismiss(animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if (txtTitle.text!.isEmpty || txtContent.text!.isEmpty || txtPublish.text!.isEmpty || txtWriter.text!.isEmpty) {
            
        }
        else {
            updateData()
            performSegue(withIdentifier: "updated", sender: self)
        }
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        let title = arrNews[index!].title
        let requests = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        requests.predicate = NSPredicate(format: "title==%@", title!)
        
        do {
            let results = try context.fetch(requests) as! [NSManagedObject]
            for data in results {
                context.delete(data)
            }
            try context.save()
            performSegue(withIdentifier: "updated", sender: self)
        } catch {
            print("delete failed")
        }
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        toolbar.setItems([doneBtn], animated: true)
        
        txtPublish.inputAccessoryView = toolbar
        txtPublish.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    @objc func done(){
        let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .none
        
        txtPublish.text = format.string(from: datePicker.date)
        self.view.endEditing(true)
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
