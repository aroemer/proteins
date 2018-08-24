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
        view.addSubview(nameTF)
        view.backgroundColor = .red
        setUpValues()
        
    }
    
    func setUpValues() {
        print(record.name)
        nameTF.text = record.name
        nameTF.placeholder = "Your Name"
        nameTF.textAlignment = .center
    }
}
