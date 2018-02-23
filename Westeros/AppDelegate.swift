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
/*        let controllers = houses
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
        let masterViewController = MasterViewController()
        
        /*let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        houseListViewController.delegate = houseDetailViewController*/
        
        masterViewController.viewControllers = [houseListViewController,
                                                seasonListViewController]
        let splitViewController = UISplitViewController()
        //let houseController = HouseDetailViewController(model: houses.first!)
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseController = HouseDetailViewController(model: lastSelectedHouse)
        houseListViewController.delegate = houseController
        
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



