//
//  ViewController.swift
//  CSTextViewTest
//
//  Created by Colton Swapp on 4/30/24.
//

import UIKit

class ViewController: UIViewController {

    lazy var button: UIButton = {
        var configuration = UIButton.Configuration.gray() // 1
        configuration.cornerStyle = .capsule // 2
        configuration.baseForegroundColor = UIColor.systemBlue
        configuration.buttonSize = .large
        configuration.title = "Show Text View"

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showTextView), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "CSTextView"
        setupButton()
    }

    private func setupButton() {
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func showTextView() {
        presentBottomTextView(placeholder: "Add an item")
    }
}

