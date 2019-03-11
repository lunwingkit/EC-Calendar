//
//  ViewController.swift
//  Project1
//
//  Created by LUN WING KIT on 8/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    var displayController: UIViewController!
    
    var calendarViewController: CalendarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .white
        //navigationItem.title = "Calendar"
        configureCalendarViewController()
    }
    
    func configureCalendarViewController(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        calendarViewController = storyBoard.instantiateViewController(withIdentifier: "calendarViewController") as! CalendarViewController
        //calendarViewController = CalendarViewController()
        displayController = UINavigationController(rootViewController: calendarViewController)
        
        view.addSubview(displayController.view)
        addChild(displayController)
        displayController.didMove(toParent: self)
        
    }
    
    
}


