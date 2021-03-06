//
//  HouseListTableViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 16/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

let HOUSE_DID_CHANGE_NOTIFICATION_NAME = "HouseDidChange"
let HOUSE_KEY = "HouseKey"
let LAST_HOUSE = "LastHouse"

protocol HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListTableViewController, didSelectHouse house: House)
}

class HouseListTableViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [House]
    var delegate: HouseListViewControllerDelegate? //Al ponerle opcional no hace falta init
    
    init(model: [House]) {
        self.model = model
        super.init(style: .plain)
        title = "Houses"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
       /* super.viewWillAppear(animated)
        let house =  HouseListTableViewController(model: Repository.local.houses).lastSelectedHouse()
        let houseVC = HouseDetailViewController(model: house)
        self.delegate = houseVC
        showDetailViewController(houseVC.wrappedInNavigation(), sender: nil)*/
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "HouseCell"
        //Que casa mostramos
        let house = model[indexPath.row]
        //Crear una celda
        //con reusable comprobamos si esta en cache
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        //Sincroniza house con la celda
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        return cell!
    }
    
    //Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Averiguar que casa se pulsa
        let house = model[indexPath.row]
        //Crear un controlador de detalles
        if UIDevice.current.userInterfaceIdiom == .pad {
            delegate?.houseListViewController(self, didSelectHouse: house)
        } else if UIDevice.current.userInterfaceIdiom == .phone {
            navigationController?.pushViewController(HouseDetailViewController(model: house), animated: true)
        }
        //Solo puede tener un delegado aunque se le pueda llamar desde más sitios
        //Si queremos que se entere más gente usamos notificaciones
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY: house])
        notificationCenter.post(notification)
        //Guardar coordenadas (section, row) de la ultima casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
    
}

extension HouseListTableViewController {
    
    func saveLastSelectedHouse(at index: Int) {
        let defaults = UserDefaults.standard
        defaults.set(index, forKey: LAST_HOUSE)
        //Por si las moscas
        defaults.synchronize()//Te aseguras de que se guarde si o si
    }
    
    func lastSelectedHouse() -> House { //Si no encuentra devuelve un 0
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        //Averiguar la casa de ese row
        let house = model[row]
        //Devolverla
        return house
    }
}

extension HouseListTableViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is HouseListTableViewController {
            let house =  HouseListTableViewController(model: Repository.local.houses).lastSelectedHouse()
            let houseVC = HouseDetailViewController(model: house)
            self.delegate = houseVC
            if UIDevice.current.userInterfaceIdiom == .pad {
                 showDetailViewController(houseVC.wrappedInNavigation(), sender: nil)
            } else if UIDevice.current.userInterfaceIdiom == .phone {
                splitViewController?.viewControllers = [(splitViewController?.viewControllers[0])!, houseVC.wrappedInNavigation()]
            }
        }
        if viewController is SeasonListViewController {
            let season = SeasonListViewController(model: Repository.local.seasons).lastSelectedSeason()
            let seasonVC = SesaonDetailViewController(model: season)
            let list = viewController as! SeasonListViewController
            list.delegate = seasonVC
            if UIDevice.current.userInterfaceIdiom == .pad {
                showDetailViewController(seasonVC.wrappedInNavigation(), sender: nil)
            } else if UIDevice.current.userInterfaceIdiom == .phone {
                splitViewController?.viewControllers = [(splitViewController?.viewControllers[0])!, seasonVC.wrappedInNavigation()]
            }
        }
    }
}
