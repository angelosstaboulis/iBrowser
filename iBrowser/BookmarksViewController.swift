//
//  BookmarksViewController.swift
//  iBrowser
//
//  Created by Angelos Staboulis on 14/1/24.
//

import UIKit
import CoreData
class BookmarksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    func fetchBookmarks()->[NSFetchRequestResult]{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        var objects:[NSFetchRequestResult] = []
        do{
            let requests = iBrowser.Bookmarks.fetchRequest()
            objects = try context.fetch(requests)
           
        }catch{
            debugPrint("something went wrong!!!!!")
        }
        return objects
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchBookmarks().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let items = fetchBookmarks() as! [iBrowser.Bookmarks]
        if indexPath.row < items.count  {
            cell.textLabel!.text =  items[indexPath.row].url
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if UIApplication.shared.canOpenURL(URL(string:(cell?.textLabel!.text!)! )!) {
            UIApplication.shared.open(URL(string:(cell?.textLabel!.text!)! )!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBookmarkTable()

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
extension BookmarksViewController{
    func setupBookmarkTable(){
        self.navigationItem.title = "Bookmarks"
        tableView.delegate = self
        tableView.dataSource = self
    }
}
