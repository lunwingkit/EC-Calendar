//
//  ScheduleTableViewDateSourceDelagate.swift
//  Project1
//
//  Created by LUN WING KIT on 1/4/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit
import CoreData

class ScheduleTableViewDateSourceDelegate: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var fetchedResultsController: NSFetchedResultsController<Event>!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let events = fetchedResultsController.fetchedObjects else { return 0 }
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as? ScheduleTableViewCell else{
            fatalError("Unexpected Index Path")
        }
        
        let event = fetchedResultsController.object(at: indexPath)
        cell.titleLabel.text = event.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
//            let event = fetchedResultsController.object(at: indexPath)
//            scheduleTableView.deleteRows(at: [indexPath], with: .fade)
            
            let event = fetchedResultsController.object(at: indexPath)
            self.fetchedResultsController.managedObjectContext.delete(event)
        }
    }
    
    var messageLabel: UILabel!
    var scheduleTableView: UITableView!
    
    func updateView(){
        var hasEvent = false
        
        if(fetchedResultsController.fetchedObjects!.count > 0){
            hasEvent = true
        }
        else{
            hasEvent = false
        }
        
        print(fetchedResultsController.fetchedObjects!.count)
        print(scheduleTableView.numberOfRows(inSection: 0))
        print("THE VALUE OF HAS EVENT")
        print(hasEvent)
        
        if(hasEvent == true){
            messageLabel.isHidden = true
        }
        else{
            messageLabel.isHidden = false
        }
        
        //scheduleTableView.isHidden = !hasEvent
        messageLabel.isHidden = hasEvent
        //TODO: Add messageLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView(){
        setupMessageLabel()
    }
    
    private func setupMessageLabel(){
        messageLabel.text = "No Event"
    }
}
