//
//  TouchController.swift
//  Proteins
//
//  Created by Audrey ROEMER on 8/17/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchController: UIViewController {
    
    let background: UIImageView = {
        let image = UIImage(named: "background")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var touchIDButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        let fingerprint = UIImage(named: "fingerprint") as UIImage?
//        button.setTitle("Sign in", for: .normal)
//        button.setImage(fingerprint, for: .normal)
////        button.titleLabel?.font = .futuraBook(ofSize: 25.2)
//        button.addTarget(self, action: #selector(handleTouchID), for: .touchUpInside)
//        return button
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
//        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleTouchID), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(touchIDButton)
//        view.addSubview(background)
        
        
        setupLayouts()
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupLayouts() {
        touchIDButton.backgroundColor = .blue

        touchIDButton.center = view.center
        touchIDButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        touchIDButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        _ = touchIDButton.center(view)
    }
    
    @objc func handleTouchID() {
        let context = LAContext()
        var error: NSError?
        
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(success : Bool, error: Error?) -> Void in
                    if success {
                        self.showAlertController("Touch ID Authentication Succeeded")
                        //                        self.performSegue(withIdentifier: "toTheList", sender: self.view)
                        
                    }
                    else {
                        self.showAlertController("Touch ID Authentication Failed")
                    }
            })
        }
        else {
            self.touchIDButton.isHidden = true
        }
    }
}
