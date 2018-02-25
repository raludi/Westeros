//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 19/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //asignamos al delegado
        tableView.delegate = self
        //Asignamos la fuente de datos
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Alta notificaciones
        /*let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)*/
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Baja notificaciones
        /*let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)*/
    }
    
    /*@objc func houseDidChange(notification: Notification) {
        // Extraer userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        // Sacar la casa del user info
        let house = info[HOUSE_KEY] as? House //as es un casting de java
        //Actualizar el modelo
        guard let model = house else { return }//En caso no sea nil model vale eso si no return
        self.model = model.sortedMember
        tableView.reloadData()
    }*/
}

//MARK: - UITableViewDataSource
extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MemberCell"
        // Descubrir la persona que tenemos que mostrar
        let person = model[indexPath.row]
        // Preguntar por una celda (a una cache) o Crearla
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sicronizar celda y persona
        cell.textLabel?.text = person.fullName
        // Devolver la celda
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = model[indexPath.row]
        navigationController?.pushViewController(MemberDetailViewController(model: member), animated: true)
    }
}

extension MemberListViewController: HouseDetailViewControllerDelegate {
    func houseDetailViewControllerDelegate(_ vc: HouseDetailViewController, didSelectHouse house: House) {
        self.model = house.sortedMember
        tableView.reloadData()
    }
}

