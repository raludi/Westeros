//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 22/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    var model: Episode
    
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Episode"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cicle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        //Alta notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Baja notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    

    func syncModelWithView() {
        titleText.text = model.title
        dateLabel.text = "Release Date: \(model.issueDate)"
        summaryLabel.text = model.summary
    }
    
    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        // Extraer userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        // Sacar la casa del user info
        let season = info[SEASON_KEY] as? Season //as es un casting de java
        //Actualizar el modelo
        guard let model = season?.sortedEpisodes else { return }//En caso no sea nil model vale eso si no return
        self.model = model.first!
        //Sincronizar la vista
        //self.navigationController?.popViewController(animated: true)
        syncModelWithView()
    }
}
