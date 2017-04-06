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
    
    let entityName = ["Note", "Photo", "Video"]
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
        
        let journal = frc1.fetchedObjects?[0] as! Note
        journalText.text = journal.notes!
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
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frc2.sections![section].numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "preview", for: indexPath)
        let picDatas = frc2.object(at: indexPath) as! Photo
        let image = UIImage(data: picDatas.photoData! as Data)
        let imageView = UIImageView(image: image)
        cell.backgroundView = imageView
        return cell
        
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
