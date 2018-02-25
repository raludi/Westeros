//
//  SplitViewController.swift
//  Westeros
//
//  Created by Rafael Lujan on 24/2/18.
//  Copyright © 2018 Rafael Luján. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    init() {
        //  self.vc = vc
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        print("HI")
    }

}
