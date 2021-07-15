//
//  CoreNoticeHandler.swift
//  StudentAdmission
//
//  Created by Akshay Jangir on 13/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreNoticeHandler
{
    static let shared = CoreNoticeHandler()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext?
    
    private init()
    {
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func save()
    {
        appDelegate.saveContext()
    }
    
    func insert(notice:String, completion: @escaping () -> Void)
    {
        let nt = Notice(context: managedObjectContext)
        nt.notice = notice
        save()
        completion()
    }
    func update(not:Notice,notice:String, completion: @escaping () -> Void)
    {
        not.notice = notice
        save()
        completion()
    }
    func fetch() -> [Notice]
    {
        let fetchRequest:NSFetchRequest<Notice> = Notice.fetchRequest()
        
        do
        {
            let noticeArray = try managedObjectContext?.fetch(fetchRequest)
            return noticeArray!
        } catch {
            print(error)
            let noticeArray = [Notice]()
            return noticeArray // to prevent the app from crashing so we are reurning empty array
        }
    }
}
