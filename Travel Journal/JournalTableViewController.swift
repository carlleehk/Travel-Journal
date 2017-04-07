//
//  JournalTableViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/31/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import CoreData

class JournalTableViewController: CoreDataViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Name")
    /*var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?{
        didSet{
            fetchedResultsController?.delegate = self
            executeSearch()
        }
    
    }*/
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fr.sortDescriptors = [NSSortDescriptor(key: "journalName", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addJournal(_ sender: Any) {
        presentAlert()
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
        let nb = fetchedResultsController?.object(at: indexPath) as! Name
        
        //CREATE THE CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
        
        //SYNC NOTEBOOK -> CELL
        cell.textLabel?.text = nb.journalName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        let info = fetchedResultsController?.object(at: indexPath) as! Name
        

        
        let alertController = UIAlertController(title: nil, message: "Select the action you wanted to perform for \((cell?.textLabel?.text)!)", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "View", style: .default){(_) in
            
            let control = self.storyboard?.instantiateViewController(withIdentifier: "detailJournal") as! DetailJournalViewController
            
            JournalInfo.journalName = info
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

     
    }
    
    func presentAlert(){
        
        let alertController = UIAlertController(title: "New Journal", message: "Enter your journal name", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            if let field = alertController.textFields?[0]{
                if field.text != ""{
                    let nl = Name(name: field.text!, context: self.stack.context)
                    do{
                        try self.stack.saveContext()
                    }catch{
                        print("Error while saving")
                    }
                    let control = self.storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
                    JournalInfo.journalName = nl
                    /*let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
                    fr.sortDescriptors = []
                    fr.predicate = NSPredicate(format: "name = %@", argumentArray: [field.text!])
                    let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: self.stack.context, sectionNameKeyPath: nil, cacheName: nil)
                    
                    control.fetchedResultsController = fc*/
                    self.present(control, animated: true, completion: nil)
                    
                }else{
                    self.presentAlert()
                }
                
            } else{
                print("error")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Text"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    /*func executeSearch(){
        
        if let fc = fetchedResultsController{
            
            do{
                try fc.performFetch()
            } catch let e as NSError{
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
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

extension JournalTableViewController {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let set = IndexSet(integer: sectionIndex)
        
        switch (type) {
        case .insert:
            tableView.insertSections(set, with: .fade)
        case .delete:
            tableView.deleteSections(set, with: .fade)
        default:
            // irrelevant in our case
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

