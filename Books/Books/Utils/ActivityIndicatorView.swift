//
//  ActivityIndicatorView.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 26/05/23.
//

import UIKit

class ActivityIndicatorView {
    
    static var vSpinner : UIView?
    
    class func showActivityIndicatorView(onView : UIView) {
        vSpinner?.removeFromSuperview()
        vSpinner = nil
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = UIColor.clear
        let ai = UIActivityIndicatorView.init(style: .medium)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            vSpinner = spinnerView
        }
    }
    
    class func removeActivityIndicatorView() {
       DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
