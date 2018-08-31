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
    let alert = UIAlertController(title: "Touch ID for \"Proteins\"",
                                  message: "\n\n\n\n\n Press the finger print button to login",
                                  preferredStyle: .alert)
    let background: UIImageView = {
        let image = UIImage(named: "background")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let logoImage: UIImageView = {
        let image = UIImage(named: "Sulfur")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let secondImage: UIImageView = {
        let image = UIImage(named: "Praseodymium")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var wifty: UILabel = {
        let label = UILabel(frame: CGRect(x:112, y: 38, width: 115, height: 63))
        label.textAlignment = .center
        label.text = "wifty"
        label.font = .systemFont(ofSize: 52, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy var oteins: UILabel = {
        let label = UILabel(frame: CGRect(x:194, y: 113, width: 148, height: 63))
        label.textAlignment = .center
        label.text = "oteins"
        label.font = .systemFont(ofSize: 52, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    func checkTouchID() {
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            createAlert()
        }
        else {
           showAlertController("Sorry, you can't log in. Touch ID is not available on this device")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        self.setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        checkTouchID()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)

    }
    
    func createAlert() {
        DispatchQueue.main.async {
                let touchIDButton: UIButton = {
                let button = UIButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                let fingerprint = UIImage(named: "touchID") as UIImage?
                button.setBackgroundImage(fingerprint, for: .normal)
                button.addTarget(self, action: #selector(self.handleTouchID), for: .touchUpInside)
                return button
            }()
            self.alert.view.addSubview(touchIDButton)
            touchIDButton.translatesAutoresizingMaskIntoConstraints = false
            _ = touchIDButton.constraint(dimension: .height, constant: 60)
            _ = touchIDButton.constraint(.width, to: touchIDButton, .height)
            _ = touchIDButton.center(.horizontaly, self.alert.view)
            _ = touchIDButton.center(.verticaly, self.alert.view)
            self.present(self.alert, animated: true, completion: nil)
        }
    }
    
    func addSubviews() {
        self.view.addSubview(background)
        self.view.addSubview(logoImage)
        self.view.addSubview(secondImage)
        self.view.addSubview(wifty)
        self.view.addSubview(oteins)
    }
    
    func setupConstraints() {
        _ = background.fill(view)
        _ = logoImage.constraint(dimension: .height, constant: 80)
        _ = logoImage.constraint(.width, to: logoImage, .height)
        _ = logoImage.constraint(.top, to: view, constant: 15)
        _ = logoImage.constraint(.leading, to: view, constant: 30)
        _ = secondImage.constraint(dimension: .height, constant: 80)
        _ = secondImage.constraint(.width, to: secondImage, .height)
        _ = secondImage.constraint(.top, to: view, constant: 95)
        _ = secondImage.constraint(.leading, to: view, constant: 110)
        _ = wifty.constraint(.leading, to: logoImage, .trailing, constant: 2)
        _ = wifty.constraint(.top, to: view, constant: 18)
        _ = oteins.constraint(.top, to: wifty, .bottom, constant: 12)
        _ = oteins.constraint(.leading, to: secondImage, .trailing, constant: 2)
    }
    
    @objc func handleTouchID() {
        self.alert.dismiss(animated: false, completion: nil)
            let reason = "Unlock Proteins with your finger print"
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
}
