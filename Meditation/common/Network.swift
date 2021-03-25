//
//  Network.swift
//  Meditation
//
//  Created by Sergio Ramos on 20.03.2021.
//

import Foundation

class Network {
    
    let baseURL = "http://mskko2021.mad.hakta.pro/api"
    
    func login(model : Login, _ onComplete: @escaping (_ cover: LoginResponse?) -> Void, onError: @escaping (_ message: String) -> Void) {
        let url = URL(string: baseURL + "/user/login")!
        let parameterDictionary = ["email" : "\(model.email!)", "password" : "\(model.password!)"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            do {
                let result = try JSONDecoder().decode(LoginResponse.self, from: data!)
                
                let defaults = UserDefaults()
                defaults.setValue(result.email, forKey: "email")
                defaults.setValue(result.nickName, forKey: "nickName")
                defaults.setValue(result.token, forKey: "token")
                defaults.setValue(result.avatar, forKey: "avatar")
                
                onComplete(result)
            } catch {
                onError(error.localizedDescription)
            }
        }.resume()
    }
    
    func getQuotes(_ onComplete: @escaping (_ cover: Quotes?) -> Void, onError:  @escaping (_ message: String) -> Void) {
        let url = URL(string: baseURL + "/quotes")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            do {
                let result = try JSONDecoder().decode(Quotes.self, from: data!)
                onComplete(result)
            } catch {
                onError(error.localizedDescription)
            }
        }.resume()
    }
    
    func getFeelings(_ onComplete: @escaping (_ cover: Feelings?) -> Void, onError: @escaping (_ message: String) -> Void) {
        let url = URL(string: baseURL + "/feelings")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            do {
                let result = try JSONDecoder().decode(Feelings.self, from: data!)
                onComplete(result)
            } catch {
                onError(error.localizedDescription)
            }
        }.resume()
    }
    
    func getImage(name : String) -> Data {
        let imageURL = URL(string: name)!
        let image = try! Data(contentsOf: imageURL)
        return image
    }
}
