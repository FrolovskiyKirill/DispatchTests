//
//  SecondViewController.swift
//  DispatchTests
//
//  Created by Kirill Frolovskiy on 15.12.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityImdicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        
        get {
            return imageView.image
        }
        
        set {
            activityImdicator.startAnimating()
            activityImdicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3, closure: loginAlert)
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () ->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Registrated?", message: "Your login and password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Enter your login"
        }
        
        ac.addTextField { (passwordTF) in
            passwordTF.placeholder = "Enter your password"
            passwordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://sportishka.com/uploads/posts/2022-08/1660232484_11-sportishka-com-p-lemmi-motorkhed-krasivo-foto-19.jpg")
        activityImdicator.isHidden = false
        activityImdicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData =  try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}

