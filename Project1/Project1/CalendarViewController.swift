//
//  CalendarViewController.swift
//  Project1
//
//  Created by LUN WING KIT on 10/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, EcCalendarCollectionDelegate {
    func didScroll(to position: CGFloat) {
        ecCalendarCollectionView.contentOffset.y = position
    }
    
    let ecMonthLength = [31,29,31,30,31,30,31,31,30,31,30,31]
    let monthLength = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    let ecBlankLength = [7,7,0,7,7,0,7,6,0,7,6,0]
    let date = Date()
    let calendar = Calendar.current
    
    func getTextByIndexPath(indexPath: IndexPath) -> String{
        var idx = indexPath.item
        
        
        var count = 0;
        while(idx > ecMonthLength[count] - 1){
            idx = idx - ecMonthLength[count]
            if(idx < ecBlankLength[count]){
                return ""
            }
            else{
                idx = idx - ecBlankLength[count]
                count = (count + 1) % 12
            }
        }
        return String(idx + 1)
        
        //        return "\(indexPath.row)"
        
        //1 0-30(1-31) 31-37(Blank) 0 ~ 0+(31-1) // 0+(31-1)+1 ~ 0+(31-1)+7
        //2 38-66(1-28) 67-73(Blank) 0+31+7 ~ 0+31+7+(29-1) // 0+31+7+(29-1) ~ 0
    }
    
    
    
    
    func getMonth(num: Int) -> String{
        switch(num){
            
        case 1:
            return "";
        case 2:
            return "";
        case 3:
            return "March";
        case 4:
            return "";
        case 5:
            return "";
        case 6:
            return "";
        case 7:
            return "";
        case 8:
            return "";
        case 9:
            return "";
        case 10:
            return "";
        case 11:
            return "";
        case 12:
            return "";
        default:
            return "ERR"
            
        }
    }
    
    @IBOutlet weak var ecCalendarCollectionView: UICollectionView!

    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath)
        
        if let textLabel = cell.contentView.subviews[1] as? UILabel{
            textLabel.text = getTextByIndexPath(indexPath: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("CICK, \(String(indexPath.row)), \(String(indexPath.section))")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("DESELECTED, \(String(indexPath.row)), \(String(indexPath.section))")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->CGSize{
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 30)
    }
    
    var onceOnly = false
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !onceOnly{
            let month = calendar.component(.month, from: date)
            var dayAccum: Int = 0
            for n in 1...month-1{
                dayAccum += monthLength[n]
            }
            dayAccum += calendar.component(.day, from: date)
            print(dayAccum)
            let indexToScrollTo = IndexPath(row: dayAccum, section: 0)
            self.ecCalendarCollectionView.scrollToItem(at: indexToScrollTo, at: UICollectionView.ScrollPosition.left, animated: false)
            onceOnly = true
        }
    }
    
    @IBOutlet weak var ecYearLabel: UILabel!
    @IBOutlet weak var ecMonthLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    let calendarCollectionViewDD = CalendarCollectionViewDD()
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.title = "Calendar"
        //        navigationController?.navigationBar.prefersLargeTitles = true
        
        ecYearLabel.text = String(calendar.component(.year, from: date))
        ecMonthLabel.text = getMonth(num: calendar.component(.month, from:date))
        
        yearLabel.text = String(calendar.component(.year, from: date))
        monthLabel.text = getMonth(num: calendar.component(.month, from:date))
//        ecYearLabel.text = String(calendar.component(.year, from: date))
//        ecMonthLabel.text = getMonth(num: calendar.component(.month, from:date))
        self.ecCalendarCollectionView.register(UINib(nibName: "CalendarViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        self.calendarCollectionView.register(UINib(nibName: "CalendarViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        
        
        self.calendarCollectionView.dataSource = calendarCollectionViewDD
        self.calendarCollectionView.delegate = calendarCollectionViewDD
        calendarCollectionViewDD.calendarCollectionView = self.calendarCollectionView
        calendarCollectionViewDD.ecCalendarCollectionDelegate = self
        calendarCollectionViewDD.yearLabel = self.yearLabel
        calendarCollectionViewDD.monthLabel = self.monthLabel
        calendarCollectionView.scrollToItem(at: IndexPath(row: 0, section: calendar.component(.month, from:date) - 1), at: UICollectionView.ScrollPosition.top, animated: false)
        
        print(calendar.component(.day, from: date))
        print(calendar.component(.month, from: date))
    }
    
//    var yearHeader : UIView!
//    var yearLabel : UILabel!
//
//    var weekview: UIView!
//    var weekStackView: UIStackView!
//
//    override func viewDidLoad() {
//        //navigationController?.navigationBar.barTintColor = .darkGray
//        //navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationController?.navigationBar.isTranslucent = false
//        navigationItem.title = "Calendar"
//
//        let ec_month = EC_Calendar.getMonth(year: 2018, month: 2)
//        print(ec_month.daysInMonth)
//        print(ec_month.startingWeekDay)
//        let normal_month = Normal_Calender.getMonth(year: 2018, month: 2)
//        print(normal_month.daysInMonth)
//        print(normal_month.startingWeekDay)
//
//        configureHeader()
//    }
//
//    func configureHeader(){
//        yearHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
//        yearHeader.backgroundColor = .darkGray
//        self.view.addSubview(yearHeader)
//
//        yearHeader.translatesAutoresizingMaskIntoConstraints = false
//
//        //yearHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        //yearHeader.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        //yearHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        //yearHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//
//
//        yearLabel = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50))
//        yearLabel.text = "YEAR"
//        yearLabel.backgroundColor = .white
//        yearLabel.textAlignment = .center
//        yearLabel.font = UIFont(name: yearLabel.font.fontName, size: 20)
//        yearHeader.addSubview(yearLabel)
//
//
//
//        weekview = UIView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50))
//
//        weekStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        weekStackView.axis = .horizontal
//        weekStackView.alignment = .fill
//        weekStackView.distribution = .fill
//        weekStackView.backgroundColor = .red
//        let label = UILabel()
//        label.text = "Text"
//        label.backgroundColor = .yellow
//        weekStackView.addArrangedSubview(label)
//        self.view.addSubview(weekStackView)
//    }
//
//    func configureWeekStackView(){
//        let backgroundView = UIView()
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundView.backgroundColor = .red
//
//        //let weeklyStackView = UIStackView(arrangedSubviews: createWeekdaysLabel())
//    }
//
//    func createWeekdaysLabel() -> [UILabel]{
//        var weekdaysLabel = [UILabel]()
//        var mon = UILabel(frame: CGRect(x: 100, y: 100, width: 500, height: 500)).text = "Mon"
//        //weekdaysLabel.append(mon)
////        weekdaysLabel.append(UILabel(frame: CGRect(x: 100, y: 100, width: 500, height: 500)).text = "Tue")
////        weekdaysLabel.append(UILabel(frame: CGRect(x: 100, y: 100, width: 500, height: 500)).text = "Web")
////        weekdaysLabel.append(UILabel(frame: CGRect(x: 100, y: 100, width: 500, height: 500)).text = "Thu")
////        weekdaysLabel.append(UILabel(frame: CGRect(x: 100, y: 100, width: 500, height: 500)).text = "Fri")
////        weekdaysLabel.append(UILabel(frame: CGRect(x: 100, y: 100, width: 500, height: 500)).text = "Sat")
////        weekdaysLabel.append(UILabel(frame: CGRect(x: 100, y: 100, width: 500, height: 500)).text = "Sun")
//        return weekdaysLabel
//
//    }
}


protocol EcCalendarCollectionDelegate: class{
    func didScroll(to position: CGFloat)
}
