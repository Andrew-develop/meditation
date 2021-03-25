//
//  MainViewController.swift
//  Meditation
//
//  Created by Sergio Ramos on 20.03.2021.
//

import UIKit

class MainViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var avatar: UIButton!
    @IBOutlet weak var tabBar: UITabBar!
    
    private var quotes : Quotes?
    private var feelings : Feelings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.selectedItem = tabBar.items![0]
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        avatar.setImage(UIImage(data: Network().getImage(name: UserDefaults().value(forKey: "avatar") as! String))?.withRenderingMode(.alwaysOriginal), for: .normal)
        avatar.imageView?.layer.cornerRadius = avatar.bounds.size.width * 0.5
        question.font = UIFont(name: "Alegreya-Regular", size: 22)
        greeting.font = UIFont(name: "Alegreya-Medium", size: 30)
        greeting.text = "С возвращением, \(String(describing: UserDefaults().value(forKey: "nickName")!))!"
        
        Network().getFeelings { [weak self] (result) in
            self?.feelings = result
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        } onError: { (error) in
            print(error)
        }

        Network().getQuotes { [weak self] (result) in
            self?.quotes = result
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } onError: { (error) in
            print(error)
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.selectedItem == tabBar.items![1] {
            let vc = storyboard?.instantiateViewController(withIdentifier: "sound") as! PlugViewController
            self.dismiss(animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
        else if tabBar.selectedItem == tabBar.items![2]{
            let vc = storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
            self.dismiss(animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if feelings == nil {
            return 0
        }
        else {
            return feelings!.data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.picture.image = UIImage(data: Network().getImage(name: (feelings?.data[indexPath.row].image)!))
        cell.title.font = UIFont(name: "Alegreya-Regular", size: 12)
        cell.title.text = feelings?.data[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if quotes == nil {
            return 0
        }
        else {
            return quotes!.data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell
        cell.name.font = UIFont(name: "Alegreya-Medium", size: 25)
        cell.info.font = UIFont(name: "Alegreya-Medium", size: 15)
        cell.action.font = UIFont(name: "Alegreya-Medium", size: 15)
        cell.name.text = quotes?.data[indexPath.row].title
        cell.info.text = quotes?.data[indexPath.row].datumDescription
        cell.picture.image = UIImage(data: Network().getImage(name: (quotes?.data[indexPath.row].image)!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        196
    }
    
}
