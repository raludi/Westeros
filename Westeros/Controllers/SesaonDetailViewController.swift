//
//  SesaonDetailViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 24/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

class SesaonDetailViewController: UIViewController {
    // MARK: - Oulets
    @IBOutlet weak var titleSeason: UILabel!
    @IBOutlet weak var imageSeason: UIImageView!
    @IBOutlet weak var episodesSeason: UILabel!
    @IBOutlet weak var releaseSeason: UILabel!
    
    // MARK: - Properties
    var model: Season
    
  
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Season Detail"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func syncModelWithView() {
        titleSeason.text = model.name
        imageSeason.image = model.image
        episodesSeason.text = "Total Episodes: \(model.countEpisodes)"
        releaseSeason.text = "Release Date: \(model.releaseDate)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Baja notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func seasonDidChange(notification: Notification) {
        // Extraer userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        // Sacar la casa del user info
        let season = info[SEASON_KEY] as? Season //as es un casting de java
        //Actualizar el modelo
        guard let model = season else { return }//En caso no sea nil model vale eso si no return
        self.model = model
        //Sincronizar la vista
        syncModelWithView()
    }
    
    // MARK: - UI
    func setupUI() {
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        //target en que clase busco y action la acción a buscar
        navigationItem.rightBarButtonItems = [episodesButton]
    }
    
    @objc func displayEpisodes() {
        //Creamos el WikiVC
        let episodesViewController =  EpisodeListViewController(model: model.sortedEpisodes)
        //Hacemos push
        navigationController?.pushViewController(episodesViewController, animated: true)
    }
}
