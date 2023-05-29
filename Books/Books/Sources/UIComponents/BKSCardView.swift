//
//  BKSCardView.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 26/05/23.
//


import UIKit

class BKSCardView: UIView {

        override func layoutSubviews() {
            super.layoutSubviews()
    
            self.backgroundColor = .cardBackgroundColor
            //self.layer.cornerRadius = 5
        }
}

class BKSShadowCard: BKSCardView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = false
    }
}
