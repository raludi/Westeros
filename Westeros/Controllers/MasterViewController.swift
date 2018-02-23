//
//  MasterViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 22/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

let TAB_BAR_CHANGED_TO_SEASONS = "TabBarChangeSeasons"
let TAB_BAR_CHANGED_TO_HOUSES = "TabBarChangeHouses"
let TAB_HOUSE_KEY = "TabHouseKey"
let TAB_SEASON_KEY = "TabSeasonKey"
class MasterViewController: UITabBarController {
    
    //let vc: [UIViewController]
    
    init() {
      //  self.vc = vc
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Hi")
        //let notificationCenter = NotificationCenter.default
        if item.title == "Seasons" {
            let season = SeasonListViewController(model: Repository.local.seasons).lastSelectedSeason()
            showDetailViewController(EpisodeListViewController(model: season.sortedEpisodes).wrappedInNavigation() , sender: nil)
            /*let notification = Notification(name: Notification.Name(TAB_BAR_CHANGED_TO_SEASONS), object: self, userInfo: [TAB_SEASON_KEY: Repository.local.seasons.first!])
            notificationCenter.post(notification)*/
        } else {
            let house = HouseListTableViewController(model: Repository.local.houses).lastSelectedHouse()
            showDetailViewController(HouseDetailViewController(model: house).wrappedInNavigation(), sender: nil)
            /*let notification = Notification(name: Notification.Name(TAB_BAR_CHANGED_TO_HOUSES), object: self, userInfo: [TAB_HOUSE_KEY: Repository.local.houses.first!])
            notificationCenter.post(notification)*/
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

