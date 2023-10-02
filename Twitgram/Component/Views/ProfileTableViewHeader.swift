//
//  ProfileTableViewHeader.swift
//  Twitgram
//
//  Created by Ernazar on 2/10/23.
//

import UIKit

class ProfileTableViewHeader: UIView {
    
    private lazy var profileHeaderImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "header")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var profileAvatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.image = UIImage(systemName: "person")
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var displayNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Ernazar"
        view.font = .systemFont(ofSize: 22, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var userNameLabel: UILabel = {
        let view = UILabel()
        view.text = "@Aibekov"
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 18, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var userBioLabel: UILabel = {
        let view = UILabel()
        view.text = "iOS Developer"
        view.numberOfLines = 3
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var jsonDateImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        view.tintColor = .secondaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var jsonDateLabel: UILabel = {
        let view = UILabel()
        view.text = "Joined Oсtober 2023"
        view.numberOfLines = 3
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(userNameLabel)
        addSubview(userBioLabel)
        addSubview(jsonDateImageView)
        addSubview(jsonDateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 160),
            
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 60),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 20),
            
            userNameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5),
            
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            userBioLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            
            jsonDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            jsonDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 5),
            
            jsonDateLabel.leadingAnchor.constraint(equalTo: jsonDateImageView.trailingAnchor, constant: 2),
            jsonDateLabel.bottomAnchor.constraint(equalTo: jsonDateImageView.bottomAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
