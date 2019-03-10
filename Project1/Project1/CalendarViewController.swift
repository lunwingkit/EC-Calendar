//
//  CalendarViewController.swift
//  Project1
//
//  Created by LUN WING KIT on 10/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    var yearHeader : UIView!
    var yearLabel : UILabel!
    
    var weekview: UIView!
    var weekStackView: UIStackView!
    
    override func viewDidLoad() {
        //navigationController?.navigationBar.barTintColor = .darkGray
        //navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Calendar"
        
        let ec_month = EC_Calendar.getMonth(year: 2018, month: 2)
        print(ec_month.daysInMonth)
        print(ec_month.startingWeekDay)
        let normal_month = Normal_Calender.getMonth(year: 2018, month: 2)
        print(normal_month.daysInMonth)
        print(normal_month.startingWeekDay)
        
        configureHeader()
    }
    
    func configureHeader(){
        yearHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        yearHeader.backgroundColor = .darkGray
        self.view.addSubview(yearHeader)
        
        yearHeader.translatesAutoresizingMaskIntoConstraints = false
        
        //yearHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        //yearHeader.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        //yearHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        //yearHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        
        yearLabel = UILabel(frame: yearHeader.frame)
        yearLabel.text = "YEAR"
        yearLabel.backgroundColor = .white
        yearLabel.textAlignment = .center
        yearLabel.font = UIFont(name: yearLabel.font.fontName, size: 20)
        yearHeader.addSubview(yearLabel)
        
        
        
        weekview = UIView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50))
        
        weekStackView = UIStackView(frame: self.view.frame)
        weekStackView.axis = .horizontal
        weekStackView.alignment = .fill
        weekStackView.distribution = .fill
        weekStackView.backgroundColor = .red
        let label = UILabel()
        label.text = "Text"
        label.backgroundColor = .yellow
        weekStackView.addArrangedSubview(label)
        self.view.addSubview(weekStackView)
    }
}
