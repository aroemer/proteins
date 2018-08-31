//
//  Atoms.swift
//  Proteins
//
//  Created by Audrey Roemer on 27/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit
import Foundation

class Atoms {
    
    var data:[String]
    
    lazy var id:Int = {
        return (Int(self.data[1]))
        }()!
    
    lazy var x:Float = {
        return (Float(self.data[6]))
        }()!
    
    lazy var y:Float = {
        return (Float(self.data[7]))
        }()!
    
    lazy var z:Float = {
        return (Float(self.data[8]))
        }()!
    
    lazy var name:String = {
        return (self.data[11])
        }()
    
    init?(atomString:String){
        let atomData = atomString.components(separatedBy: " ").filter{$0 != ""}
        guard (atomData.count == 12 && atomString.starts(with: "ATOM")) else { return nil }
        data = atomData
    }
}

