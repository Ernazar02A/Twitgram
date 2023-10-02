//
//  TweetTableViewCell.swift
//  Twitgram
//
//  Created by Ernazar on 2/10/23.
//

import UIKit

protocol TweetTableViewCellDelegate: AnyObject {
    func tweetTableViewCellDidTapReply()
    func tweetTableViewCellDidTapRetweet()
    func tweetTableViewCellDidTapLike()
    func tweetTableViewCellDidTapShare()
}

class TweetTableViewCell: UITableViewCell {
    
    weak var delegate: TweetTableViewCellDelegate?
    
    private let actionSpacing: CGFloat = 55
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.backgroundColor = .red
        view.image = UIImage(systemName: "person")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var displayNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Ernazar"
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var userNameLabel: UILabel = {
        let view = UILabel()
        view.text = "@Aibekov"
        view.textColor = .secondaryLabel
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var tweetTextContentLabel: UILabel = {
        let view = UILabel()
        view.text = "This is my Mockup tweet. it is going to take multiple lines. I believe some more text is enough but let add some more anyway.."
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var replyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "replyIcon"), for: .normal)
        view.tintColor = .systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(replyButtonDidTap), for: .touchUpInside)
        return view
    }()
    private lazy var retweetButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "retweetIcon"), for: .normal)
        view.tintColor = .systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(retweetButtonDidTap), for: .touchUpInside)
        return view
    }()
    private lazy var likeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "heartIcon"), for: .normal)
        view.tintColor = .systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
        return view
    }()
    private lazy var shareButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "shareIcon"), for: .normal)
        view.tintColor = .systemGray2
        view.addTarget(self, action: #selector(shareButtonDidTap), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    @objc private func replyButtonDidTap() {
        delegate?.tweetTableViewCellDidTapReply()
    }
    
    @objc private func retweetButtonDidTap() {
        delegate?.tweetTableViewCellDidTapRetweet()
    }
    
    @objc private func likeButtonDidTap() {
        delegate?.tweetTableViewCellDidTapLike()
    }
    
    @objc private func shareButtonDidTap() {
        delegate?.tweetTableViewCellDidTapShare()
    }
    
    private func setupView() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(tweetTextContentLabel)
        contentView.addSubview(replyButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            
            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            userNameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: 10),
            userNameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor),
            
            tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            tweetTextContentLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10),
            
            replyButton.leadingAnchor.constraint(equalTo: tweetTextContentLabel.leadingAnchor),
            replyButton.topAnchor.constraint(equalTo: tweetTextContentLabel.bottomAnchor, constant: 10),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: actionSpacing),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
            
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: actionSpacing),
            likeButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
            
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: actionSpacing),
            shareButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
