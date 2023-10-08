//
//  ProfileDataFormViewController.swift
//  Twitgram
//
//  Created by Ernazar on 7/10/23.
//

import UIKit
import PhotosUI
import Combine

class ProfileDataFormViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.keyboardDismissMode = .onDrag
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let hintLabel: UILabel = {
        let view = UILabel()
        view.text = "Fill in you data"
        view.font = .systemFont(ofSize: 32, weight: .bold)
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var avatarPlaceholderImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        view.backgroundColor = .lightGray
        view.image = UIImage(systemName: "camera.fill")
        view.tintColor = .gray
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFill
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var displayNameTextField: UITextField = {
        let view = UITextField()
        view.keyboardType = .default
        view.backgroundColor = .secondarySystemFill
        view.leftViewMode = .always
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.attributedPlaceholder = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        view.delegate = self
        view.addTarget(self, action: #selector(didUpdateDisplayName), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var usernameTextField: UITextField = {
        let view = UITextField()
        view.keyboardType = .default
        view.backgroundColor = .secondarySystemFill
        view.leftViewMode = .always
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        view.delegate = self
        view.addTarget(self, action: #selector(didUpdateUsername), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var bioTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .secondarySystemFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.text = "Tell the world about yourself"
        view.textColor = .gray
        view.font = .systemFont(ofSize: 16)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var submutButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Submit", for: .normal)
        view.tintColor = .white
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        view.isEnabled = false
        view.addTarget(self, action: #selector(didTapSubmitr), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel = ProfileDataFormViewViewModel()
    
    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        isModalInPresentation = true
        setupView()
        setupConstraints()
        bindViews()
    }
    
    @objc private func didTapSubmitr() {
        viewModel.uploadAvatar()
    }
    
    @objc private func didTapToDismiss() {
        view.endEditing(true)
    }
    
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func didUpdateDisplayName() {
        viewModel.displayName = displayNameTextField.text
        viewModel.validateUserProfileForm()
    }
    
    @objc private func didUpdateUsername() {
        viewModel.userName = usernameTextField.text
        viewModel.validateUserProfileForm()
    }
    
    private func bindViews() {
        viewModel.$isFormValid.sink { [weak self] buttonState in
            self?.submutButton.isEnabled = buttonState
        }
        .store(in: &subscriptions)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        view.addSubview(scrollView)
        scrollView.addSubview(hintLabel)
        scrollView.addSubview(avatarPlaceholderImageView)
        scrollView.addSubview(displayNameTextField)
        scrollView.addSubview(usernameTextField)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(submutButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            hintLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hintLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),

            avatarPlaceholderImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarPlaceholderImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarPlaceholderImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarPlaceholderImageView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 30),
            
            displayNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            displayNameTextField.topAnchor.constraint(equalTo: avatarPlaceholderImageView.bottomAnchor, constant: 40),
            displayNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            usernameTextField.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
            usernameTextField.topAnchor.constraint(equalTo: displayNameTextField.bottomAnchor, constant: 20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            bioTextView.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
            bioTextView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            bioTextView.heightAnchor.constraint(equalToConstant: 150),
            
            submutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submutButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20),
            submutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

//MARK: -  UITextViewDelegate && UITextFieldDelegate

extension ProfileDataFormViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 100), animated: true)
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        if textView.text.isEmpty {
            textView.text = "Tell the world about yourself"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.bio = textView.text
        viewModel.validateUserProfileForm()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

//MARK: - PHPickerViewControllerDelegate

extension ProfileDataFormViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarPlaceholderImageView.image = image
                        self?.viewModel.imageData = image
                        self?.viewModel.validateUserProfileForm()
                    }
                }
            }
        }
    }
}
