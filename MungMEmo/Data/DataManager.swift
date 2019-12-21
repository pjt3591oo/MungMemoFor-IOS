//
//  DataManager.swift
//  MungMEmo
//
//  Created by 박정태 on 2019/12/21.
//  Copyright © 2019 JeongTae Park. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
     
    // signleton 생성방법
    static let shared = DataManager()
    private init () {
        
    }
    
    var mainContenxt:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 메모를 데이터베이스에서 읽어오는 배열
    var memoList = [Memo]()
    
    // 데이터베이스에서 데이터를 읽어오는 메소드
    // 데이터를 읽을때 fetch 메소드 필요
    func fetchMemo() {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            memoList = try mainContenxt.fetch(request)
        } catch {
            print(error)
        }
        
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MungMEmo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
