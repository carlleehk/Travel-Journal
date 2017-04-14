//
//  CoreDataViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/1/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let stack = (UIApplication.shared.delegate as! AppDelegate).stack
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?{
        didSet{
            fetchedResultsController?.delegate = self
            executeSearch()
        }
        
    }

    
    func executeSearch(){
        
        if let fc = fetchedResultsController{
            
            do{
                try fc.performFetch()
            } catch let e as NSError{
                print("Error while trying to perform a search: \n\(e)\n\((fetchedResultsController)!)")
            }
        }
    }
    
    func save(){
        do{
            try self.stack.saveContext()
        }catch{
            print("Error while saving")
        }
    }

}
