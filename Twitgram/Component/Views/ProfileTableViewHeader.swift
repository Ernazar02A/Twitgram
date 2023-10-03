//
//  ProfileTableViewHeader.swift
//  Twitgram
//
//  Created by Ernazar on 2/10/23.
//

import UIKit

class ProfileTableViewHeader: UIView {
    
    private enum SectionTabs: String {
        case tweets = "Tweets"
        case tweetsAndReplies = "Tweets & Replies"
        case media = "Media"
        case likes = "Likes"
        
        var index: Int {
            switch self {
            case .tweets:
                return 0
            case .tweetsAndReplies:
                return 1
            case .media:
                return 2
            case .likes:
                return 3
            }
        }
    }
    
    private var selectedTab: Int = 0 {
        didSet {
            print(selectedTab)
        }
    }
    
    private let profileHeaderImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "header")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let profileAvatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 35
        view.image = UIImage(systemName: "person")
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let displayNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Ernazar"
        view.font = .systemFont(ofSize: 22, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let userNameLabel: UILabel = {
        let view = UILabel()
        view.text = "@Aibekov"
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 18, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let userBioLabel: UILabel = {
        let view = UILabel()
        view.text = "iOS Developer"
        view.numberOfLines = 3
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let jsonDateImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        view.tintColor = .secondaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let jsonDateLabel: UILabel = {
        let view = UILabel()
        view.text = "Joined Oсtober 2023"
        view.numberOfLines = 3
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let followingTextLabel: UILabel = {
        let view = UILabel()
        view.text = "Following"
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let followingCountLabel: UILabel = {
        let view = UILabel()
        view.text = "314"
        view.textColor = .label
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let followersTextLabel: UILabel = {
        let view = UILabel()
        view.text = "Followers"
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let followersCountLabel: UILabel = {
        let view = UILabel()
        view.text = "1M"
        view.textColor = .label
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"]
        .map { buttonTitle in
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.tintColor = .label
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    
    private lazy var sectionStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: tabs)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        view.axis = .horizontal
        view.alignment = .center
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    private func setup() {
        setupView()
        setupConstraints()
        setupStackButton()
    }
    
    private func setupView() {
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(userNameLabel)
        addSubview(userBioLabel)
        addSubview(jsonDateImageView)
        addSubview(jsonDateLabel)
        addSubview(followingCountLabel)
        addSubview(followingTextLabel)
        addSubview(followersCountLabel)
        addSubview(followersTextLabel)
        addSubview(sectionStack)
    }
    
    private func setupStackButton() {
        for (_, button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            button.addTarget(self, action: #selector(tabDidTap(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func tabDidTap(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else { return }
        switch label {
        case SectionTabs.tweets.rawValue:
            selectedTab = 0
        case SectionTabs.tweetsAndReplies.rawValue:
            selectedTab = 1
        case SectionTabs.media.rawValue:
            selectedTab = 2
        case SectionTabs.likes.rawValue:
            selectedTab = 3
        default:
            selectedTab = 0
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 140),
            
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 70),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 70),
            
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
            
            followingCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: jsonDateLabel.bottomAnchor, constant: 10),
            
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 4),
            followingTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor),
            
            followersCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor, constant: 8),
            followersCountLabel.bottomAnchor.constraint(equalTo: followingTextLabel.bottomAnchor),
            
            followersTextLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor, constant: 4),
            followersTextLabel.bottomAnchor.constraint(equalTo: followersCountLabel.bottomAnchor),
            
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sectionStack.topAnchor.constraint(equalTo: followingCountLabel.bottomAnchor, constant: 5),
            sectionStack.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
