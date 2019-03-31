//
//  Slide2.swift
//  Project1
//
//  Created by Sampoison on 24/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

@IBDesignable class Slide2: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var view: UIView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var monthPicker: UIPickerView!
    
    @IBOutlet weak var ecCollectionView: UICollectionView!
    @IBOutlet weak var normalCollectionView: UICollectionView!
    
    var yearArray: [String]
    var monthArray: [String]
    
    var currentYear: Int
    var currentMonth: Int
    
    var ec_calendarArray: [String]
    var normal_calendarArray: [String]
    
    required public init?(coder aDecoder: NSCoder) {
        
        self.yearArray = [String]()
        for i in (1970..<2020).reversed() {
            self.yearArray.append("\(i)")
        }
        self.monthArray = [String]()
        for i in (1...12) {
            self.monthArray.append("\(i)")
        }
        
        self.currentYear = 2019
        self.currentMonth = 4
        
        let ec_month = EC_Calendar.getMonth(year: currentYear, month: currentMonth);
        ec_calendarArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
        
        for i in 1..<ec_month.startingWeekDay {
            ec_calendarArray.append("")
        }
        for i in 1...ec_month.daysInMonth {
            ec_calendarArray.append(String(i))
        }
        
        let normal_month = Normal_Calender.getMonth(year: currentYear, month: currentMonth);
        normal_calendarArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
        
        for i in 1..<normal_month.startingWeekDay {
            normal_calendarArray.append("")
        }
        for i in 1...normal_month.daysInMonth {
            normal_calendarArray.append(String(i))
        }
        
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        
        self.yearArray = [String]()
        for i in (1970..<2020).reversed() {
            self.yearArray.append("\(i)")
        }
        self.monthArray = [String]()
        for i in (1...12) {
            self.monthArray.append("\(i)")
        }
        
        self.currentYear = 2019
        self.currentMonth = 3
        
        let ec_month = EC_Calendar.getMonth(year: currentYear, month: currentMonth);
        ec_calendarArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
        
        for i in 1..<ec_month.startingWeekDay {
            ec_calendarArray.append("")
        }
        for i in 1...ec_month.daysInMonth {
            ec_calendarArray.append(String(i))
        }
        
        let normal_month = Normal_Calender.getMonth(year: currentYear, month: currentMonth);
        normal_calendarArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
        
        for i in 1..<normal_month.startingWeekDay {
            normal_calendarArray.append("")
        }
        for i in 1...normal_month.daysInMonth {
            normal_calendarArray.append(String(i))
        }
        
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    func getCalendarArrays() {
        
        let ec_month = EC_Calendar.getMonth(year: currentYear, month: currentMonth);
        ec_calendarArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
        
        for i in 1..<ec_month.startingWeekDay {
            ec_calendarArray.append("")
        }
        for i in 1...ec_month.daysInMonth {
            ec_calendarArray.append(String(i))
        }
        
        let normal_month = Normal_Calender.getMonth(year: currentYear, month: currentMonth);
        normal_calendarArray = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
        
        for i in 1..<normal_month.startingWeekDay {
            normal_calendarArray.append("")
        }
        for i in 1...normal_month.daysInMonth {
            normal_calendarArray.append(String(i))
        }
        
    }
    
    func loadViewFromNib() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
        
        yearPicker.dataSource = self
        yearPicker.delegate = self
        monthPicker.dataSource = self
        monthPicker.delegate = self
        
        let calendarNib = UINib(nibName: "CalendarCell", bundle:nil)
        ecCollectionView.register(calendarNib, forCellWithReuseIdentifier: "calendarCell")
        normalCollectionView.register(calendarNib, forCellWithReuseIdentifier: "calendarCell")
        
        let itemSize = (UIScreen.main.bounds.width - 32) / 7
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: itemSize, height: 22)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let layout2 = UICollectionViewFlowLayout()
        
        layout2.itemSize = CGSize(width: itemSize, height: 22)
        layout2.minimumInteritemSpacing = 0
        layout2.minimumLineSpacing = 0
        
        ecCollectionView.collectionViewLayout = layout
        normalCollectionView.collectionViewLayout = layout2
        
        ecCollectionView.dataSource = self
        ecCollectionView.delegate = self
        normalCollectionView.dataSource = self
        normalCollectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case ecCollectionView:
            return ec_calendarArray.count
        case normalCollectionView:
            return normal_calendarArray.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        switch collectionView {
        case ecCollectionView:
            if(indexPath.row < 7) {
                cell.label.textColor = UIColor.gray;
            } else {
                cell.label.textColor = UIColor(red: 0, green: 117/255, blue: 255/255, alpha: 1);
            }
            cell.label.text = ec_calendarArray[indexPath.row]
            return cell
        case normalCollectionView:
            if(indexPath.row < 7) {
                cell.label.textColor = UIColor.gray;
            } else {
                cell.label.textColor = UIColor(red: 130/255, green: 0, blue: 255/255, alpha: 1);
            }
            cell.label.text = normal_calendarArray[indexPath.row]
            return cell
        default:
            cell.label.text = ""
            return cell
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case yearPicker:
            return self.yearArray.count
        case monthPicker:
            return self.monthArray.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case yearPicker:
            return self.yearArray[row]
        case monthPicker:
            return self.monthArray[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case yearPicker:
            
            self.currentYear = Int(self.yearArray[row])!

            getCalendarArrays()
            
            ecCollectionView.reloadData()
            normalCollectionView.reloadData()
            
        case monthPicker:
            
            self.currentMonth = Int(self.monthArray[row])!

            getCalendarArrays()
            
            ecCollectionView.reloadData()
            normalCollectionView.reloadData()
            
        default:
            print("How did this happened")
        }
    }
    
}
