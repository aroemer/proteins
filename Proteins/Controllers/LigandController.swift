//
//  LigandController.swift
//  Proteins
//
//  Created by Audrey Roemer on 24/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

class LigandController: UIViewController {
    
    var  record = Ligands()
    var  delegate: ListController!
    
    let nameTF = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        view.addSubview(nameTF)
        view.backgroundColor = .red
//        setUpValues()
        let myURLString = "https://files.rcsb.org/ligands/\(String(describing: record.name.first!))/\(record.name)/\(record.name)_ideal.pdb"
        print(myURLString)
        
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: String.Encoding.utf8)
            DispatchQueue.main.async {
                print(myHTMLString)
            }
        } catch let error {
            print("Error: \(error)")
        }
        
    }
    
    func setUpValues() {
        print(record.name)
        nameTF.text = record.name
        nameTF.placeholder = "Your Name"
        nameTF.textAlignment = .center
    }
}
