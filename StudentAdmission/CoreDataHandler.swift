//
//  CoreDataHandler.swift
//  StudentAdmission
//
//  Created by Akshay Jangir on 13/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler
{
    static let shared = CoreDataHandler()
    
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
    
    func insert(spid:String ,name:String ,div:String , pwd:String, completion: @escaping () -> Void)
    {
        let stud = Student(context: managedObjectContext)
        stud.spid = spid
        stud.name = name
        stud.div = div
        stud.pwd = pwd
        
        save()
        completion()
    }
    func update(stud:Student, name:String, email:String ,dept:String , pwd:String, completion: @escaping () -> Void)
    {
        stud.email = email
        stud.name = name
        stud.dept = dept
        stud.pwd = pwd
        save()
        completion()
    }
    
    func changepwd(stud:Student , pwd:String, completion: @escaping () -> Void)
    {
        stud.pwd = pwd
        save()
        completion()
    }
    
    func delete(stud:Student, completion: @escaping () -> Void)
    {
        managedObjectContext!.delete(stud)
        save()
        completion()
    }
    
    func fetch() -> [Student]
    {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do
        {
            let studArray = try managedObjectContext?.fetch(fetchRequest)

            return studArray!
        } catch {
            print(error)
            let studArray = [Student]()
            return studArray
        }
    }
}
