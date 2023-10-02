//
//  ProfileViewController.swift
//  Twitgram
//
//  Created by Ernazar on 2/10/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileTableView: UITableView = {
        let view = UITableView()
        view.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupNavigationBar()
        setupConstraints()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Profile"
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(profileTableView)
    }
    
    private func setupTableView() {
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 340))
        profileTableView.tableHeaderView = headerView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        //cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    //
}
