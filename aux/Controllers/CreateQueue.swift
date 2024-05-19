//
//  HomeViewController.swift
//  aux
//
//  Created by Robert Pruzan on 5/19/24.
//

import UIKit

class CreateQueue: UIViewController {
    let createQueueButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .systemBlue
        button.setTitle("Create Queue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupCreateQueueButton()
    }
    
    func setupCreateQueueButton() {
        view.addSubview(createQueueButton)
        NSLayoutConstraint.activate([
            createQueueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createQueueButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            createQueueButton.widthAnchor.constraint(equalToConstant: 150),
            createQueueButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

