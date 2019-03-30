//
//  NewEventTableViewController.swift
//  Project1
//
//  Created by LUN WING KIT on 26/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit
import Eureka

class NewEventViewController : FormViewController{
    
    @IBAction func cancelClicked(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
    }
}
