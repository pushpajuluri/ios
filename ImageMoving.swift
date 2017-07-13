//
//  ImageMoving.swift
//  MovingImageSlider
//
//  Created by OMNIWYSE on 7/13/17.
//  Copyright © 2017 myschool. All rights reserved.
//

import UIKit
public protocol SliderPositionDelegate{
    func  sliderPosition(sender: UISlider)
}


class ImageMoving: UIView {
    var delegate:SliderPositionDelegate?
    var sliderPositionBlock:((CGFloat)->Void)?
    var sliderDemo:UISlider!
    
    override func draw(_ rect: CGRect) {
        prepareSlider(rect: rect)
    }
    
    func prepareSlider(rect: CGRect)
    {
         sliderDemo = UISlider(frame:rect)
        sliderDemo.minimumValue = 0
        sliderDemo.maximumValue = Float(UIScreen.main.bounds.size.width)
        sliderDemo.isContinuous = true
        sliderDemo.tintColor = UIColor.red
        sliderDemo.value = 50
        sliderDemo.maximumTrackTintColor = UIColor.gray
        sliderDemo.addTarget(self, action: #selector(ImageMoving.sliderChanged), for: UIControlEvents.valueChanged)
        self.addSubview(sliderDemo)
    }
    func sliderChanged() {
    let selectedPosition  = CGFloat(sliderDemo.value)
//        if let deleg = self.delegate{
//            deleg.sliderPosition(sender: selectedPosition)
//        }
        if let sliderpositionedBlock = self.sliderPositionBlock {
            sliderpositionedBlock(selectedPosition)
        
        }
    
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
