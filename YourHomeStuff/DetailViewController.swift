//
//  DetailViewController.swift
//  YourHomeStuff
//
//  Created by Tyler Jasper on 8/7/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var serialTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
            
        }
    }
    var imageStore: ImageStore! 
    
    let numberFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 3
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .mediumStyle
        formatter.timeStyle = .noStyle
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = item.name
        serialTextField.text = item.serialNumber
        valueTextField.text = numberFormatter.string(from: item.valueInDollars)
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        let key = item.itemKey
        
        let imageToDisplay = imageStore.imageForKey(key: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        // "Save" changes to item
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialTextField.text
        
        if let valueText = valueTextField.text,
            value = numberFormatter.number(from: valueText) {
         item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0 
        }
    }

    //MARK: Image stuff

    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        // if device has a camera take picture, otherwise, picsk from camera roll
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Store the image n the ImageStore for the item's key
        imageStore.setImage(image: image, forKey: item.itemKey)
        
        // put that image on the screen in the imageview
        imageView.image = image
        
        // must call this to take picker off screen
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Keyboard dismiss
    
    @IBAction func backgroundTapped(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
