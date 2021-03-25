//
//  PhotoViewController.swift
//  Meditation
//
//  Created by Sergio Ramos on 24.03.2021.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var delButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var pictureData : Photos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picture.image = UIImage(data: (pictureData?.picture)!)
        
        delButton.titleLabel?.font = UIFont(name: "Alegreya-Medium", size: 20)
        closeButton.titleLabel?.font = UIFont(name: "Alegreya-Medium", size: 20)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeRight.direction = .right
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return picture
    }
    
    @objc func swipedRight() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.dismiss(animated: false, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func swipedLeft() {
        CoreDataHelper().deletePhoto(photo: pictureData!)
        let vc = storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.dismiss(animated: false, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deletePicture(_ sender: UIButton) {
        CoreDataHelper().deletePhoto(photo: pictureData!)
        let vc = storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func close(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
