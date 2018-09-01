//
//  SceneKitView.swift
//  Proteins
//
//  Created by Audrey Roemer on 30/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import SceneKit

class SceneKitView : SCNScene {
    
    var ligand : Ligands
    
    init(ligand:Ligands) {
        
        self.ligand = ligand
        super.init()
        
        lightSetup()
        self.rootNode.addChildNode(addAtoms())
        self.rootNode.addChildNode(addConects())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setUpCamera() {
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3Make(0, 0, 25)
//        self.rootNode.addChildNode(cameraNode)
//    }
    
    func lightSetup() {
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        self.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLight.LightType.omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        self.rootNode.addChildNode(omniLightNode)
        
    }
    
    func addAtoms() -> SCNNode {
        let atomsNode = SCNNode()
        for atom in ligand.allAtoms {
            var col: Color
            col = ColorFactory.makeCPKColor(atom: atom)
            let sphereGeometry = SCNSphere(radius: 0.5)
            let sphereNode = SCNNode(geometry: sphereGeometry)
            sphereGeometry.firstMaterial?.diffuse.contents = UIColor(red: CGFloat(col.r) / 255.0, green: CGFloat(col.g) / 255.0, blue: CGFloat(col.b) / 255.0, alpha: 1)
            sphereNode.position = SCNVector3(x: atom.x, y: atom.y, z: atom.z)
            sphereNode.name = "atom: \(atom.name)"
            atomsNode.addChildNode(sphereNode)
        }
        return atomsNode
    }
    
    func addConects() -> SCNNode {
        let conectsNode = SCNNode()

        for conect in ligand.allConects {
            let fromAtom = ligand.getAtom(id: conect.fromAtom!)
            for elem in conect.toAtom {
                let toAtom = ligand.getAtom(id: elem)
                let CylNode = Cylinder(
                                parent: self.rootNode,
                                source: SCNVector3(x:fromAtom!.x, y:fromAtom!.y, z:fromAtom!.z),
                                destination: SCNVector3(x:toAtom!.x, y:toAtom!.y, z:toAtom!.z),
                                radius: 0.2,
                                radSegmentCount: 6,
                                color: UIColor.darkGray,
                                fromAtom: fromAtom!,
                                destAtom: toAtom!
                              )
                conectsNode.addChildNode(CylNode)
            }
        }
        return conectsNode
    }
}
