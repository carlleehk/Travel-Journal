//
//  ChooseScreenViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/2/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

class ChooseScreenViewController: CoreDataViewController {
    
    @IBAction func preview(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "preview") as! PreviewViewController
        present(control, animated: true, completion: nil)
    }
    
}
