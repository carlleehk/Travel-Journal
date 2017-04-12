//
//  PreviewViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/4/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import CoreData

class PreviewViewController: CoreDataViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate, UIViewControllerPreviewingDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var journalText: UITextView!
    @IBOutlet weak var previewCollection: UICollectionView!
    
    var insertedIndexPath: [NSIndexPath]!
    var deletedIndexPath: [NSIndexPath]!
    var updatedIndexPath: [NSIndexPath]!
    
    let header = ["Photo", "Video"]
    @IBOutlet weak var layOut: UICollectionViewFlowLayout!
    let fr1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
    let fr2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
    let fr3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
    var frc1, frc2, frc3: NSFetchedResultsController<NSFetchRequestResult>!
    
    var alert: UIAlertController?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewCollection.delegate = self
        previewCollection.dataSource = self
        
        journalText.delegate = self
        
        previewCollection.allowsMultipleSelection = true
        deleteButton.isHidden = true
        
        //Set up 3D Touch
        if traitCollection.forceTouchCapability != .available {
            registerForPreviewing(with: self, sourceView: view)
        } else{
            alert = UIAlertController(title: "Error", message: "3D Touch not avaliable on this device.", preferredStyle: .alert)
        }
        
        //set up fetch result controller
        fr1.sortDescriptors = []
        fr1.predicate = NSPredicate(format: "location = %@", argumentArray: [JournalInfo.location])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr1, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        frc1 = fetchedResultsController
        
        fr2.sortDescriptors = []
        fr2.predicate = NSPredicate(format: "location = %@", argumentArray: [JournalInfo.location])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr2, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        frc2 = fetchedResultsController
        
        fr3.sortDescriptors = []
        fr3.predicate = NSPredicate(format: "location = %@", argumentArray: [JournalInfo.location])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr3, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        frc3 = fetchedResultsController
        
        if frc1.fetchedObjects?.count == 0 {
            journalText.text = "No note had been created"
        } else{
            let journal = frc1.fetchedObjects?[0] as! Note
            journalText.text = journal.notes!
        }
        
        
        
        // Do any additional setup after loading the view.
        let space: CGFloat = 1.5
        let dimension = view.frame.size.width >= view.frame.size.height ? (view.frame.size.width - (5 * space)) / 6.0 : (view.frame.size.width - (2*space))/3.0
        layOut.minimumInteritemSpacing = space
        layOut.minimumLineSpacing = space
        layOut.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Present the alert if necessary.
        if let alert = alert {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            // Clear the `alertController` to ensure it's not presented multiple times.
            self.alert = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let frc2c = frc2.fetchedObjects?.count
        let frc3c = frc3.fetchedObjects?.count

        
        if section == 0{
            if frc2c == 0{
                return 1
            } else{
                return frc2c!
            }
        } else if section == 1{
            if frc3c == 0{
                return 1
            } else{
                return frc3c!
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "name", for: indexPath) as! FlickRCollectionViewCell
            headerView.headerLabel.text = header[indexPath.section]
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let frc2c = frc2.fetchedObjects?.count
        let frc3c = frc3.fetchedObjects?.count

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "preview", for: indexPath)
        if indexPath.section == 0{
            if frc2c != 0{
                let picDatas = frc2.object(at: indexPath) as! Photo
                let image = UIImage(data: picDatas.photoData!)
                let imageView = UIImageView(image: image)
                cell.backgroundView = imageView
                return cell
            } else{
                let image = UIImage(named: "notAvaliable")
                let imageView = UIImageView(image: image)
                cell.backgroundView = imageView
                return cell
            }
        }else if indexPath.section == 1{
            if frc3c != 0{
                let picDatas = frc3.object(at: IndexPath(row: indexPath.row, section: 0 )) as! Video
                let image = UIImage(data: picDatas.videoPhoto!)
                let imageView = UIImageView(image: image)
                cell.backgroundView = imageView
                return cell
            } else{
                let image = UIImage(named: "notAvaliable")
                let imageView = UIImageView(image: image)
                cell.backgroundView = imageView
                return cell
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        deleteButton.isHidden = false
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.isSelected == true{
            cell?.alpha = 0.5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.isSelected == false{
            cell?.alpha = 1.0
        }

    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        
        guard let indexPath = previewCollection.indexPathForItem(at: CGPoint(x: location.x, y: location.y - previewCollection.frame.minY + previewCollection.contentOffset.y)) else{
            return nil
        }
        guard let cell = previewCollection.cellForItem(at: indexPath) else{
            return nil
        }
       
        
        if indexPath.section == 0{
            let control = storyboard?.instantiateViewController(withIdentifier: "peekView") as! PeekViewViewController
            
            
            let picDatas = frc2.object(at: IndexPath(row: indexPath.row, section: 0 )) as! Photo
            control.photo = picDatas
            control.isVideo = false
            control.preferredContentSize = CGSize(width: 0.0, height: 300)
            
            previewingContext.sourceRect = cell.frame
            
            return control

        }
        
        let control = storyboard?.instantiateViewController(withIdentifier: "peekView") as! PeekViewViewController
        
        
        let videoData = frc3.object(at: IndexPath(row: indexPath.row, section: 0 )) as! Video
        control.video = videoData
        control.initiatingPreviewActionController = self
        control.isVideo = true
        control.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return control
        
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        //no popping action for this project
        //show(viewControllerToCommit, sender: self)
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        journalText.resignFirstResponder()
        
        if journalText.text == "No note had been created"{
            return
        } else if (frc1?.fetchedObjects?.count == 0) {
            let detailJ = Note(detailJ: journalText.text, context: stack.context)
            detailJ.location = JournalInfo.location
        } else{
            let object = frc1?.fetchedObjects?[0] as! Note
            object.setValue(journalText.text, forKey: "notes")
        }
        save()
        
        
    }

    
    @IBAction func addEntry(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "Which of the following do you wanted to edit?", preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let photoAction = UIAlertAction(title: "Photo", style: .default) {(_) in
            
            let control = self.storyboard?.instantiateViewController(withIdentifier: "pictureView") as! PictureViewController
            self.present(control, animated: true, completion: nil)
        
        
        }
        
        let videoAction = UIAlertAction(title: "Video", style: .default) { (_) in
            
            let control = self.storyboard?.instantiateViewController(withIdentifier: "videoView") as! VideoViewController
            self.present(control, animated: true, completion: nil)
            
        }
        
        
        alertController.addAction(photoAction)
        alertController.addAction(videoAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

        
        
    }
    
    @IBAction func deleteEntry(_ sender: Any) {
        
        deleteButton.isHidden = true
        
        let selectedItems = previewCollection.indexPathsForSelectedItems
        let alertController = UIAlertController(title: nil, message: "Delete Selected Entry?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            for indexPath in selectedItems!{
                
                if indexPath.section == 0{
                    self.stack.context.delete(self.frc2.object(at: indexPath) as! Photo)
                } else if indexPath.section == 1{
                    self.stack.context.delete(self.frc3.object(at: IndexPath(row: indexPath.row, section: 0)) as! Video)
                }
                self.save()
                
            }
        
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(_) in
            for indexPath in selectedItems!{
                let cell = self.previewCollection.cellForItem(at: indexPath)
                self.previewCollection.deselectItem(at: indexPath, animated: true)
                cell?.alpha = 1.0
            }
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

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


extension PreviewViewController{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedIndexPath = []
        deletedIndexPath = []
        updatedIndexPath = []
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type{
            
        case .insert:
            insertedIndexPath.append(newIndexPath! as NSIndexPath)
        case .delete:
            deletedIndexPath.append(indexPath! as NSIndexPath)
        case .update:
            updatedIndexPath.append(indexPath! as NSIndexPath)
        default: break
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        previewCollection.performBatchUpdates({
            for indexPath in self.insertedIndexPath{
                self.previewCollection.insertItems(at: [indexPath as IndexPath])
            }
            
            for indexPath in self.deletedIndexPath{
                self.previewCollection.deleteItems(at: [indexPath as IndexPath])
            }
            
            for indexPath in self.updatedIndexPath{
                self.previewCollection.reloadItems(at: [indexPath as IndexPath])
            }
        }, completion: nil)
    }
}

