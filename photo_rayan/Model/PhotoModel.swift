//
//  PhotoModel.swift
//  photo_rayan
//
//  Created by Amir on 10/9/23.
//

import RealmSwift

class Photo: Object {
    @objc dynamic var imageName: String = ""
    @objc dynamic var imageDate: String = ""
    @objc dynamic var imageAddrees: String = ""
    @objc dynamic var imageSize: String = ""
}
