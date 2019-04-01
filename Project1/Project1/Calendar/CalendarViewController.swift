//
//  CalendarViewController.swift
//  Project1
//
//  Created by LUN WING KIT on 10/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit
import CoreData

class CalendarViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var currentYear: Int = 2019
    var currentMonth: Int = 1
    
    func getTextByIndexPath(indexPath: IndexPath) -> String{
        
        return String(indexPath.item)
        
    }
    
    @IBOutlet weak var ecCalendarCollectionView: UICollectionView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    @IBOutlet weak var ecYearLabel: UILabel!
    @IBOutlet weak var ecMonthLabel: UILabel!
    
    @IBOutlet weak var yearMonthView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    var calendarCollectionViewDD: CalendarCollectionViewDD
    var scheduleTableViewDateSourceDelagate: ScheduleTableViewDateSourceDelegate
    var newEventViewController: NewEventViewController
    
    @IBOutlet weak var switchButton: UIBarButtonItem!
    
    @IBOutlet weak var scheduleTableView: UITableView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        
        calendarCollectionViewDD = CalendarCollectionViewDD(coder: aDecoder)!
        scheduleTableViewDateSourceDelagate = ScheduleTableViewDateSourceDelegate(coder: aDecoder)!
        newEventViewController = NewEventViewController(coder: aDecoder)!
        components = calendar.dateComponents([.year, .month, .day], from: date as Date)
        month = components.month!
        day = components.day!
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        navigationItem.title = "Calendar"
        
        self.ecCalendarCollectionView.register(UINib(nibName: "CalendarViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        self.calendarCollectionView.register(UINib(nibName: "CalendarViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        
        self.scheduleTableView.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
        
        calendarCollectionViewDD.ecCalendarCollectionView = self.ecCalendarCollectionView
        calendarCollectionViewDD.calendarCollectionView = self.calendarCollectionView
        
        calendarCollectionViewDD.calendarCollectionView.dataSource = calendarCollectionViewDD
        calendarCollectionViewDD.ecCalendarCollectionView.dataSource = calendarCollectionViewDD
        calendarCollectionViewDD.calendarCollectionView.delegate = calendarCollectionViewDD
        calendarCollectionViewDD.ecCalendarCollectionView.delegate = calendarCollectionViewDD
        
        scheduleTableViewDateSourceDelagate.scheduleTableView = self.scheduleTableView
        scheduleTableViewDateSourceDelagate.scheduleTableView.dataSource = scheduleTableViewDateSourceDelagate
        scheduleTableViewDateSourceDelagate.scheduleTableView.delegate = scheduleTableViewDateSourceDelagate
        scheduleTableViewDateSourceDelagate.messageLabel = self.messageLabel
        scheduleTableViewDateSourceDelagate.messageLabel.text = "No Event"
        configScheduleTable()
        scheduleTableViewDateSourceDelagate.fetchedResultsController = self.fetchResultController
        self.scheduleTableViewDateSourceDelagate.setupView()
        self.scheduleTableViewDateSourceDelagate.updateView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: Notification.Name.NSExtensionHostDidEnterBackground, object: nil)
        
        calendarCollectionViewDD.ecYearLabel = self.ecYearLabel
        calendarCollectionViewDD.ecMonthLabel = self.ecMonthLabel
        calendarCollectionViewDD.yearLabel = self.yearLabel
        calendarCollectionViewDD.monthLabel = self.monthLabel
        
        ecYearLabel.text = String(self.currentYear)
        ecMonthLabel.text = Custom_Calender.getMonthStringFromInt(int: self.currentMonth)
        yearLabel.text = String(self.currentYear)
        monthLabel.text = Custom_Calender.getMonthStringFromInt(int: self.currentMonth)
        
        calendarCollectionViewDD.currentSection = self.currentMonth
        calendarCollectionViewDD.updateLayout()
        
        switchButton.action = #selector(self.switchBelowView(sender:))
        switchButton.target = self
        
        yearMonthView.isHidden = false
        calendarCollectionView.isHidden = false
        scheduleTableView.isHidden = true
        
        let date = NSDate()
        print(date)
        
    }
    
    @objc func applicationDidEnterBackground(_ notification: Notification) {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Unable to Save Changes")
            print("\(error), \(error.localizedDescription)")
        }
    }
    
    private let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
//        NSPersistentContainer(name: "Project1")
    
//    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Event> = {
//        // Create Fetch Request
//        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
//
//        // Configure Fetch Request
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
//
//        // Create Fetched Results Controller
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        // Configure Fetched Results Controller
//        fetchedResultsController.delegate = self
//
//        return fetchedResultsController
//    }()
    
    var fetchResultController: NSFetchedResultsController<Event>!
    
    func configScheduleTable(){
        
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do{
                try fetchResultController.performFetch()
                }
            catch{
                let fetchError = error as NSError
                //                    print("Unable to Perform Fetch Request")
                //                    print("\(fetchError), \(fetchError.localizedDescription)")
            }
            
        }
        
//        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
//            if let error = error {
//                print("Unable to Load Persistent Store")
//                print("\(error), \(error.localizedDescription)")
//
//            } else {
//                self.scheduleTableViewDateSourceDelagate.setupView()
//
//                do {
//                    try self.fetchedResultsController.performFetch()
//                } catch {
//                    let fetchError = error as NSError
//                    print("Unable to Perform Fetch Request")
//                    print("\(fetchError), \(fetchError.localizedDescription)")
//                }
//
//                self.scheduleTableViewDateSourceDelagate.updateView()
//            }
//        }
        
    }
    
    let date = Date()
    let calendar = Calendar.current
    var components: DateComponents
    var month: Int
    var day: Int
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
//
//        self.calendarCollectionViewDD.currentSection = month - 1
//        self.calendarCollectionViewDD.updateLayout()
//
//        if let ecTextLabel = ecMonthLabel{
//            ecTextLabel.text = Custom_Calender.getMonthStringFromInt(int: month)
//        }
//        if let textLabel = monthLabel{
//            textLabel.text = Custom_Calender.getMonthStringFromInt(int: month)
//        }
        
//        let cell = calendarCollectionView.cellForItem(at: IndexPath(row: day!, section: month!)) as! CalendarViewCell
        
//        if let selectedView = cell.contentView.subviews[0] as? UIView{
//            selectedView.alpha = 0.5
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        print(calendarCollectionView.visibleCells.count)
//        if(calendarCollectionView.visibleCells.contains(calendarCollectionView.cellForItem(at: IndexPath(row: day - 1, section: month - 1))!))
//        {
//            print("YES")
//            calendarCollectionView.cellForItem(at: IndexPath(row: day - 1, section: month - 1))?.contentView.subviews[0].alpha = 0.5
//            calendarCollectionView.selectItem(at: IndexPath(row: day - 1, section: month - 1), animated: false, scrollPosition: UICollectionView.ScrollPosition.top)
//        }
//        if(ecCalendarCollectionView.visibleCells.contains(ecCalendarCollectionView.cellForItem(at: IndexPath(row: day - 1, section: month - 1))!))
//        {
//            print("YES")
//            ecCalendarCollectionView.cellForItem(at: IndexPath(row: day - 1 + 6, section: month - 1))?.contentView.subviews[0].alpha = 0.5
//            ecCalendarCollectionView.selectItem(at: IndexPath(row: day - 1 + 6, section: month - 1), animated: false, scrollPosition: UICollectionView.ScrollPosition.top)
//        }
//        print(ecCalendarCollectionView.visibleCells.count)


    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is NewEventNavigationController){
            let vc = segue.destination as? NewEventNavigationController
            let newEventVC = vc?.topViewController as? NewEventViewController
            newEventVC?.managedObjectContext = persistentContainer.viewContext
        }
    }
    
    @IBAction func addEvent(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "NativeEventsFormNavigationControllerSegue", sender: self)
        newEventViewController.scheduleTableView = self.scheduleTableView
        print("LOOK")
        print(newEventViewController.scheduleTableView)
    }
    
    
    var isShowingSchedule = false
    @objc func switchBelowView(sender: UIBarButtonItem){
        print("PRESSED")
        if(!isShowingSchedule){
            print("SWITCH TO SCHEDULE NOW")
            calendarCollectionView.isHidden = true
            yearMonthView.isHidden = true
            scheduleTableView.isHidden = false
        }
        else{
            print("SWITCH TO perennial NOW")
            calendarCollectionView.isHidden = false
            yearMonthView.isHidden = false
            scheduleTableView.isHidden = true
        }
        isShowingSchedule = !isShowingSchedule
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        scheduleTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        scheduleTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                scheduleTableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                scheduleTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        default:
            print("...")
        }
        scheduleTableViewDateSourceDelagate.updateView()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    }
    
    @IBAction func onMenuClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! UIViewController
        
        present(vc, animated: true, completion: nil)
        
        print(1)
    }
    
}
