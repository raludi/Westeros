//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 24/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var namePerson: UILabel!
    @IBOutlet weak var housePerson: UILabel!
    @IBOutlet weak var aliasPerson: UILabel!
    @IBOutlet weak var sigilPerson: UIImageView!
    
    // MARK: - Properties
    var model: Person
    
    init(model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func syncModelWithView() {
        namePerson.text = model.fullName
        housePerson.text = "Belongs to house \(model.house.name)"
        aliasPerson.text = model.alias
        sigilPerson.image = model.house.sigil.image
    }
    
    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo else {
            return
        }
        let house = info[HOUSE_KEY] as? House //as es un casting de java
        //Actualizar el modelo
        guard let model = house else { return }//En caso no sea nil model vale eso si no return
        self.model = model.sortedMember.first!
        //Sincronizar la vista
        syncModelWithView()
    }

}
