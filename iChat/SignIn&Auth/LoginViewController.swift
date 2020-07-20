//
//  LoginViewController.swift
//  iChat
//
//  Created by Виталий Сосин on 13.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Войдите в FooTeam", font: .bolt20(), textAlignment: .center)
    let descriptionFTLabel = UILabel(text: "Создавайте и управляйте своей командой, следите за статистикой и получай другий возможности.", font: .avenir14(), color: .systemGray, textAlignment: .center)
    
    let emailLabel = UILabel(text: "Ввести эл. почту", font: .markerFel14())
    let passwordLabel = UILabel(text: "Ввести пароль", font: .markerFel14())
    let needAnAccountLabel = UILabel(text: "Нет учетной записи?", font: .avenir14())
    
    let googleButton = UIButton(title: "Продолжить в Google", titleColor: .black, backgroundColor: .white, font: .bolt14(), logo: #imageLiteral(resourceName: "googleLogo"))
    let emailTextField = CustomeTextField(placeholder: "demo@mail.ru")
    let passwordTextField = CustomeTextField(placeholder: "Demo12", isSecure: true)
    let loginButton = UIButton(title: "Войти", titleColor: .white, backgroundColor: .buttonDark(), font: .bolt14())
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .bolt14()
        return button
    }()
    
    weak var delegate: AuthNavigatingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
    }
    
    
}

// MARK: - Actions
extension LoginViewController {
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc private func loginButtonTapped() {
        AuthService.shared.login(
            email: emailTextField.text!,
            password: passwordTextField.text!) { (result) in
                switch result {
                case .success(let user):
                    self.showAlert(with: "Успешно!", and: "Вы авторизованы!") {
                        FirestoreService.shared.getUserData(user: user) { (result) in
                            switch result {
                            case .success(let muser):
                                let mainTabBar = MainTabBarController(currentUser: muser)
                                mainTabBar.modalPresentationStyle = .fullScreen
                                self.present(mainTabBar, animated: true, completion: nil)
                            case .failure(_):
                                self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                            }
                        }
                    }
                case .failure(let error):
                    self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                }
        }
    }
    
    @objc private func signUpButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
}

// MARK: - Setup constraints
extension LoginViewController {
    private func setupConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [welcomeLabel, descriptionFTLabel], axis: .vertical, spacing: 20)
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 5)
        emailTextField.backgroundColor = .systemGray6
        emailTextField.layer.cornerRadius = 5
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 5)
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.layer.cornerRadius = 5
        
        let stackView = UIStackView(arrangedSubviews: [googleButton, emailStackView, passwordStackView, loginButton ], axis: .vertical, spacing: 20)
        
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton], axis: .horizontal, spacing: 10)
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let footerStackView = UIView()
        footerStackView.backgroundColor = .systemGray6
        footerStackView.layer.borderColor = UIColor.systemGray5.cgColor
        footerStackView.layer.borderWidth = 1
        
        bottomStackView.alignment = .firstBaseline
        
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

struct LoginVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let loginVC = LoginViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) -> LoginViewController {
            return loginVC
        }
        
        func updateUIViewController(_ uiViewController: LoginVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) {
            
        }
    }
}
