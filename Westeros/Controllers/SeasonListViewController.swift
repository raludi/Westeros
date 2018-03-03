//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 22/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

let SEASON_DID_CHANGE_NOTIFICATION_NAME = "SeasonChanged"
let SEASON_KEY = "SeasonKey"
let LAST_SEASON = "LastSeason"

protocol SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UITableViewController {
    
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?
    
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        //Cogemos la season
        let season = model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.text = "\(season.name)"
        cell.imageView?.image = season.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = model[indexPath.row]

        if splitViewController?.isCollapsed == false {
                delegate?.seasonListViewController(self, didSelectSeason: season)
        } else {
            let seasonDetailViewController = SesaonDetailViewController(model: season)
            navigationController?.pushViewController(seasonDetailViewController, animated: true)
        }
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY: season])
        notificationCenter.post(notification)
        saveLastSelectedSeason(at: indexPath.row)
    }
    
}
extension SeasonListViewController {
    
    func saveLastSelectedSeason(at index: Int) {
        let defaults = UserDefaults.standard
        defaults.set(index, forKey: LAST_SEASON)
        //Por si las moscas
        defaults.synchronize()//Te aseguras de que se guarde si o si
    }
    
    func lastSelectedSeason() -> Season { //Si no encuentra devuelve un 0
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_SEASON)
        //Averiguar la casa de ese row
        let season = model[row]
        //Devolverla
        return season
    }
}

