//
//  ProfileViewController.swift
//  Meditation
//
//  Created by Sergio Ramos on 24.03.2021.
//

import UIKit

class ProfileViewController: UIViewController, UITabBarDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    
    var photos : [Photos]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos = CoreDataHelper().getPhotos()
        collectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        tabBar.selectedItem = tabBar.items![2]
        avatar.image = UIImage(data: Network().getImage(name: UserDefaults().value(forKey: "avatar") as! String))
        avatar.layer.cornerRadius = avatar.bounds.size.width * 0.5
        nameLabel.font = UIFont(name: "Alegreya-Medium", size: 35)
        nameLabel.text = "\(String(describing: UserDefaults().value(forKey: "nickName")!))"
        exitButton.titleLabel?.font = UIFont(name: "Alegreya-Medium", size: 15)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.selectedItem == tabBar.items![1] {
            let vc = storyboard?.instantiateViewController(withIdentifier: "sound") as! PlugViewController
            self.dismiss(animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
        else if tabBar.selectedItem == tabBar.items![0]{
            let vc = storyboard?.instantiateViewController(withIdentifier: "main") as! MainViewController
            self.dismiss(animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func exit(_ sender: UIButton) {
        let defaults = UserDefaults()
        defaults.removeObject(forKey: "token")
        defaults.removeObject(forKey: "nickName")
        defaults.removeObject(forKey: "avatar")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos!.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < photos!.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
            cell.picture.image = UIImage(data: photos![indexPath.row].picture!)
            cell.picture.layer.cornerRadius = 20
            cell.timeLabel.font = UIFont(name: "Alegreya-Medium", size: 18)
            cell.timeLabel.text = photos![indexPath.row].time
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
            cell.picture.image = UIImage(named: "+")
            cell.picture.layer.cornerRadius = 20
            cell.picture.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.6823529412, blue: 0.4470588235, alpha: 1)
            cell.picture.contentMode = .center
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 115)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == photos?.count {
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.sourceType = .photoLibrary
            vc.allowsEditing = true
            present(vc, animated: true, completion: nil)
        }
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "photo") as! PhotoViewController
            vc.pictureData = photos![indexPath.row]
            self.dismiss(animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photos?.append(CoreDataHelper().addPhoto(picture: info[.editedImage] as! UIImage))
        collectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
}
