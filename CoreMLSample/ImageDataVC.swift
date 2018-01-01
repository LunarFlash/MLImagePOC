//
//  ImageDataVC.swift
//  CoreMLSample
//  https://stackoverflow.com/questions/40175160/exif-data-read-and-write
//  Created by Yi Wang on 1/1/18.
//  Copyright © 2018 Yi Wang. All rights reserved.
//

import UIKit
import ImageIO
import AssetsLibrary
import CoreLocation

class ImageDataVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didPressCameraButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            
            print(info)
            if let url = info[UIImagePickerControllerReferenceURL] as? URL {
                ALAssetsLibrary().asset(for: url, resultBlock: { (asset) in
                    print(asset?.defaultRepresentation().metadata())
                    if let metadata = asset?.defaultRepresentation().metadata() as? [String : Any]{
                        print(metadata)
                        self.textView.text = metadata.description
                    }
                }, failureBlock: { (error) in
                    print(error)
                })
            } else {
                print("fail")
            }
            
            
            

        }
        dismiss(animated: true, completion: nil)
    }
}
