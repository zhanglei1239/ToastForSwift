//
//  Toast+UIView.swift
//  RegularExpressionForSwift
//
//  Created by Mac on 16/5/16.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

import UIKit
import CoreText
class Toast_UIView: UIView {

    // general appearance
    let CSToastMaxWidth: CGFloat = 0.8      // 80% of parent view width
    let CSToastMaxHeight: CGFloat = 0.8     // 80% of parent view height
    let CSToastHorizontalPadding: CGFloat = 10.0
    let CSToastVerticalPadding: CGFloat = 10.0
    let CSToastCornerRadius: CGFloat = 10.0
    let CSToastOpacity: CGFloat = 0.8
    let CSToastFontSize: CGFloat = 16.0
    let CSToastMaxTitleLines: NSInteger = 0
    let CSToastMaxMessageLines: NSInteger = 0
    let CSToastFadeDuration: CGFloat = 0.2
    
    // shadow appearance
    let CSToastShadowOpacity: Float = 0.5
    let CSToastShadowRadius: CGFloat = 6.0
    let CSToastShadowOffset: CGSize = CGSizeMake(4.0, 4.0)
    let CSToastDisplayShadow: Bool = true
    
    // display duration and position
    let CSToastDefaultDuration: CGFloat = 1.0
    let CSToastDefaultPosition: String = "center"
    
    // image view size
    let CSToastImageViewWidth: CGFloat = 80.0
    let CSToastImageViewHeight: CGFloat = 80.0
    
    // activity
    let CSToastActivityWidth: CGFloat = 100.0
    let CSToastActivityHeight: CGFloat = 100.0

    let CSToastActivityDefaultPosition: String = "center"
    let CSToastActivityViewKey: String = "CSToastActivityViewKey"
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    func makeToast(message:String , value:String , color:UIColor) -> Void {
        self.makeToast(message, duration: CSToastDefaultDuration, position: CSToastDefaultPosition, color: color, value: value)
    }
    
    func makeToast(message:String , duration:CGFloat , position:AnyObject , color:UIColor , value:String) -> Void {
        let toast = self.viewForMessage(message, title: "", image: nil, color: color, value: value)
        self.showToast(toast, duration: duration, postion: position)
    }
    
    func makeToast(message:String , duration:CGFloat , position:AnyObject , title:String , color:UIColor , value:String) -> Void {
        let toast = self.viewForMessage(message, title: title, image: nil, color: color, value: value)
        self.showToast(toast, duration: duration, postion: position)
    }
    
    func  makeToast(message:String , duration:CGFloat , position:AnyObject , image:UIImage , color:UIColor , value:String) -> Void {
        let toast = self.viewForMessage(message, title: "", image: image, color: color, value: value)
        self.showToast(toast, duration: duration, postion: position)
    }
    
    func makeToast(message: String , duration:CGFloat , postion: String , image: UIImage , textColor:UIColor , value:String) -> Void {
        let t = self.viewForMessage(message, title: "", image: image, color: textColor, value: value)
        self.showToast(t, duration: duration, postion: postion)
    }
    
    func showToast(toast:UIView , duration:CGFloat , postion:AnyObject) -> Void {
        toast.center = self.centerPointForPosition(postion, view: toast)
        self.addSubview(toast)
        toast.alpha = 0
        UIView.animateWithDuration(1, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            
            toast.alpha = 1.0
        }) { (finish:Bool) in
            UIView.animateWithDuration(0.8, delay: 1.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    toast.center = CGPointMake(toast.center.x, toast.center.y-60);
                    toast.alpha = 0.0;
                }, completion: { (finish:Bool) in
                    toast.removeFromSuperview();
            })
        }
    }
    
    func centerPointForPosition(p:AnyObject , view:UIView) -> CGPoint {
        if p is String {
            if p as! String == "center" {
                return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
            }else if p as! String == "top"{
                return CGPointMake(self.bounds.size.width/2, view.frame.size.height/2)
            }else if p as! String == "bottom"{
                return CGPointMake(self.bounds.size.width/2, self.bounds.size.height-(view.frame.size.height/2))
            }
        }else if p  is NSValue{
            return p.CGPointValue();
        }
        
        return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
    }
    
    func viewForMessage(message:String , title:String , image:UIImage? , color:UIColor , value:String) -> UIView {
        // sanity
        if (message == "") && (title == "")&&(image == "") {
            return UIView()
        }
        
        // dynamically build a toast view with any combination of message, title, & image.
        var messageLabel: UILabel?
        var titleLabel: UILabel?
        var imageView: UIImageView?
        var warpperView: UIView
        
        
        warpperView = UIView();
        warpperView.autoresizingMask = [.FlexibleTopMargin,.FlexibleBottomMargin,.FlexibleLeftMargin,.FlexibleRightMargin]
        
        warpperView.layer.cornerRadius = CSToastCornerRadius
        
        if CSToastDisplayShadow {
            warpperView.layer.shadowColor = UIColor.blackColor().CGColor
            warpperView.layer.shadowOpacity = CSToastShadowOpacity
            warpperView.layer.shadowRadius = CSToastShadowRadius
            warpperView.layer.shadowOffset = CSToastShadowOffset
        }
        warpperView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(CSToastOpacity)
        
        var imageWidth: CGFloat = 0
        var imageHeight: CGFloat = 0
        var imageLeft: CGFloat = 0
        
        if image != nil {
            imageView = UIImageView.init(image: image)
            imageView!.contentMode = UIViewContentMode.ScaleAspectFit
            imageView!.frame = CGRectMake(CSToastHorizontalPadding, CSToastVerticalPadding, CSToastImageViewWidth, CSToastImageViewHeight)
            
            imageWidth = imageView!.bounds.size.width
            imageHeight = imageView!.bounds.size.height
            imageLeft = CSToastHorizontalPadding
        }
         
        // the imageView frame values will be used to size & position the other views
        
        var titleWidth: CGFloat = 0
        var titleHeight: CGFloat = 0
        var titleTop: CGFloat = 0
        var titleLeft: CGFloat = 0
        
        if title != "" {
            titleLabel = UILabel()
            titleLabel!.numberOfLines = CSToastMaxTitleLines
            titleLabel!.font = UIFont .boldSystemFontOfSize(CSToastFontSize)
            titleLabel!.textAlignment = NSTextAlignment.Left
            titleLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
            titleLabel!.textColor = color
            titleLabel!.backgroundColor = UIColor.clearColor()
            titleLabel!.alpha = 1.0
            titleLabel!.text = title
            
            var maxSizeTitle: CGSize
            var expectedSizeTitle: CGSize
            let text: NSString = title
            
            maxSizeTitle = CGSizeMake(self.bounds.size.width*CSToastMaxWidth-imageWidth, self.bounds.size.height*CSToastMaxHeight)
            
            let attributes = [NSFontAttributeName: titleLabel!.font]
            
            expectedSizeTitle = text.boundingRectWithSize(maxSizeTitle, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size
            titleLabel!.frame = CGRectMake(0.0,0.0, expectedSizeTitle.width, expectedSizeTitle.height)
            
            titleWidth = titleLabel!.bounds.size.width;
            titleHeight = titleLabel!.bounds.size.height;
            titleTop = CSToastVerticalPadding;
            titleLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
        }
        
        var messageWidth: CGFloat = 0
        var messageHeight: CGFloat = 0
        var messageLeft: CGFloat = 0
        var messageTop: CGFloat = 0
        
        if message != "" {
            messageLabel = UILabel()
            messageLabel!.numberOfLines = CSToastMaxMessageLines
            messageLabel!.font = UIFont.systemFontOfSize(CSToastFontSize)
            messageLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
            messageLabel!.textColor = color
            messageLabel!.backgroundColor = UIColor.clearColor()
            messageLabel!.alpha = 1.0
            messageLabel!.text = message
            
            let text: NSString = message
            
            var maxSizeMessage: CGSize
            var expectedSizeMessage: CGSize
            maxSizeMessage = CGSizeMake(self.bounds.size.width*CSToastMaxWidth-imageWidth, self.bounds.size.height*CSToastMaxHeight)
            
            let attributes = [NSFontAttributeName: messageLabel!.font]
            
            expectedSizeMessage = text.boundingRectWithSize(maxSizeMessage, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size
            messageLabel!.frame = CGRectMake(0.0,0.0, expectedSizeMessage.width, expectedSizeMessage.height)
            
            messageWidth = messageLabel!.bounds.size.width;
            messageHeight = messageLabel!.bounds.size.height;
            messageLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
            messageTop = titleTop + titleHeight + CSToastVerticalPadding;
        }
        
        
        let longerWidth: CGFloat = max(titleWidth, messageWidth)
        let longerLeft: CGFloat = max(titleLeft, messageLeft)
        
        // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
        let wrapperWidth: CGFloat = max((imageWidth + (CSToastHorizontalPadding * 2)), (longerLeft + longerWidth + CSToastHorizontalPadding))
        
        let wrapperHeight: CGFloat = max((messageTop + messageHeight + CSToastVerticalPadding), (imageHeight + (CSToastVerticalPadding * 2)));
         warpperView.frame = CGRectMake(0, 0, wrapperWidth, wrapperHeight)
        
        if titleLabel != nil {
            titleLabel?.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight)
            warpperView.addSubview(titleLabel!)
        }
        
        if messageLabel != nil {
            messageLabel?.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight)
            warpperView.addSubview(messageLabel!)
        }
        
        if imageView != nil {
            warpperView.addSubview(imageView!)
        }
        
        
        return warpperView
    }
}
