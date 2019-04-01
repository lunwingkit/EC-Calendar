//
//  NewEventTableViewController.swift
//  Project1
//
//  Created by LUN WING KIT on 26/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class NewEventNavigationController: UINavigationController, RowControllerType {
    var onDismissCallback : ((UIViewController) -> ())?
}

class NewEventViewController : FormViewController{
    @objc func cancelTapped(_ barButtonItem: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var scheduleTableView: UITableView!
    
    @objc func saveTapped(_ barButtonItem: UIBarButtonItem) {
        print("Save")
//        let row: TextRow? = form.rowBy(tag: "Title")
//        let value = row?.value
        let valuesDictionary = form.values()
        print(valuesDictionary)
        saveEvent()
        self.dismiss(animated: true, completion: nil)
    }
    
    var managedObjectContext: NSManagedObjectContext?
    
    func newSaveEvent(){
        guard let managedObjectContext = managedObjectContext else {return}
        let event = Event(context: managedObjectContext)
        
        let titleRow: TextRow? = form.rowBy(tag: "Title")
        let allDayRow: SwitchRow? = form.rowBy(tag: "All-day")
        let locationRow: TextRow? = form.rowBy(tag: "Location")
        let startsRow: DateTimeInlineRow? = form.rowBy(tag: "Starts")
        let endsRow: DateTimeInlineRow? = form.rowBy(tag: "Ends")
        let noteRow: TextAreaRow? = form.rowBy(tag: "notes")
        
        event.title = titleRow?.value
        event.allDay = (allDayRow?.value)!
        event.location = locationRow?.value
        event.startDate = startsRow?.value as! NSDate
        event.endDate = endsRow?.value as! NSDate
        event.notes = noteRow?.value
        
    }
    
    
    func saveEvent(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let myEntityName = "Event"
        let event = NSEntityDescription.insertNewObject(forEntityName: myEntityName, into: moc) as! Event
        event.allDay = true
        event.startDate = Date() as NSDate
        event.endDate = Date() as NSDate
        let titleRow: TextRow? = form.rowBy(tag: "Title")
        let allDayRow: SwitchRow? = form.rowBy(tag: "All-day")
        let locationRow: TextRow? = form.rowBy(tag: "Location")
        let startsRow: DateTimeInlineRow? = form.rowBy(tag: "Starts")
        let endsRow: DateTimeInlineRow? = form.rowBy(tag: "Ends")
        let noteRow: TextAreaRow? = form.rowBy(tag: "notes")
        
        event.title = titleRow?.value
        event.allDay = (allDayRow?.value)!
        event.location = locationRow?.value
        event.startDate = startsRow?.value as! NSDate
        event.endDate = endsRow?.value as! NSDate
        event.notes = noteRow?.value
        
        do{
            try moc.save()
        } catch{
            fatalError("\(error)")
        }
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: myEntityName)
        do{
            let results =
                try moc.fetch(request) as! [Event]
            for result in results{
                print("\(String(describing: result.title))")
                print("\(String(describing: result.allDay))")
                print("\(String(describing: result.startDate))")
                print("\(String(describing: result.endDate))")
                print("\(String(describing: result.notes))")
                print("\(String(describing: result.location))")
            }
             print(results.count)
        }catch{
            fatalError("\(error)")
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        initializeForm()
        
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(self.cancelTapped(_:))
        
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.action = #selector(self.saveTapped(_:))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func initializeForm() {
        
        form +++
            
            TextRow("Title").cellSetup { cell, row in
                cell.textField.placeholder = row.tag
            }.onChange{ row in
                let text = row.value
                if(text == nil || (text?.isEmpty)!){
                    print("BLK")
                    print(self.scheduleTableView)
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                }
                else{
                    print("OK")
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
            }
            
            <<< TextRow("Location").cellSetup {
                $1.cell.textField.placeholder = $0.row.tag
            }
            
            +++
            
            SwitchRow("All-day") {
                $0.value = false
                $0.title = $0.tag
                }.onChange { [weak self] row in
                    let startDate: DateTimeInlineRow! = self?.form.rowBy(tag: "Starts")
                    let endDate: DateTimeInlineRow! = self?.form.rowBy(tag: "Ends")
                    
                    if row.value ?? false {
                        startDate.dateFormatter?.dateStyle = .medium
                        startDate.dateFormatter?.timeStyle = .none
                        endDate.dateFormatter?.dateStyle = .medium
                        endDate.dateFormatter?.timeStyle = .none
                    }
                    else {
                        startDate.dateFormatter?.dateStyle = .short
                        startDate.dateFormatter?.timeStyle = .short
                        endDate.dateFormatter?.dateStyle = .short
                        endDate.dateFormatter?.timeStyle = .short
                    }
                    startDate.updateCell()
                    endDate.updateCell()
                    startDate.inlineRow?.updateCell()
                    endDate.inlineRow?.updateCell()
            }
            
            <<< DateTimeInlineRow("Starts") {
                $0.title = $0.tag
                $0.value = Date().addingTimeInterval(60*60*24)
                }
                .onChange { [weak self] row in
                    let endRow: DateTimeInlineRow! = self?.form.rowBy(tag: "Ends")
                    if row.value?.compare(endRow.value!) == .orderedDescending {
                        endRow.value = Date(timeInterval: 60*60*24, since: row.value!)
                        endRow.cell!.backgroundColor = .white
                        endRow.updateCell()
                    }
                }
                .onExpandInlineRow { [weak self] cell, row, inlineRow in
                    inlineRow.cellUpdate() { cell, row in
                        let allRow: SwitchRow! = self?.form.rowBy(tag: "All-day")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .date
                        }
                        else {
                            cell.datePicker.datePickerMode = .dateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
            }
            
            <<< DateTimeInlineRow("Ends"){
                $0.title = $0.tag
                $0.value = Date().addingTimeInterval(60*60*25)
                }
                .onChange { [weak self] row in
                    let startRow: DateTimeInlineRow! = self?.form.rowBy(tag: "Starts")
                    if row.value?.compare(startRow.value!) == .orderedAscending {
                        row.cell!.backgroundColor = .red
                    }
                    else{
                        row.cell!.backgroundColor = .white
                    }
                    row.updateCell()
                }
                .onExpandInlineRow { [weak self] cell, row, inlineRow in
                    inlineRow.cellUpdate { cell, dateRow in
                        let allRow: SwitchRow! = self?.form.rowBy(tag: "All-day")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .date
                    }
                        else {
                            cell.datePicker.datePickerMode = .dateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
        }
        
        form +++
            
            PushRow<RepeatInterval>("Repeat") {
                $0.title = $0.tag
                $0.options = RepeatInterval.allValues
                $0.value = .Never
                }.onPresent({ (_, vc) in
                    vc.enableDeselection = false
                    vc.dismissOnSelection = false
                })
        
        form +++
            
            PushRow<EventAlert>() {
                $0.title = "Alert"
                $0.options = EventAlert.allValues
                $0.value = .Never
                }
                .onChange { [weak self] row in
                    if row.value == .Never {
                        if let second : PushRow<EventAlert> = self?.form.rowBy(tag: "Another Alert"), let secondIndexPath = second.indexPath {
                            row.section?.remove(at: secondIndexPath.row)
                        }
                    }
                    else{
                        guard let _ : PushRow<EventAlert> = self?.form.rowBy(tag: "Another Alert") else {
                            let second = PushRow<EventAlert>("Another Alert") {
                                $0.title = $0.tag
                                $0.value = .Never
                                $0.options = EventAlert.allValues
                            }
                            row.section?.insert(second, at: row.indexPath!.row + 1)
                            return
                        }
                    }
        }
        
        form +++
            
            PushRow<EventState>("Show As") {
                $0.title = "Show As"
                $0.options = EventState.allValues
        }
        
        form +++
            
            URLRow("URL") {
                $0.placeholder = "URL"
            }
            
            <<< TextAreaRow("notes") {
                $0.placeholder = "Notes"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
        }
        
    }
    
    enum RepeatInterval : String, CustomStringConvertible {
        case Never = "Never"
        case Every_Day = "Every Day"
        case Every_Week = "Every Week"
        case Every_2_Weeks = "Every 2 Weeks"
        case Every_Month = "Every Month"
        case Every_Year = "Every Year"
        
        var description : String { return rawValue }
        
        static let allValues = [Never, Every_Day, Every_Week, Every_2_Weeks, Every_Month, Every_Year]
    }
    
    enum EventAlert : String, CustomStringConvertible {
        case Never = "None"
        case At_time_of_event = "At time of event"
        case Five_Minutes = "5 minutes before"
        case FifTeen_Minutes = "15 minutes before"
        case Half_Hour = "30 minutes before"
        case One_Hour = "1 hour before"
        case Two_Hour = "2 hours before"
        case One_Day = "1 day before"
        case Two_Days = "2 days before"
        
        var description : String { return rawValue }
        
        static let allValues = [Never, At_time_of_event, Five_Minutes, FifTeen_Minutes, Half_Hour, One_Hour, Two_Hour, One_Day, Two_Days]
    }
    
    enum EventState {
        case busy
        case free
        
        static let allValues = [busy, free]
    }
}
