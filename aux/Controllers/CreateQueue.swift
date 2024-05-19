//
//  HomeViewController.swift
//  aux
//
//  Created by Robert Pruzan on 5/19/24.
//

import UIKit

class CreateQueue: UIViewController {
    let mainStack = {
        let stack = UIStackView()

        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let createQueueButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .systemBlue
        button.setTitle("Create Queue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    let queueNameInput = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text here"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = UIColor.label
        textField.backgroundColor = UIColor.systemBackground
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Queue"


        view.backgroundColor = .systemBackground
        setupMainStack()
    }

    func setupMainStack() {
        view.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        setupQueueNameInput()
        setupCreateQueueButton()
    }

    func setupQueueNameInput() {
        mainStack.addArrangedSubview(queueNameInput)
        NSLayoutConstraint.activate([
            queueNameInput.widthAnchor.constraint(equalToConstant: 225),
            queueNameInput.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    func setupCreateQueueButton() {
        mainStack.addArrangedSubview(createQueueButton)
        createQueueButton.addTarget(self, action: #selector(onCreateQueue), for: .touchUpInside)
        NSLayoutConstraint.activate([
            createQueueButton.widthAnchor.constraint(equalToConstant: 225),
            createQueueButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc func onCreateQueue() {
        Task {
            do {
                let _ = try await createQueue()
            } catch {}
        }
    }

    func createQueue() async throws {
        struct Body: Codable {}
        let _ = try await APIManager.shared.post(for: "/queue", body: Body(), responseType: [AuxQueue].self)
    }
}
