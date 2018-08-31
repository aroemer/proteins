//
//  Ligands.swift
//  Proteins
//
//  Created by Audrey Roemer on 24/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation
import SceneKit

class Ligands {
    var name: String
    var allAtoms = [Atoms]()
    var allConects = [Conects]()
    var image: UIImage
//    private lazy var middleSCNVector3 = SCNVector3()
    
    init(ligandName: String){
        name = ligandName
        image = UIImage(named: "atom")!
    }

    func getAtom(id:Int) -> Atoms?{
        if let atom = self.allAtoms.first(where: { $0.id == id }) {
            return (atom)
        }
        return nil
    }
    
//    / private middle SCNVector
//
//    Middle point the representation in 3D.
//    - Returns: SCNVector3 point in middle of all atom coordinate.
//    */
//    mutating
//    func middleVector()->SCNVector3{
//        allAtoms.forEach { (atom) in
//            var middle = self.middleSCNVector3
//            middle.x = (middle.x + atom.x)/2
//            middle.y = (middle.y + atom.y)/2
//            middle.z = (middle.z + atom.z)/2
//            self.middleSCNVector3 = middle
//        }
//        return (self.middleSCNVector3)
//    }
    
    
}
