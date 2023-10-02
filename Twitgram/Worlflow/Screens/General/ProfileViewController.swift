//
//  ProfileViewController.swift
//  Twitgram
//
//  Created by Ernazar on 2/10/23.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        navigationItem.title = "Profile"
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }

}
