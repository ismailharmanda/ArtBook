//
//  DetailVC.swift
//  ArtBook
//
//  Created by ismail harmanda on 26.10.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    var test = ""
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistTest: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    
    @IBAction func onSave(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
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
