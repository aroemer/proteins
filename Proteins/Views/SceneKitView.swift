//
//  SceneKitView.swift
//  Proteins
//
//  Created by Audrey Roemer on 30/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import SceneKit

class SceneKitView : SCNScene {
    
    enum ModelType {
        case sticksAndBalls
        case spaceFilling
    }
    
    var ligand : Ligands
    public let hydrogens : Bool
    public var cameraNode: SCNNode?
    public let modelType : ModelType
    let ligandNode : SCNNode?
    
    init(ligand:Ligands, hydrogens: Bool, modelType: ModelType, camera: SCNNode?) {
        
        self.ligand = ligand
        self.hydrogens = hydrogens
        cameraNode = camera
        self.modelType = modelType
        ligandNode = SCNNode()
        super.init()
        
        lightSetup()
        
        self.rootNode.addChildNode(ligandNode!)
        ligandNode?.addChildNode(addAtoms())
        ligandNode?.addChildNode(addConects())
        if (cameraNode == nil) {
            setUpCamera()
        }
        startRotate()

        self.rootNode.addChildNode(cameraNode!)
//        let camNode = self.rootNode.childNode(withName: "Camera", recursively: false)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startRotate() {
        let rotateNode = SCNAction.rotateBy(x: 0, y: CGFloat(Double.pi / 4), z: 0, duration: TimeInterval(2))
        let infiniteRotate = SCNAction.repeatForever(rotateNode)
        ligandNode?.runAction(infiniteRotate, forKey: "infiniteRotate")
    }
    
    public func stopRotate() {
        ligandNode?.removeAction(forKey: "infiniteRotate")
    }
    
    func setUpCamera() {
        cameraNode = SCNNode()
        cameraNode?.name = "Camera"
        cameraNode?.camera = SCNCamera()
        cameraNode?.position = SCNVector3Make(0, 0, 25)
    }
    
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
            
            if hydrogens == false && atom.name == "H" {
                continue
            }
            
            var sphereGeometry : SCNSphere
            if modelType == .sticksAndBalls {
                sphereGeometry = SCNSphere(radius: 0.5)
            } else if modelType == .spaceFilling {
                sphereGeometry = SCNSphere(radius: 1.5)
                if atom.name == "H" {
                    sphereGeometry = SCNSphere(radius: 1)
                }
            } else {
                sphereGeometry = SCNSphere(radius: 1)
            }
            
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
                
                if toAtom == nil || fromAtom == nil {
                    continue
                }
                if hydrogens == false && (toAtom!.name == "H" || fromAtom!.name == "H") {
                    continue
                }
                
                let CylNode = Cylinder(
                                parent: conectsNode,
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
