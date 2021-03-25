//
//  ViewController.swift
//  Meditation
//
//  Created by Sergio Ramos on 16.03.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var partingWords: UILabel!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greeting.font = UIFont(name: "Alegreya-Bold", size: 34)
        partingWords.font = UIFont(name: "Alegreya-Medium", size: 20)
        login.titleLabel?.font = UIFont(name: "Alegreya-Medium", size: 25)
        login.layer.cornerRadius = 10
        signIn.titleLabel?.font = UIFont(name: "Alegreya-Regular", size: 20)
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        dismiss(animated: false, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

