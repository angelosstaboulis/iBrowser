//
//  BookmarksViewModel.swift
//  iBrowser
//
//  Created by Angelos Staboulis on 16/1/24.
//

import Foundation
import SwiftUI
import CoreData
class BookmarksViewModel{
    static let shared = BookmarksViewModel()
    private init(){}
    func getContext()->NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        return context
    }
    func addBookmark(webAddress:String){
        do{
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let bookmarks = iBrowser.Bookmarks(context: context)
            bookmarks.desc = "Bookmark" + webAddress
            bookmarks.url = webAddress
            try context.save()
            debugPrint("record saved")
        }catch{
            debugPrint("something went wrong!!!")
        }
    }
    func fetchBookmarks()->[NSFetchRequestResult]{
        var objects:[NSFetchRequestResult] = []
        do{
            let requests = iBrowser.Bookmarks.fetchRequest()
            objects = try getContext().fetch(requests)
           
        }catch{
            debugPrint("something went wrong!!!!!")
        }
        return objects
    }
}
