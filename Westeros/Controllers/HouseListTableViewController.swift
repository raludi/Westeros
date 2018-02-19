//
//  HouseListTableViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 16/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

class HouseListTableViewController: UITableViewController {
    
    
    // MARK: - Properties
    let model: [House]
    
    init(model: [House]) {
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        let houseDetailViewController = HouseDetailViewController(model: house)
        //Hacer un push
        navigationController?.pushViewController(houseDetailViewController, animated: true)
    }
}
