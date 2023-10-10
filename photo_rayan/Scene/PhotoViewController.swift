//
//  ViewController.swift
//  photo_rayan
//
//  Created by Amir on 10/9/23.
//

import UIKit
import RealmSwift

class PhotoViewController: UIViewController {
    var captureDate: Date?
    var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(RealmManager.sharedInstance.fetch(object: Photo()))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setImagePicker()
    }
    
    func setImagePicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = false
        vc.delegate = self
        captureDate = Date()
        present(vc, animated: true)
    }
}

extension PhotoViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            
            // Get the size of the captured image
            guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
            let imageSizeInBytes = imageData.count

            // Get the name and address of the captured image
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            let imageURL = documentDirectory.appendingPathComponent(UUID().uuidString)
            var imageName = "" , imageAddress = ""
            do {
                try imageData.write(to: imageURL)
                imageName = imageURL.lastPathComponent
                imageAddress = imageURL.path

            } catch {
                print("Error saving image: \(error)")
            }
                        
            // Get date
            guard let captureDatee = captureDate else {return}
            
            // Save photo in gallety
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            // Save info in realm
            viewModel.savePhotoToRealm(size: imageSizeInBytes, date: captureDatee, name: imageName , address: imageAddress)

        }
        
        picker.dismiss(animated: true)
        
    }
}
