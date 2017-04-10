//
//  PictureViewCollectionViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/27/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

class PictureViewCollectionViewController: ChooseScreenViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var FlickRFlow: UICollectionViewFlowLayout!
    
    var imageAddress: [String] = []
    var messageFrame = UIView()
    var strLabel = UILabel()
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.delegate = self
        collectionView.dataSource = self
        label.isHidden = true
        
        progressBarDisplay(msg: "Downloading FlickR Image", indicator: true)
        fetchNewImage()
        
        collectionView.allowsMultipleSelection = true

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        label.text = "Click done to use those images in your journal"
        
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
    
    func fetchNewImage(){
        
        FlickRClient.sharedInstance().displayImageFromFlickrBySearch(lat: JournalInfo.lat, long: JournalInfo.long) { (result, error) in
            performUIUpdateOnMain {
                if error == nil{
                    for item in result!{
                        let imageURLString = item[FlickRClient.Constants.FlickrResponseKeys.MediumURL] as? String
                        self.imageAddress.append(imageURLString!)
                        self.collectionView.reloadData()
                        self.label.isHidden = false
                    }
                } else{
                    print("some error: \(String(describing: error?.localizedDescription))")
                    let alertController = UIAlertController(title: "Error", message: "Network Request Error", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                self.messageFrame.removeFromSuperview()
            }
        }
    }
    
    func progressBarDisplay(msg: String, indicator: Bool){
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 300, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        messageFrame = UIView(frame: CGRect(x: view.frame.midX  - 140, y: view.frame.midY - 25, width: 280, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
        
    }


    @IBAction func dismiss(_ sender: Any) {
        
        let indexPaths = collectionView.indexPathsForSelectedItems
        
        for index in indexPaths!{
            
            let pictureURL = URL(string: imageAddress[index.item])
            let data = try? Data(contentsOf: pictureURL!)
            let imageData = Photo(photo: data! as NSData, context: stack.context)
            imageData.location = JournalInfo.location
            print(imageData)
            save()
            
        }
        
        dismiss(animated: true, completion: nil)
    }

}
