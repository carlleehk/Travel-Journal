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

    @IBOutlet weak var titleItem: UINavigationItem!
    @IBOutlet weak var detailedTable: UITableView!
    
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailedTable.delegate = self
        detailedTable.dataSource = self
        
        titleItem.title = JournalInfo.journalName.journalName!
        
        fr.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fr.predicate = NSPredicate(format: "name = %@", argumentArray: [JournalInfo.journalName])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        

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
        let date = dateFormatter(date: nb.creationDate!)
        cell.textLabel?.text = nb.locationName
        cell.detailTextLabel?.text = date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        let nb = fetchedResultsController?.object(at: indexPath) as! Location
        JournalInfo.location = nb
        JournalInfo.lat = nb.lat
        JournalInfo.long = nb.long
        
        let alertController = UIAlertController(title: nil, message: "Select the action you wanted to perform for \((cell?.textLabel?.text)!)", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "View", style: .default){(_) in
            
            let control = self.storyboard?.instantiateViewController(withIdentifier: "preview") as! PreviewViewController
            self.present(control, animated: true, completion: nil)
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            
            self.stack.context.delete(self.fetchedResultsController?.object(at: indexPath) as! Location)
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

        
        
    }
    
    @IBAction func presentMap(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
        JournalInfo.firstRun = true
        present(control, animated: true, completion: nil)
    }

    @IBAction func dismiss(_ sender: Any) {
        
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func dateFormatter(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd, hh:mm:ss"
        let str = dateFormatter.string(from: date)
        return str
        
    }

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


