//
//  ViewController.swift
//  DogsVsCats
//
//  Created by Brian Advent on 17.01.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkAnimalButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classificationLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    
    @IBAction func selectImageSource(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let imageSourceActions = UIAlertController(title: "Image Source", message: "Choose an image source to continue.", preferredStyle: .actionSheet)
        imageSourceActions.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }))
        
        imageSourceActions.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(imageSourceActions, animated: true)
        
    }
    
    @IBAction func checkAnimal(_ sender: Any) {
        AnimalDetector.startAnimalDetection(imageView) { (results) in
            guard let animal = results.first else {print("No detection possible"); return}
            DispatchQueue.main.async {
                self.classificationLabel.text = "It's a \(animal)"
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {picker.dismiss(animated: true, completion: nil); print("could not select image"); return}
        imageView.image = selectedImage
        imageView.contentMode = .scaleAspectFill
        checkAnimalButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
