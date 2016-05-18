//
//  ViewController.swift
//  ToastForSwift
//
//  Created by Mac on 16/5/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tView:Toast_UIView!
    var button:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tView = Toast_UIView()
        tView.backgroundColor = UIColor.whiteColor()
        self.view = tView;
        
        button = UIButton(frame: CGRectMake(0,100,200,40))
        button.backgroundColor = UIColor.redColor()
        button.setTitle("show Toast", forState: UIControlState.Normal)
        button.addTarget(self, action:#selector(ViewController.showToast(_:)) , forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        button.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height/2)
        
    }

    func showToast(uibutton:UIButton) -> Void {
        tView.makeToast("Toast Test", value: "", color: UIColor.redColor())
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

