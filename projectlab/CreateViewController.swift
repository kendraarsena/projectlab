//
//  CreateViewController.swift
//  projectlab
//
//  Created by Natalia Fellyana on 08/12/20.
//

import Foundation
import UIKit
import CoreData

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContent: UITextField!
    @IBOutlet weak var txtPublish: UITextField!
    @IBOutlet weak var txtWriter: UITextField!
    @IBOutlet weak var img: UIImageView!
    
    var context:NSManagedObjectContext!
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
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
        
        img.image = userPickedImage
        picker.dismiss(animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let title = txtTitle.text!
        let content = txtContent.text!
        let publish = txtPublish.text!
        let writer = txtWriter.text!
        
        if (title.isEmpty || content.isEmpty || publish.isEmpty || writer.isEmpty) {
            showAlert(title: "Error", message: "All Field must be Filled")
        }
        else {
            if let image = img.image?.pngData(){
                saveData(at: image)
                performSegue(withIdentifier: "save", sender: self)
            }
            else{
                showAlert(title: "Error", message: "Choose photo")
            }
        }
    }
    
    func saveData(at image: Data){
        let title = txtTitle.text!
        let content = txtContent.text!
        let publish = txtPublish.text!
        let writer = txtWriter.text!
        
//        let entity = NSEntityDescription.entity(forEntityName: "News", in: context)
//        let addNews = NSManagedObject(entity: entity!, insertInto: context)
        let addNews = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as! News
        addNews.image = image
        addNews.title = title
        addNews.content = content
        addNews.writer = writer
        addNews.publishDate = publish

//        addNews.setValue(title, forKey: "title")
//        addNews.setValue(content, forKey: "content")
//        addNews.setValue(publish, forKey: "publishDate")
//        addNews.setValue(writer, forKey: "writer")
//        addNews.setValue(image, forKey: "image")
        
        do {
            try context.save()
        } catch {
            print("save failed")
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
