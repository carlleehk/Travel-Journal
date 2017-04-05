//
//  PreviewViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/4/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import CoreData

class PreviewViewController: CoreDataViewController {
    
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fr.sortDescriptors = []
        fr.predicate = NSPredicate(format: "location = %@", [JournalInfo.location])
        
        //let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
