//
//  AuthViewController.swift
//  iChat
//
//  Created by Виталий Сосин on 12.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController {
    
    var logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"), contentMode: .scaleAspectFill)
    
    let registerInFTLabel = UILabel(text: "Зарегистрироваться в FooTeam", font: .bolt20(), textAlignment: .center)
    let descriptionFTLabel = UILabel(text: "Создайте профиль, чтобы создать свою собственную команду, управлять составами и получить другие возможности.", font: .avenir14(), color: .systemGray, textAlignment: .center)
    let alreadyOnboardLabel = UILabel(text: "Уже есть аккаунт?", font: .avenir14())
    
    let googleButton = UIButton(title: "Продолжить в Google", titleColor: .black, backgroundColor: .white, font: .bolt14(), logo: #imageLiteral(resourceName: "googleLogo"))
    let emailButton = UIButton(title: "Ввести эл. почту", titleColor: .black, backgroundColor: .white, font: .bolt14(), logo: #imageLiteral(resourceName: "messagingIcon"))
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .bolt14()
        return button
    }()
    
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        
        signUpVC.delegate = self
        loginVC.delegate = self
        
        GIDSignIn.sharedInstance()?.delegate = self
    }
}

// MARK: - Actions
extension AuthViewController {
    @objc private func emailButtonTapped() {
           present(signUpVC, animated: true, completion: nil)
       }
       
       @objc private func loginButtonTapped() {
           present(loginVC, animated: true, completion: nil)
       }
       
       @objc private func googleButtonTapped() {
           GIDSignIn.sharedInstance()?.presentingViewController = self
           GIDSignIn.sharedInstance().signIn()
       }
}

// MARK: - Setup constraints
extension AuthViewController {
    private func setupConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [registerInFTLabel, descriptionFTLabel], axis: .vertical, spacing: 20)
        
        let stackView = UIStackView(arrangedSubviews: [emailButton, googleButton], axis: .vertical, spacing: 10)
        
        loginButton.contentHorizontalAlignment = .fill
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton],
                                          axis: .horizontal,
                                          spacing: 10)
        
        let footerStackView = UIView()
        footerStackView.backgroundColor = .systemGray6
        footerStackView.layer.borderColor = UIColor.systemGray5.cgColor
        footerStackView.layer.borderWidth = 1
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(topStackView)
        view.addSubview(stackView)
        view.addSubview(footerStackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
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

// MARK: - AuthNavigatingDelegate
extension AuthViewController: AuthNavigatingDelegate {
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
    }
}

// MARK: - GIDSignInDelegate
extension AuthViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        AuthService.shared.googleLogin(user: user, error: error) { (result) in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { (result) in
                    switch result {
                    case .success(let muser):
                        UIApplication.getTopViewController()?.showAlert(with: "Успешно", and: "Вы авторизованы") {
                            let mainTabBar = MainTabBarController(currentUser: muser)
                            mainTabBar.modalPresentationStyle = .fullScreen
                            UIApplication.getTopViewController()?.present(mainTabBar, animated: true, completion: nil)
                        }
                    case .failure(_):
                        UIApplication.getTopViewController()?.showAlert(with: "Успешно", and: "Вы зарегистрированны") {
                            UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                        }
                    } // result
                }
            case .failure(let error):
                self.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
}


// MARK: - SwiftUI
import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {
            
        }
    }
}

