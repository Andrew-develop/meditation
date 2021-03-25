//
//  LoginViewController.swift
//  Meditation
//
//  Created by Sergio Ramos on 19.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mail = UserDefaults().value(forKey: "email")
        if mail != nil {
            email.text = mail as? String
        }
        name.font = UIFont(name: "Alegreya-Medium", size: 30)
        button.titleLabel?.font = UIFont(name: "Alegreya-Medium", size: 25)
        button.layer.cornerRadius = 10
        email.font = UIFont(name: "Alegreya-Regular", size: 18)
        password.font = UIFont(name: "Alegreya-Regular", size: 18)
        signIn.titleLabel?.font = UIFont(name: "Alegreya-Regular", size: 20)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if isMailValid && isPasswordValid {
            var model = Login()
            model.email = email.text!
            model.password = password.text!
            Network().login(model: model) { (result) in
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            } onError: { (error) in
                print(error)
            }
        }
    }
    
    
    private var isMailValid: Bool {
        get {
            if email.text?.count == 0 {
                return false
            }
            let regExp = "[a-z0-9]+@[a-z0-9]+.[a-z]+"
            let regex = try! NSRegularExpression(pattern: regExp)
            let range = NSRange(location: 0, length: email.text!.count)
            return regex.firstMatch(in: email.text!, options: [], range: range) != nil
        }
    }

    private var isPasswordValid: Bool {
        return password.text!.count != 0
    }
}
