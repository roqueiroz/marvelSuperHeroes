//
//  MainViewController.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 17/11/22.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabs()
        self.configTabbar()
    }
     
    //MARK: Function`s
    private func configTabbar() {
        
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .black
        self.tabBar.layer.borderWidth = 0.5
        
    }
    
    private func setupTabs() {
        
        let homeViewController = HomeViewController()
        let favoritesViewController = FavoritesViewController()
        
        let homeNavigation = configNavigationController()
        homeNavigation.tabBarItem.title = "Home"
        homeNavigation.tabBarItem.image = UIImage(named: "house.fill")
        homeNavigation.viewControllers = [homeViewController]

        let favoritesNavigation = configNavigationController()
        favoritesNavigation.tabBarItem.title = "Favoritos"
        favoritesNavigation.tabBarItem.image = UIImage(named: "star.fill")
        favoritesNavigation.viewControllers = [favoritesViewController]
        
        let tabs = [homeNavigation, favoritesNavigation]
        
        self.setViewControllers(tabs, animated: true)
        
    }
    
    private func configNavigationController() -> UINavigationController {
        let navigation = UINavigationController()
        navigation.navigationBar.isHidden = false
        navigation.tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: -5)
        
        return navigation
    }
    
}

extension UITabBar {
    
    static let height: CGFloat = 50
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        
        var sizeFits = super.sizeThatFits(size)
        sizeFits.height = UITabBar.height + window.safeAreaInsets.bottom
        
        return sizeFits
    }
    
}

protocol MainViewProtocol {
    var tabIcon: UIImage? { get }
    var tabTitle: String { get }
}
