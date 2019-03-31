//
//  SlidesController.swift
//  Project1
//
//  Created by Sampoison on 17/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class SlidesController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.frame = view.frame
        
        var slides = [UIView]();
        
        let slide0 = Slide0(frame: CGRect(x: self.view.frame.width * CGFloat(0), y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height))
        
        let slide1 = Slide1(frame: CGRect(x: self.view.frame.width * CGFloat(1), y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height))
        
        let slide2 = Slide2(frame: CGRect(x: self.view.frame.width * CGFloat(2), y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height))
        
        slides.append(slide0)
        slides.append(slide1)
        slides.append(slide2)
        
        for i in 0..<slides.count {
            scrollView.addSubview(slides[i])
        }
        
        scrollView.contentSize.width = scrollView.frame.width * CGFloat(slides.count)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        
        view.bringSubviewToFront(pageControl)
        
        view.bringSubviewToFront(self.finishButton)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
    }

    @IBAction func onFinishButtonClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "CalendarViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! UIViewController
        
        present(vc, animated: true, completion: nil)
        
        print(1)
        
    }
    
}
