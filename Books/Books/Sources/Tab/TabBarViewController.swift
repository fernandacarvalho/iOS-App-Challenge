//
//  TabBarViewController.swift
//  Books
//
//  Created by Fernanda FC. Carvalho on 27/06/23.
//

import Foundation
import UIKit

final class TabBarViewController: UITabBarController {
    private var homeNavigation: UINavigationController!
    private var profileNavigation: UINavigationController!
    private var tabControllers = [UINavigationController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAppearance()
        self.setup()
    }
    
    func setup() {
        self.setHome()
        self.setProfile()
        if self.tabControllers.count > 0 {
            self.viewControllers = self.tabControllers
            self.selectedIndex = 0
        }
    }
    
    func setAppearance() {
        self.view.backgroundColor = .backgroundColor
        self.tabBar.backgroundColor = .backgroundColor
        self.tabBar.barTintColor = .backgroundColor
        UITabBar.appearance().tintColor = .accentColor
        UITabBar.appearance().unselectedItemTintColor = .secondaryTextColor
        let font = UIFont.systemFont(ofSize: 12)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
    
    func setHome() {
        let homeController = BookListViewController()
        homeNavigation = UINavigationController(rootViewController: homeController)
        homeNavigation.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage.init(systemName: "book.circle"),
            selectedImage: UIImage.init(systemName: "book.circle.fill")
        )
        self.tabControllers.append(homeNavigation)
    }
    
    func setProfile() {
        let profileController = UIViewController()
        profileNavigation = UINavigationController(rootViewController: profileController)
        profileNavigation.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage.init(systemName: "person.circle"),
            selectedImage: UIImage.init(systemName: "person.circle.fill")
        )
        self.tabControllers.append(profileNavigation)
    }
}
