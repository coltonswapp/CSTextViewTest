//
//  CSTextView.swift
//  CSTextViewTest
//
//  Created by Colton Swapp on 4/30/24.
//

import UIKit

class CSTextView: UIViewController {

    let dimView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    let containerView = UIView()
    let textField = UITextField()
    let dismissButton = UIButton()
    let addButton = UIButton()
    let stack = UIStackView()

    let padding: CGFloat = 20

    init(placeholder: String) {
        super.init(nibName: nil, bundle: nil)
        textField.placeholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.layoutIfNeeded()

        let animator = UIViewPropertyAnimator(duration: 0.35, controlPoint1: CGPoint(x: 0.33, y: 1), controlPoint2: CGPoint(x: 0.68, y: 1), animations: {
            self.containerView.transform = .identity
        })

        animator.startAnimation()
        textField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func loadView() {
        super.loadView()
        configureContrainerView()
        configureTitleLabel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                NSLayoutConstraint.activate([
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (-keyboardSize.height + 75)),
                ])
                containerView.layoutIfNeeded()

            } else {

                NSLayoutConstraint.activate([
                containerView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
                ])
                containerView.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
            }
        }
    }

    @objc func dismissButtonTapped() {
        dismissAnimation()
        self.dismiss(animated: true)
    }

    private func dismissAnimation() {
        let animator = UIViewPropertyAnimator(duration: 0.2, controlPoint1: CGPoint(x: 0.76, y: 0.0), controlPoint2: CGPoint(x: 0.24, y: 1), animations: {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height / 2)
        })

        animator.startAnimation()
    }

    func configureContrainerView() {
        view.addSubview(dimView)
        view.addSubview(dismissButton)
        view.addSubview(containerView)

        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            dismissButton.heightAnchor.constraint(equalTo: view.heightAnchor),
            dismissButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            containerView.heightAnchor.constraint(equalToConstant: 175),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.size.width),
        ])
    }

    func configureTitleLabel() {
        containerView.addSubview(stack)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(addButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillProportionally
        textField.delegate = self

        textField.translatesAutoresizingMaskIntoConstraints = false

        addButton.translatesAutoresizingMaskIntoConstraints = false

        let config = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: config)
        addButton.setImage(image, for: .normal)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            stack.heightAnchor.constraint(equalToConstant: 70),
            addButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.15),
            addButton.heightAnchor.constraint(equalToConstant: 70)

        ])

        containerView.transform = CGAffineTransform(translationX: 0, y: view.frame.height / 2)
    }

    @objc func addTapped() {
        guard let text = textField.text,
            !text.isEmpty,
            text != "Saved" else {
            self.shake()
            return }

        dismissAnimation()
        dismiss(animated: true)
    }

    func shake() {
        let animation = CASpringAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.initialVelocity = 10.0
        animation.damping = 7
        animation.mass = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: containerView.center.x - 10, y: containerView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: containerView.center.x + 10, y: containerView.center.y))

        containerView.layer.add(animation, forKey: "position")
    }
}

extension CSTextView: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true)
        return true
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.dismiss(animated: true)
        return true
    }
}

extension UIViewController {

    func presentBottomTextView(placeholder: String) {
        let textView = CSTextView(placeholder: placeholder)
        textView.modalPresentationStyle = .overFullScreen
        textView.modalTransitionStyle = .crossDissolve
        self.present(textView, animated: true)
    }
}
