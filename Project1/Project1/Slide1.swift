//
//  Slide1.swift
//  Project1
//
//  Created by Sampoison on 17/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class Slide1: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var view: UIView!
    
    @IBOutlet weak var festivalPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBOutlet weak var ECLabel: UILabel!
    @IBOutlet weak var NormalLabel: UILabel!
    
    var festivalArray: [Festival]
    var yearArray: [String]
    
    var currentYear: Int
    var currentFestival: Festival
    
    required public init?(coder aDecoder: NSCoder) {
        
        self.festivalArray = [
            Festival(name: "Father's Day", month: 6, day: nil, dayOfWeek: 7, dayOfWeekIndex: 2),
            Festival(name: "Mother's Day", month: 5, day: nil, dayOfWeek: 7, dayOfWeekIndex: 1)
        ]
        self.yearArray = [String]()
        for i in (1970..<2020).reversed() {
            self.yearArray.append("\(i)")
        }
        
        self.currentYear = Int(self.yearArray[0])!
        self.currentFestival = self.festivalArray[0]
        
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        
        self.festivalArray = [
            Festival(name: "Father's Day", month: 6, day: nil, dayOfWeek: 7, dayOfWeekIndex: 2),
            Festival(name: "Mother's Day", month: 5, day: nil, dayOfWeek: 7, dayOfWeekIndex: 1)
        ]
        self.yearArray = [String]()
        for i in (1970..<2020).reversed() {
            self.yearArray.append("\(i)")
        }
        
        self.currentYear = Int(self.yearArray[0])!
        self.currentFestival = self.festivalArray[0]
        
        super.init(frame: frame)
        loadViewFromNib()
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
        
        festivalPicker.delegate = self
        festivalPicker.dataSource = self
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        
        self.ECLabel.text = EC_Calendar.getDayByDayOfWeek(year: currentYear, month: currentFestival.month!, dayofWeek: currentFestival.dayOfWeek!, dayofWeekIndex: currentFestival.dayOfWeekIndex!)
        self.NormalLabel.text = Normal_Calender.getDayByDayOfWeek(year: currentYear, month: currentFestival.month!, dayofWeek: currentFestival.dayOfWeek!, dayofWeekIndex: currentFestival.dayOfWeekIndex!)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case festivalPicker:
            return self.festivalArray.count
        case yearPicker:
            return self.yearArray.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case festivalPicker:
            return self.festivalArray[row].name
        case yearPicker:
            return self.yearArray[row]
        default:
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case festivalPicker:
            
            self.currentFestival = self.festivalArray[row]
            
            self.ECLabel.text = EC_Calendar.getDayByDayOfWeek(year: currentYear, month: currentFestival.month!, dayofWeek: currentFestival.dayOfWeek!, dayofWeekIndex: currentFestival.dayOfWeekIndex!)
            self.NormalLabel.text = Normal_Calender.getDayByDayOfWeek(year: currentYear, month: currentFestival.month!, dayofWeek: currentFestival.dayOfWeek!, dayofWeekIndex: currentFestival.dayOfWeekIndex!)
            
        case yearPicker:
            
            self.currentYear = Int(self.yearArray[row])!

            self.ECLabel.text = EC_Calendar.getDayByDayOfWeek(year: currentYear, month: currentFestival.month!, dayofWeek: currentFestival.dayOfWeek!, dayofWeekIndex: currentFestival.dayOfWeekIndex!)
            self.NormalLabel.text = Normal_Calender.getDayByDayOfWeek(year: currentYear, month: currentFestival.month!, dayofWeek: currentFestival.dayOfWeek!, dayofWeekIndex: currentFestival.dayOfWeekIndex!)
            
        default:
            print("How did this happened")
        }
    }

}

class Festival {
    
    var name: String
    var month: Int?
    var day: Int?
    var dayOfWeek: Int?
    var dayOfWeekIndex: Int?
    
    init(name: String, month: Int?, day: Int?, dayOfWeek: Int?, dayOfWeekIndex: Int?) {
        
        self.name = name
        self.month = month
        self.day = day
        self.dayOfWeek = dayOfWeek
        self.dayOfWeekIndex = dayOfWeekIndex
        
    }
    
}
