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
}
