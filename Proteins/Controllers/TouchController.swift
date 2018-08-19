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
    
    let context = LAContext()
    var error: NSError?
    private let listController = ListController()
    
    let background: UIImageView = {
        let image = UIImage(named: "molecules")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var touchIDButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let fingerprint = UIImage(named: "fingerprint") as UIImage?
        button.setBackgroundImage(fingerprint, for: .normal)
        button.addTarget(self, action: #selector(handleTouchID), for: .touchUpInside)
        return button
    }()
    
    func checkTouchID() {
        
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            touchIDButton.isHidden = false
        }
        else {
            touchIDButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        checkTouchID()
        self.setupConstraints()
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)

    }
    
    func addSubviews() {
        self.view.addSubview(background)
        self.view.addSubview(touchIDButton)
    }
    
    func setupConstraints() {
        touchIDButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        touchIDButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        touchIDButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100.0).isActive = true
//        touchIDButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0).isActive = true
        touchIDButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        touchIDButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

    }
    
    @objc func handleTouchID() {
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(success : Bool, error: Error?) -> Void in
                    if success {
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(self.listController, animated: true)
                        }
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
