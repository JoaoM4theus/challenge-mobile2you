//
//  Extension.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 23/09/21.
//

import UIKit

var activityController: UIView? = nil
var labelActivity: UILabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 30.0))

extension UIViewController {
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    func showActivity(){
        if activityController == nil {
            activityController = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
            activityController?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
            let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            activity.center = (activityController?.center)!
            activity.startAnimating()
            
            labelActivity.frame.size.width = (activityController?.bounds.width ?? 0.0) * 0.9
            labelActivity.center = (activityController?.center)!
            labelActivity.frame.origin.x = ((activityController?.bounds.width ?? 0.0) - labelActivity.bounds.width)/2
            labelActivity.frame.origin.y = activity.frame.origin.y + activity.bounds.height + 8
            labelActivity.text = "Carregando..."
            labelActivity.textAlignment = .center
            labelActivity.textColor = UIColor.white
            
            activityController?.addSubview(labelActivity)
            activityController?.addSubview(activity)
        }
        
        guard let navigationController = self.navigationController else {
            DispatchQueue.main.async {
                self.view.addSubview(activityController!)
            }
            return
        }
        
        DispatchQueue.main.async {
            navigationController.view.addSubview(activityController!)
        }
    }
    
    func hideActivity(){
        DispatchQueue.main.async {
            activityController?.removeFromSuperview()
        }
    }
}
