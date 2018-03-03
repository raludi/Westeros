//
//  AppDelegate.swift
//  Westeros
//
//  Created by Rafael Lujan on 11/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var collapse: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        //Creamos modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        //Listas
        let seasonListViewController = SeasonListViewController(model: seasons)
        let houseListViewController = HouseListTableViewController(model:houses)
        //TABBAR
        let masterViewController = UITabBarController()
        houseListViewController.tabBarItem = UITabBarItem(title: "Houses", image: #imageLiteral(resourceName: "house-7.png"), tag: 0)
        seasonListViewController.tabBarItem = UITabBarItem(title: "Seasons", image: #imageLiteral(resourceName: "video-player-7.png"), tag: 0)
        masterViewController.viewControllers = [houseListViewController,
                                                seasonListViewController]
        masterViewController.delegate = houseListViewController
        //VC
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseController = HouseDetailViewController(model: lastSelectedHouse)
        let lastSelectedSeason = seasonListViewController.lastSelectedSeason()
        let seasonController = SesaonDetailViewController(model: lastSelectedSeason)
        houseListViewController.delegate = houseController
        seasonListViewController.delegate = seasonController
        //SPLITVC
        let splitViewController = UISplitViewController()
     
        splitViewController.delegate = self
        splitViewController.viewControllers = [masterViewController.wrappedInNavigation(), houseController.wrappedInNavigation()]
        
        window?.rootViewController = splitViewController
        return true
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        print("Entro")
        return true
    }
    
}





