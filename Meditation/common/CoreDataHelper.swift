//
//  CoreDataHelper.swift
//  Meditation
//
//  Created by Sergio Ramos on 24.03.2021.
//

import UIKit
import CoreData

class CoreDataHelper {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getPhotos() -> [Photos] {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Photos> = Photos.fetchRequest()
        let photos = try! context.fetch(fetchRequest)
        return photos
    }
    
    func addPhoto(picture : UIImage) -> Photos {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        let context = appDelegate.persistentContainer.viewContext
        let photo = Photos(context: context)
        photo.picture = picture.pngData()
        photo.time = formatter.string(from: currentDateTime)
        appDelegate.saveContext()
        return photo
    }
    
    func deletePhoto(photo : Photos) {
        let context = appDelegate.persistentContainer.viewContext
        context.delete(photo)
        appDelegate.saveContext()
    }
}
