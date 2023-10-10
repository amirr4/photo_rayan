//
//  PhotoViewModel.swift
//  photo_rayan
//
//  Created by Amir on 10/9/23.
//

import UIKit

class PhotoViewModel {
    
    func savePhotoToRealm(size : Int , date : Date , name : String, address : String) {
        let photo = Photo()
        photo.imageSize = "\(size) bytes"
        photo.imageDate = date.description
        photo.imageName = name
        photo.imageAddrees = address
        RealmManager.sharedInstance.saveObject(object: photo)
        print(RealmManager.sharedInstance.fetch(object: Photo()))

    }
}


