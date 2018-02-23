//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 12/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        //nibName -> nuestro xib, bundle -> carpeta donde esta nuestra app, si pones nil principal
        super.init(nibName: nil, bundle: Bundle(for: type(of: self))) //ACORDARSE EN SWIFT ES DISTINTO A JAVA, AL FINAL SUPER
        title = model.name//Para inicializar titulo
    }
    
    //Chapuza relacionada con los nil que obligan a poner
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Hay muchas más funciones mirar -> ciclo vida de un controller
    // MARK: - Lyfe Cicle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Baja notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
      //title = model.name //Todos los UIViewController tienen un title
    }
    
    // MARK: - UI
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        //target en que clase busco y action la acción a buscar
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        navigationItem.rightBarButtonItems = [wikiButton,membersButton]
    }
    
    @objc func displayWiki() {
        //Creamos el WikiVC
        let wikiViewController =  WikiViewController(model: model)
        //Hacemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc func displayMembers() {
        let memberListViewController = MemberListViewController(model: model.sortedMember)
        navigationController?.pushViewController(memberListViewController, animated: true)
    }
    
    @objc func houseDidChange(notification: Notification) {
        // Extraer userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        // Sacar la casa del user info
        let house = info[HOUSE_KEY] as? House //as es un casting de java
        //Actualizar el modelo
        guard let model = house else { return }//En caso no sea nil model vale eso si no return
        self.model = model
        //Sincronizar la vista
        //self.navigationController?.popViewController(animated: true)
        syncModelWithView()
    }

}
//Solo puede tener un delegado aunque se le pueda llamar desde más sitios
//Si queremos que se entere más gente usamos notificaciones
extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListTableViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
}



