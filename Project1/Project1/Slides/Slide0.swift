//
//  Slide0.swift
//  Project1
//
//  Created by Sampoison on 17/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

@IBDesignable class Slide0: UIView {
    
    var view: UIView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
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
    }
    
    @IBAction func onLearnMoreClicked(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://en.wikipedia.org/wiki/Perennial_calendar")!, options: [:])
    }
    
}
