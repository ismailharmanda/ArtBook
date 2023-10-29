//
//  DetailVC.swift
//  ArtBook
//
//  Created by ismail harmanda on 26.10.2023.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var test = ""
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistTest: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    
    @IBAction func onSave(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Painting", into: context)
        
        newPainting.setValue(nameText.text, forKey: "name")
        newPainting.setValue(artistTest.text, forKey: "artist")
        
        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newData"), object: nil)
        } catch {
            print(error,"bir hata var")
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        view.addGestureRecognizer(gestureRecognizer)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
