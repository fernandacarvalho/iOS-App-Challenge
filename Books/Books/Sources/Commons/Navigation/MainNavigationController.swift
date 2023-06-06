//
//  MainNavigationController.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 26/05/23.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavbarStyle()
    }

    fileprivate func setNavbarStyle() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
}

