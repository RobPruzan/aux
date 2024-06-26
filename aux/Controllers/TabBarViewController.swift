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
        
        let screen1 = CreateQueue()
        let screen2 = ActiveQueues()
        
                
        screen1.navigationItem.largeTitleDisplayMode = .always
        screen2.navigationItem.largeTitleDisplayMode = .always
        
        screen1.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        screen2.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet.fill")
        )
        
        let nav1 = UINavigationController(rootViewController: screen1)
        let nav2 = UINavigationController(rootViewController: screen2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: false)
    }
}
