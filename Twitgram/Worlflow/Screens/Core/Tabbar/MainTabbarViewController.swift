//
//  MainTabbarViewController.swift
//  Twitgram
//
//  Created by Ernazar on 2/10/23.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let homeViewController = createViewController(
            viewController: HomeViewController(),
            image: .init(systemName: "house"),
            selectedImage: .init(systemName: "house.fill")
        )
        let searchViewController = createViewController(
            viewController: SearchViewController(),
            image: .init(systemName: "magnifyingglass"),
            selectedImage: .init(systemName: "magnifyingglass")
        )
        let notificationsViewController = createViewController(
            viewController: NotificationsViewController(),
            image: .init(systemName: "bell"),
            selectedImage: .init(systemName: "bell.fill")
        )
        let directMessageViewController = createViewController(
            viewController: DirectMessagesViewController(),
            image: .init(systemName: "envelope"),
            selectedImage: .init(systemName: "envelope.fill")
        )
        
        setViewControllers([homeViewController,searchViewController,notificationsViewController,directMessageViewController], animated: true
        )
    }
    
    private func createViewController(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UINavigationController {
        
        let viewContoller = UINavigationController(rootViewController: viewController)
        viewContoller.tabBarItem.image = image
        viewContoller.tabBarItem.selectedImage = selectedImage
        return viewContoller
    }

}

