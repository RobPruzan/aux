//
//  TabBarViewController.swift
//  aux
//
//  Created by Robert Pruzan on 5/19/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen1 = HomeViewController()
        let screen2 = ProfileViewController()
        screen1.title = "Home"
        screen2.title = "Profile"
        
        screen1.navigationItem.largeTitleDisplayMode = .always
        screen2.navigationItem.largeTitleDisplayMode = .always
        
        
        let nav1 = UINavigationController(rootViewController: screen1)
        let nav2 = UINavigationController(rootViewController: screen2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: false)
    }
}
