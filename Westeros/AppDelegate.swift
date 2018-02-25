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
        let masterViewController = MasterViewController()
        houseListViewController.tabBarItem = UITabBarItem(title: "Houses", image: #imageLiteral(resourceName: "house-7.png"), tag: 0)
        seasonListViewController.tabBarItem = UITabBarItem(title: "Seasons", image: #imageLiteral(resourceName: "video-player-7.png"), tag: 0)
        masterViewController.viewControllers = [houseListViewController,
                                                seasonListViewController]
        //VC
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseController = HouseDetailViewController(model: lastSelectedHouse)
        let lastSelectedSeason = seasonListViewController.lastSelectedSeason()
        let seasonController = SesaonDetailViewController(model: lastSelectedSeason)
        houseListViewController.delegate = houseController
        seasonListViewController.delegate = seasonController
        //SPLITVC
        let splitViewController = UISplitViewController()
     
        
        splitViewController.viewControllers = [masterViewController.wrappedInNavigation(), houseController.wrappedInNavigation()]
        
        window?.rootViewController = splitViewController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}



