//
//  HomeViewController.swift
//  projectlab
//
//  Created by Kendra Arsena Wijaya on 08/12/20.
//

import UIKit
import CoreData

struct news{
    var title:String?
    var content:String?
    var writer:String?
    var publishDate:String?
    var image:UIImage?
}

var arrNews = [News]()

class Table: UITableViewCell{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    var onUpdateHandler = {}
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var lblWelcome: UILabel!
    
    var cellnum:Int?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Table
        cell.title.text = arrNews[indexPath.row].title
        cell.desc.text = arrNews[indexPath.row].content
        cell.thumbnail.image = UIImage(data: arrNews[indexPath.row].image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cellnum = indexPath.row
        performSegue(withIdentifier: "read", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteData(indexPath: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "read" {
            let dest = segue.destination as! ReadViewController
            dest.newstitle = arrNews[cellnum!].title
            dest.writer = arrNews[cellnum!].writer
            dest.content = arrNews[cellnum!].content
            dest.publish = arrNews[cellnum!].publishDate
            dest.thumbnail = arrNews[cellnum!].image
            dest.index = cellnum
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblWelcome.text = welcome
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext

        // Do any additional setup after loading the view.
//        loadData()
        arrNews = loadData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: self)
    }
    
//    func loadData(){
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
//        arrNews.removeAll()
//        do {
//            let results = try context.fetch(request) as! [NSManagedObject]
//            for data in results{
//                arrNews.append(news(title: (data.value(forKey: "title") as! String), content: (data.value(forKey: "content") as! String), writer: (data.value(forKey: "writer") as! String), publishDate: (data.value(forKey: "publishDate") as! String), image: UIImage(data: )))
//            }
//            tableView.reloadData()
//        }
//        catch {
//
//        }
//    }
    
    func loadData() -> [News] {
        var arr = [News]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        do {
            arr = try context.fetch(request) as! [News]
        } catch {
            print("fetch failed")
        }
        return arr
    }
    
    func deleteData(indexPath: IndexPath) {
        let title = arrNews[indexPath.row].title
        let requests = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        requests.predicate = NSPredicate(format: "title==%@", title!)
        
        do {
            let results = try context.fetch(requests) as! [NSManagedObject]
            for data in results {
                context.delete(data)
            }
            try context.save()
            arrNews = loadData()
            tableView.reloadData()
        } catch {
            print("delete failed")
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
