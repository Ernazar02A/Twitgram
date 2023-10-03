//
//  ProfileViewController.swift
//  Twitgram
//
//  Created by Ernazar on 2/10/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var isStatusBarHidden: Bool = true
    
    private lazy var statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.opacity = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        navigationController?.navigationBar.isHidden = true
        print("setupNavigationBar")
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(profileTableView)
        view.addSubview(statusBar)
    }
    
    private func setupTableView() {
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 350))
        profileTableView.tableHeaderView = headerView
        profileTableView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupConstraints() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let statusBarHeight = windowScene?.statusBarManager?.statusBarFrame.height
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: statusBarHeight ?? (view.bounds.height > 800 ? 40 : 20)),
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        if yPosition > 140 && isStatusBarHidden {
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
            } completion: { _ in }
        } else if yPosition < 0 && !isStatusBarHidden{
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
            } completion: { _ in }
        }
    }
}
