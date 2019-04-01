//
//  CalendarCollectionViewData.swift
//  Project1
//
//  Created by LUN WING KIT on 26/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class CalendarCollectionViewDD: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var ecCalendarCollectionView: UICollectionView!
    var calendarCollectionView: UICollectionView!
    
    var ecYear: [Month] = []
    var year: [Month] = []
    
    var ecYearLabel: UILabel!
    var ecMonthLabel: UILabel!
    var yearLabel: UILabel!
    var monthLabel: UILabel!
    
    var currentSection = 0
    
    required public init?(coder aDecoder: NSCoder) {
        ecCalendarHiddenCellCount = 0
        calendarHiddenCellCount = 0
        super.init(coder: aDecoder)
        
        for i in 1...12 {
            ecYear.append(EC_Calendar.getMonth(year: 2019, month: i))
            year.append(Normal_Calender.getMonth(year: 2019, month: i))
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case ecCalendarCollectionView:
            return ecYear[section].daysInMonth + ecYear[section].startingWeekDay - 1
        case calendarCollectionView:
            return year[section].daysInMonth + year[section].startingWeekDay - 1
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
        
    }
    
    var ecCalendarHiddenCellCount: Int
    var calendarHiddenCellCount: Int
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarViewCell
        
        if let selectedView = cell.contentView.subviews[0] as? UIView{
            selectedView.alpha = 0.5
        }
        
        ecCalendarHiddenCellCount = 0
        for cell in ecCalendarCollectionView.visibleCells{
            if(cell.isHidden)
            {
                ecCalendarHiddenCellCount = ecCalendarHiddenCellCount + 1
            }
        }
        
       calendarHiddenCellCount = 0
        for cell in calendarCollectionView.visibleCells{
            if(cell.isHidden)
            {
                calendarHiddenCellCount = calendarHiddenCellCount + 1
            }
        }
        
        switch collectionView{
        case calendarCollectionView:
            ecCalendarCollectionView.cellForItem(at: IndexPath(row: indexPath.row - calendarHiddenCellCount + ecCalendarHiddenCellCount, section: indexPath.section))?.contentView.subviews[0].alpha = 0.5
        case ecCalendarCollectionView:
            calendarCollectionView.cellForItem(at: IndexPath(row: indexPath.row + calendarHiddenCellCount - ecCalendarHiddenCellCount, section: indexPath.section))?.contentView.subviews[0].alpha = 0.5
            
        default: break
            
        }
        
        
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let selectedView = cell?.contentView.subviews[0]{
            selectedView.alpha = 0
        }
        
        for cell in ecCalendarCollectionView.visibleCells{
            cell.contentView.subviews[0].alpha = 0
        }
        for cell in calendarCollectionView.visibleCells{
            cell.contentView.subviews[0].alpha = 0
        }
//        switch collectionView{
//        case calendarCollectionView:
//            for cell in ecCalendarCollectionView.visibleCells{
//                cell.contentView.subviews[0].alpha = 0
//            }
////            ecCalendarCollectionView.cellForItem(at: IndexPath(row: indexPath.row - calendarHiddenCellCount + ecCalendarHiddenCellCount, section: indexPath.section))?.contentView.subviews[0].alpha = 0
//        case ecCalendarCollectionView:
//            for cell in calendarCollectionView.visibleCells{
//                cell.contentView.subviews[0].alpha = 0
//            }
////            calendarCollectionView.cellForItem(at: IndexPath(row: indexPath.row + calendarHiddenCellCount - ecCalendarHiddenCellCount, section: indexPath.section))?.contentView.subviews[0].alpha = 0
//
//        default: break
//
//        }
        ecCalendarHiddenCellCount = 0
        calendarHiddenCellCount = 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarViewCell
        
        var month: Month;
        
        switch collectionView {
        case ecCalendarCollectionView:
            month = self.ecYear[indexPath.section]
        case calendarCollectionView:
            month = self.year[indexPath.section]
        default:
            month = self.year[indexPath.section]
        }
        
        if (indexPath.row < month.startingWeekDay - 1) {
            cell.isHidden = true
        }
        else{
            
            cell.isHidden = false
            
            cell.year = 2019
            cell.month = indexPath.section + 1
            cell.day = indexPath.row - month.startingWeekDay + 2
            cell.dayInWeek = (indexPath.row) % 7 + 1
            
            if let textLabel = cell.contentView.subviews[1] as? UILabel{
                textLabel.text = "\(indexPath.row - month.startingWeekDay + 2)"
            }
            
            if let selectedView = cell.contentView.subviews[0] as? UIView{
                selectedView.alpha = 0
            }
        }
        
        return cell
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDragging")
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scrollViewDidScroll")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndDecelerating")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        switch scrollView {
        case self.ecCalendarCollectionView:
            currentSection = ecCalendarCollectionView.indexPathsForVisibleItems.first!.section
        case self.calendarCollectionView:
            currentSection = calendarCollectionView.indexPathsForVisibleItems.first!.section
        default:
            print("what happened")
        }

        if let ecTextLabel = ecMonthLabel{
            ecTextLabel.text = Custom_Calender.getMonthStringFromInt(int: currentSection + 1)
        }
        if let textLabel = monthLabel{
            textLabel.text = Custom_Calender.getMonthStringFromInt(int: currentSection + 1)
        }

        updateLayout()

    }
    
    func updateLayout() {
        
        let itemSize = (UIScreen.main.bounds.width) / 7
        
        let layout = UICollectionViewFlowLayout()
        
        let ecCellCount = ecCalendarCollectionView.numberOfItems(inSection: currentSection)
        let ecCellHeight = CGFloat(250 / ceil(Double(ecCellCount) / 7))
        
        layout.itemSize = CGSize(width: itemSize, height: ecCellHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0;
        
        let layout2 = UICollectionViewFlowLayout()
        
        let cellCount = calendarCollectionView.numberOfItems(inSection: currentSection)
        let cellHeight = CGFloat(250 / ceil(Double(cellCount) / 7))
        
        layout2.itemSize = CGSize(width: itemSize, height: cellHeight)
        layout2.minimumLineSpacing = 0
        layout2.minimumInteritemSpacing = 0;
        
        ecCalendarCollectionView.collectionViewLayout = layout
        calendarCollectionView.collectionViewLayout = layout2
        
        ecCalendarCollectionView.collectionViewLayout.invalidateLayout()
        calendarCollectionView.collectionViewLayout.invalidateLayout()
        
        ecCalendarCollectionView.scrollToItem(at: IndexPath(row: 0, section: currentSection), at: UICollectionView.ScrollPosition.top, animated: true)
        calendarCollectionView.scrollToItem(at: IndexPath(row: 0, section: currentSection), at: UICollectionView.ScrollPosition.top, animated: true)
        
        ecCalendarHiddenCellCount = 0
        for cell in ecCalendarCollectionView.visibleCells{
            if(cell.isHidden)
            {
                ecCalendarHiddenCellCount += ecCalendarHiddenCellCount
            }
        }
    
        calendarHiddenCellCount = 0
        for cell in calendarCollectionView.visibleCells{
            if(cell.isHidden)
            {
                calendarHiddenCellCount += calendarHiddenCellCount
            }
        }
    }
}


