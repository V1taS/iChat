//
//  SignUpViewController.swift
//  iChat
//
//  Created by Виталий Сосин on 13.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Регистрация", font: .bolt20(), textAlignment: .center)
    let descriptionFTLabel = UILabel(text: "Используйте от 6 до 20 символов. Пароль должен включать в себя хотя бы два из следующих видов символов: буквы, цифры.", font: .avenir14(), color: .systemGray, textAlignment: .center)
    
    let emailLabel = UILabel(text: "Электронная почта", font: .markerFel14())
    let passwordLabel = UILabel(text: "Пароль", font: .markerFel14())
    let confirmPasswodLabel = UILabel(text: "Подтвердите пароль", font: .markerFel14())
    let alreadyOnboardLabel = UILabel(text: "Уже зарегестрированы?", font: .avenir14())
    
    let emailTextField = CustomeTextField(placeholder: "demo@mail.ru")
    let passwordTextField = CustomeTextField(placeholder: "Demo12", isSecure: true)
    let confirmPasswordTextField = CustomeTextField(placeholder: "Demo12", isSecure: true)
    
    let signUpButton = UIButton(title: "Зарегистрироваться", titleColor: .white, backgroundColor: .buttonDark(), font: .bolt14(), cornerRadius: 4)
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .bolt14()
        return button
    }()
    
    weak var delegate: AuthNavigatingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension SignUpViewController {
    @objc private func signUpButtonTapped() {
        AuthService.shared.register(
            email: emailTextField.text,
            password: passwordTextField.text,
            confirmPassword: confirmPasswordTextField.text) { (result) in
                switch result {
                case .success(let user):
                    self.showAlert(with: "Успешно!", and: "Вы зарегистрированны!") {
                        self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                    }
                    
                case .failure(let error):
                    self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                }
        }
    }
    
    @objc private func loginButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }
}

// MARK: - Setup constraints
extension SignUpViewController {
    private func setupConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [welcomeLabel, descriptionFTLabel], axis: .vertical, spacing: 20)
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 5)
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 5)
        
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswodLabel, confirmPasswordTextField], axis: .vertical, spacing: 5)
        confirmPasswordTextField.backgroundColor = .systemGray6
        confirmPasswordTextField.layer.cornerRadius = 5
        
        let stackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, confirmPasswordStackView, signUpButton
            ], axis: .vertical, spacing: 20)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        loginButton.contentHorizontalAlignment = .leading
        
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
        let footerStackView = UIView()
        footerStackView.backgroundColor = .systemGray6
        footerStackView.layer.borderColor = UIColor.systemGray5.cgColor
        footerStackView.layer.borderWidth = 1
        
        
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topStackView)
        view.addSubview(stackView)
        view.addSubview(footerStackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        alreadyOnboardLabel.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: 40).isActive = true
        
        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            footerStackView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SignUpVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let signUpVC = SignUpViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) -> SignUpViewController {
            return signUpVC
        }
        
        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) {
            
        }
    }
}


extension UIViewController {
    
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
