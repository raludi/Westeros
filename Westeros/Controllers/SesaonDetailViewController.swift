//
//  SesaonDetailViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 24/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

protocol SeasonDetailDelegate {
    func seasonDetailView(_ vc: SesaonDetailViewController, didSelectSeason season: Season)
}
class SesaonDetailViewController: UIViewController {
    // MARK: - Oulets
    @IBOutlet weak var titleSeason: UILabel!
    @IBOutlet weak var imageSeason: UIImageView!
    @IBOutlet weak var episodesSeason: UILabel!
    @IBOutlet weak var releaseSeason: UILabel!
    
    // MARK: - Properties
    var model: Season
    var delegate: SeasonDetailDelegate?
  
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
        self.delegate = episodesViewController
        navigationController?.pushViewController(episodesViewController, animated: true)
    }
}

extension SesaonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        delegate?.seasonDetailView(self, didSelectSeason: season)
        syncModelWithView()
    }
}
