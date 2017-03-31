//
//  PictureViewCollectionViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/27/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

class PictureViewCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var FlickRFlow: UICollectionViewFlowLayout!
    var imageAddress: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchNewImage()

        // Do any additional setup after loading the view.
        let space: CGFloat = 1.5
        let dimension = view.frame.size.width >= view.frame.size.height ? (view.frame.size.width - (5 * space)) / 6.0 : (view.frame.size.width - (2*space))/3.0
        FlickRFlow.minimumInteritemSpacing = space
        FlickRFlow.minimumLineSpacing = space
        FlickRFlow.itemSize = CGSize(width: dimension, height: dimension)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    /*override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/
    
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("...")
        return imageAddress.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath)
        let pictureURL = URL(string: imageAddress[indexPath.item])
        let data = try? Data(contentsOf: pictureURL!)
        let image = UIImage(data: data!)
        let imageView = UIImageView(image: image)
        cell.backgroundView = imageView
        return cell
        // Configure the cell
}
    
    func fetchNewImage(){
        
        
        FlickRClient.sharedInstance().displayImageFromFlickrBySearch(lat: 23.5, long: 67.8) { (result, error) in
            if error == nil{
                for item in result!{
                    let imageURLString = item[FlickRClient.Constants.FlickrResponseKeys.MediumURL] as? String
                    self.imageAddress.append(imageURLString!)
                }
            } else{
                print("some error: \(String(describing: error?.localizedDescription))")
            }
            self.collectionView!.reloadData()
        }
        
        
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
