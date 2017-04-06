//
//  PreviewViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/4/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import CoreData

class PreviewViewController: CoreDataViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var journalText: UITextView!
    @IBOutlet weak var previewCollection: UICollectionView!
    
    let header = ["Photo", "Video"]
    @IBOutlet weak var layOut: UICollectionViewFlowLayout!
    let fr1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
    let fr2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
    let fr3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
    var frc1, frc2, frc3: NSFetchedResultsController<NSFetchRequestResult>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewCollection.delegate = self
        previewCollection.dataSource = self
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0{
            return (frc2.fetchedObjects?.count)!
        } else if section == 1{
            return (frc3.fetchedObjects?.count)!

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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "preview", for: indexPath)
        if indexPath.section == 0{
            let picDatas = frc2.object(at: indexPath) as! Photo
            let image = UIImage(data: picDatas.photoData as! Data)
            let imageView = UIImageView(image: image)
            cell.backgroundView = imageView
            return cell
        }else if indexPath.section == 1{
            let picDatas = frc3.object(at: IndexPath(row: indexPath.row, section: 0 )) as! Video
            let image = UIImage(data: picDatas.videoPhoto as! Data)
            let imageView = UIImageView(image: image)
            cell.backgroundView = imageView
            return cell
        }
        
        return cell
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
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
