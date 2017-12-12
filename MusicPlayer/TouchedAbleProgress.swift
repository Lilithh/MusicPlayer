//
//  TouchedAbleProgress.swift
//  MusicPlayer
//
//  Created by wyh on 2017/12/11.
//  Copyright © 2017年 wyh. All rights reserved.
//

import UIKit

class TouchedAbleProgress: UIProgressView {
    let slideSquare = UIView()
    var delegate: MyProgressDelegate?
    var touchedPercent: Float?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        slideSquare.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        slideSquare.layer.cornerRadius = 5
        slideSquare.backgroundColor = .blue
        slideSquare.center = CGPoint(x: CGFloat(self.progress)*self.bounds.size.width, y: self.bounds.size.height/2)
        self.trackImage = UIImage(named: "short")
        
        self.addSubview(slideSquare)
        self.isUserInteractionEnabled = true
        let tapOnMe = UITapGestureRecognizer(target: self, action: #selector(taptap(tapOnMe:)))  //注意这个写的方法
        tapOnMe.numberOfTapsRequired = 1
        tapOnMe.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapOnMe)
    }

    @objc func taptap(tapOnMe: UITapGestureRecognizer) {
        let touchPoint = tapOnMe.location(in: self)
        self.touchedPercent = Float(touchPoint.x/self.bounds.size.width)
        if delegate != nil {
            self.delegate?.transChanged(progress: self, value: self.touchedPercent!)
            print("tapped there")
        } else {
            print("delegate error")
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}



