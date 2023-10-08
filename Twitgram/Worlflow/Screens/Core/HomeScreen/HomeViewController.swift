//
//  HomeViewController.swift
//  Twitgram
//
//  Created by Ernazar on 2/10/23.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
    
    private var viewModel = HomeViewViewModel()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private lazy var timelineTableView: UITableView = {
        let view = UITableView()
        view.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        setupView()
        setupNavigationBar()
        bindViews()
    }
    
    private func setupView() {
        view.addSubview(timelineTableView)
        timelineTableView.frame = view.frame
    }
    
    private func setupNavigationBar() {
        setupNavigationTitleView()
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(profileBarButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
    }
    
    private func setupNavigationTitleView() {
        let size = 26
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "twitterLogo")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
    }
    
    @objc private func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }
    
    @objc private func profileBarButtonDidTap() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retreiveUser()
    }
    
    func completeUserOnboarding() {
        let vc = ProfileDataFormViewController()
        present(vc, animated: true)
    }
    
    func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            if !user.isUserOnboarded {
                self?.completeUserOnboarding()
            }
        }
        .store(in: &subscriptions)
    }
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    //
}

extension HomeViewController: TweetTableViewCellDelegate {
    func tweetTableViewCellDidTapReply() {
        print("reply")
    }
    
    func tweetTableViewCellDidTapRetweet() {
        print("retweet")
    }
    
    func tweetTableViewCellDidTapLike() {
        print("like")
    }
    
    func tweetTableViewCellDidTapShare() {
        print("share")
    }
}
