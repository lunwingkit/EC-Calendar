//
//  CalendarViewController.swift
//  Project1
//
//  Created by LUN WING KIT on 10/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            textLabel.text = "\(indexPath.row)"
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.title = "Calendar"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        let date = Date()
        let calendar = Calendar.current
        yearLabel.text = String(calendar.component(.year, from: date))
        monthLabel.text = getMonth(num: calendar.component(.month, from:date))
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
