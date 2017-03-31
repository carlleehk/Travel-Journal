//
//  JournalTableViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/31/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

class JournalTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addJournal(_ sender: Any) {
        presentAlert()
    }
    
    func presentAlert(){
        
        let alertController = UIAlertController(title: "New Journal", message: "Enter your journal name", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            if let field = alertController.textFields?[0]{
                print(field.text!)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
