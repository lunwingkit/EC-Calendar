//
//  CalendarViewController.swift
//  Project1
//
//  Created by LUN WING KIT on 10/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
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

    @IBOutlet weak var switchButton: UIBarButtonItem!
    
    @IBOutlet weak var scheduleTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        
        calendarCollectionViewDD = CalendarCollectionViewDD(coder: aDecoder)!
        
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        navigationItem.title = "Calendar"
        
        self.ecCalendarCollectionView.register(UINib(nibName: "CalendarViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        self.calendarCollectionView.register(UINib(nibName: "CalendarViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        
        calendarCollectionViewDD.ecCalendarCollectionView = self.ecCalendarCollectionView
        calendarCollectionViewDD.calendarCollectionView = self.calendarCollectionView
        
        calendarCollectionViewDD.calendarCollectionView.dataSource = calendarCollectionViewDD
        calendarCollectionViewDD.ecCalendarCollectionView.dataSource = calendarCollectionViewDD
        calendarCollectionViewDD.calendarCollectionView.delegate = calendarCollectionViewDD
        calendarCollectionViewDD.ecCalendarCollectionView.delegate = calendarCollectionViewDD
        
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
    
}
