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

}
//Solo puede tener un delegado aunque se le pueda llamar desde más sitios
//Si queremos que se entere más gente usamos notificaciones
extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListTableViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
}



