//
//  CalendarCollectionViewData.swift
//  Project1
//
//  Created by LUN WING KIT on 26/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class CalendarCollectionViewDD: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var calendarCollectionView: UICollectionView!
    
    var ecCalendarCollectionDelegate: EcCalendarCollectionDelegate?
    
    let monthLength = [31,28,31,30,31,30,31,31,30,31,30,31]
    let firstWeekdayInMonth = [2,5,5,1,3,6,1,4,0,2,5,0]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthLength[section] + firstWeekdayInMonth[section]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarViewCell
        
        if let selectedView = cell.contentView.subviews[0] as? UIView{
            selectedView.alpha = 0.5
        }
        
        print(cell.year)
        print(cell.month)
        print(cell.day)
        print(cell.dayInWeek)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let selectedView = cell?.contentView.subviews[0]{
            selectedView.alpha = 0
        }
    }
    
//    private var lastContentOffset: CGFloat = 0
//    var pageIndex = 0;
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if (self.lastContentOffset > scrollView.contentOffset.y) {
//            print("UP")
//            pageIndex -= 1
//            if(pageIndex < 0){
//                pageIndex = 0
//            }
//            print(pageIndex)
//        }
//        else if (self.lastContentOffset < scrollView.contentOffset.y) {
//            print("Down")
//            pageIndex += 1
//            if(pageIndex > 12){
//                pageIndex = 12
//            }
//            print(pageIndex)
//        }
//
//        // update the new position acquired
////        let numInRow = 7
////        let rowNum = Int((Double(monthLength[pageIndex]) / Double(numInRow)).rounded(.up))
////        let height = CGFloat(rowNum * 50)
////
////        calendarCollectionView.frame = CGRect(origin: calendarCollectionView.frame.origin, size: CGSize(width: calendarCollectionView.frame.width, height: height))
////        print(rowNum)
////        self.lastContentOffset = scrollView.contentOffset.y
//    }
    
    var currentSection = 0
    var lastContentOffset: CGFloat = 0
    var scrollDirection: String!
    
    var yearLabel: UILabel!
    var monthLabel: UILabel!
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
//        currentSection = calendarCollectionView.visibleCells.first!
//        if(self.lastContentOffset > scrollView.contentOffset.y){
//            scrollDirection = "Up"
//            currentSection += 1
//        }else if(self.lastContentOffset < scrollView.contentOffset.y){
//            scrollDirection = "Down"
//            currentSection -= 1
//        }
//        self.lastContentOffset = scrollView.contentOffset.y
        currentSection = calendarCollectionView.indexPathsForVisibleItems.first!.section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarViewCell
        
        if (indexPath.item < firstWeekdayInMonth[indexPath.section])
        {
            cell.isHidden = true
        }
        else{
            cell.isHidden = false
            
            cell.year = 2019
            cell.month = indexPath.section + 1
            cell.day = indexPath.row + 1 - firstWeekdayInMonth[indexPath.section]
            cell.dayInWeek = (indexPath.row) % 7 + 1
            
            if let textLabel = cell.contentView.subviews[1] as? UILabel{
                textLabel.text = "\(indexPath.row + 1 - firstWeekdayInMonth[indexPath.section])"
            }
            
            if let selectedView = cell.contentView.subviews[0] as? UIView{
                selectedView.alpha = 0
            }
        }
        
        return cell
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("Will Dec")
        print(calendarCollectionView.indexPathsForVisibleItems.first!.section)
        currentSection = calendarCollectionView.indexPathsForVisibleItems.first!.section
        calendarCollectionView.scrollToItem(at: IndexPath(row: 0, section: currentSection), at: UICollectionView.ScrollPosition.top, animated: false)
        calendarCollectionView.reloadData()
        if let textLabel =  yearLabel{
            textLabel.text = "2019"
        }
        if let textLabel =  monthLabel{
            textLabel.text = DateForm.getMonth(num: currentSection + 1)
        }
        let numInRow = 7
        let cellCount = calendarCollectionView.numberOfItems(inSection: currentSection)
        let rowNum = ceil(Double(cellCount) / Double(numInRow))
        let height = CGFloat(rowNum * 50) //Hard Coded cell height
        
        calendarCollectionView.frame = CGRect(origin: calendarCollectionView.frame.origin, size: CGSize(width: calendarCollectionView.frame.width, height: height))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ecCalendarCollectionDelegate?.didScroll(to: scrollView.contentOffset.y)
    }
}


class DateForm{
    static func getMonth(num: Int) -> String{
        switch(num){
            
        case 1:
            return "January";
        case 2:
            return "February";
        case 3:
            return "March";
        case 4:
            return "April";
        case 5:
            return "May";
        case 6:
            return "June";
        case 7:
            return "July";
        case 8:
            return "August";
        case 9:
            return "September";
        case 10:
            return "October";
        case 11:
            return "November";
        case 12:
            return "December";
        default:
            return "ERR"
            
        }
    }
}
