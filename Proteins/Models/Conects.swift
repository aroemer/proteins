//
//  Conects.swift
//  Proteins
//
//  Created by Audrey Roemer on 30/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit
import Foundation

class Conects {
    
    var data: [String]
    
    lazy var fromAtom:Int? = {
        return (Int(self.data[1]))
        }()!
    
    lazy var toAtom:[Int] = {
        var toAtoms = [Int]()
        for i in 2..<self.data.count {
            if let destination = Int(self.data[i]){
                toAtoms.append(destination)
            }
        }
        return (toAtoms)
        }()
    
    init?(atomString:String){
        let conectData = atomString.components(separatedBy: " ").filter{$0 != ""}
        guard (atomString.starts(with: "CONECT")) else { return nil }
        data = conectData
    }
}
