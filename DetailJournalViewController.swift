//
//  DetailJournalViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/1/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import CoreData

class DetailJournalViewController: CoreDataViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var detailedTable: UITableView!
    
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailedTable.delegate = self
        detailedTable.dataSource = self
        
        fr.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fr.predicate = NSPredicate(format: "name = %@", argumentArray: [JournalInfo.journalName])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let fc = fetchedResultsController{
            print("there are \(fc.sections![section].numberOfObjects) objects")
            return fc.sections![section].numberOfObjects
        } else{
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //FIND THE NOTEBOOK
        let nb = fetchedResultsController?.object(at: indexPath) as! Location
        
        //CREATE THE CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath)
        
        //SYNC NOTEBOOK -> CELL
        cell.textLabel?.text = nb.locationName
        cell.detailTextLabel?.text = nb.creationDate?.description
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        let alertController = UIAlertController(title: nil, message: "Select the action you wanted to perform for \((cell?.textLabel?.text)!)", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "View", style: .default){(_) in
            
            let control = self.storyboard?.instantiateViewController(withIdentifier: "detailJournal") as! DetailJournalViewController
            JournalInfo.journalName = (cell?.textLabel?.text)!
            self.present(control, animated: true, completion: nil)
            
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            
            self.stack.context.delete(self.fetchedResultsController?.object(at: indexPath) as! Name)
            do{
                try self.stack.saveContext()
            }catch{
                print("Error while saving")
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(viewAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        
    }*/


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailJournalViewController {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        detailedTable.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let set = IndexSet(integer: sectionIndex)
        
        switch (type) {
        case .insert:
            detailedTable.insertSections(set, with: .fade)
        case .delete:
            detailedTable.deleteSections(set, with: .fade)
        default:
            // irrelevant in our case
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case .insert:
            detailedTable.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            detailedTable.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            detailedTable.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            detailedTable.deleteRows(at: [indexPath!], with: .fade)
            detailedTable.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        detailedTable.endUpdates()
    }
}


