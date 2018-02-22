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
    let model: Episode
    
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
    }
    

    func syncModelWithView() {
        titleText.text = model.title
        dateLabel.text = "Release Date: \(model.issueDate)"
        summaryLabel.text = model.summary
    }
}
