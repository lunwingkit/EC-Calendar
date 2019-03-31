//
//  CalendarViewCell.swift
//  Project1
//
//  Created by LUN WING KIT on 25/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class CalendarViewCell: UICollectionViewCell {

//    var weekDay: Int
//    var year: Int
//    var month: Int
//    var day: Int
    var date: Date!
    var indexPath: IndexPath!
    var year: Int = 0
    var month: Int = 0 //Starti from 1
    var day: Int = 0 //Start from 1
    var dayInWeek: Int = 0 //1 Meaning Monday, 7 Meaning Sunday
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

class CircleView: UIView {
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.addEllipse(in: rect)
        context.setFillColor(UIColor.lightGray.cgColor)
        context.fillPath()
    }
    
    
}
