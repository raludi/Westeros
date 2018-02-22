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
        //Creamos controladores
        /*var controllers = [UIViewController]()
        for each in houses {
            controllers.append(HouseDetailViewController(model: each).wrappedInNavigation())
        }*/
        //Esto es funcional
        /*let controllers = houses
            .map({ element in
            return HouseDetailViewController(model: element)})
            .map({ $0.wrappedInNavigation() })
       
        //Creamos combinadores
        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = controllers
        
        //Controladores (Master y Detail)
        let houseListViewController = HouseListTableViewController(model:houses)
        
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        
        //Asignamos delegados
        houseListViewController.delegate = houseDetailViewController
        
        //Creamos SplitView(Para IPads)
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [houseListViewController.wrappedInNavigation(),
                                               houseDetailViewController.wrappedInNavigation()]
        //Asignamos el rootVC
        window?.rootViewController = splitViewController
        */
        let seasonListViewController = SeasonListViewController(model: seasons)
        let houseListViewController = HouseListTableViewController(model:houses)
        let tabBarViewController = UITabBarController()
        
        /*let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        houseListViewController.delegate = houseDetailViewController*/
        
        tabBarViewController.viewControllers = [houseListViewController.wrappedInNavigation(),
                                                seasonListViewController.wrappedInNavigation()]
        window?.rootViewController = tabBarViewController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

