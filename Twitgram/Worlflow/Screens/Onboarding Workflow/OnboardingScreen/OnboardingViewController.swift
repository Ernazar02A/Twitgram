//
//  OnboardingViewController.swift
//  Twitgram
//
//  Created by Ernazar on 3/10/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.text = "See what's happening in the world right now."
        view.font = .systemFont(ofSize: 32, weight: .heavy)
        view.textAlignment = .center
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var  createAccountButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Create account", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        view.layer.masksToBounds = true
        view.tintColor = .white
        view.layer.cornerRadius = 30
        view.addTarget(self, action: #selector(createAccountButtonDidTap), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let promptLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.tintColor = .gray
        view.text = "Have an account already?"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var loginButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("login", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.tintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        view.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
    }
    @objc private func didTapLogin() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func createAccountButtonDidTap() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 60),
            
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            loginButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 10),
        ])
    }

}
