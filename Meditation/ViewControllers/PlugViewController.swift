//
//  PlugViewController.swift
//  Meditation
//
//  Created by Sergio Ramos on 16.03.2021.
//

import UIKit

class PlugViewController: UIViewController {
    
    
    @IBOutlet weak var plug: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        plug.textColor = .white
        plug.font = UIFont(name: "Alegreya-Medium", size: 30)
    }

}
