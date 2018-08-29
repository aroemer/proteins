//
//  LigandController.swift
//  Proteins
//
//  Created by Audrey Roemer on 24/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit
import SceneKit

class LigandController: UIViewController {
    
    var  record: Ligands? {
        didSet {
            guard let ligand = record else { return }
            title = ligand.name
        }
    }
    var  delegate: ListController!
    var dictAtom = [Atoms]()
    let scene = SCNScene()

//    var dictConect: [String]
//    var scene = SCNScene()

//    var segmentedControl: UISegmentedControl!

    
    let nameTF = UILabel(frame: CGRect(x: 20, y: 50, width: 200, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        view.backgroundColor = .red
        
//        segmentedControl = UISegmentedControl(items: ["Tweets", "Media", "Likes"])
//        self.addSubview(segmentedControl)

        setUpValues()
        let myURLString = "https://files.rcsb.org/ligands/\(String(describing: record!.name.first!))/\(String(describing: record!.name))/\(String(describing: record!.name))_ideal.pdb"
        print(myURLString)
        
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: String.Encoding.utf8)
            DispatchQueue.main.async {
                for atom in myHTMLString.components(separatedBy: "\n") {
                    var atomDetails = atom.split(separator: " ")
                    print(atom)
                    if atom.starts(with: "ATOM") {
//                        print(atom)
                        self.dictAtom.append(Atoms(id: Int(atomDetails[1])!, x: Float(atomDetails[6])!, y: Float(atomDetails[7])!, z: Float(atomDetails[8])!, name: String(atomDetails[11])))
                    }
                    if atom.starts(with: "CONECT") {
//                        print(atom)
                        let fromId : Int = Int(atomDetails[1])!
                        let fromAtom = self.getAtom(id: fromId)

                        let to = atomDetails[2..<atomDetails.count]
                        for elem in to {
                            let toAtom = self.getAtom(id: Int(elem)!)
                            let CylNode = LineNode(
                                parent: self.scene.rootNode,
                                source:    SCNVector3(x:fromAtom!.x, y:fromAtom!.y, z:fromAtom!.z),
                                destination: SCNVector3(x:toAtom!.x, y:toAtom!.y, z:toAtom!.z),
                                radius: 0.2,
                                radSegmentCount: 6,
                                color: UIColor.darkGray
                            )
                            self.scene.rootNode.addChildNode(CylNode)
                            
                            
                        }

//                        self.dictConect.append(String(atomDetails))
                        
                    }
                }
                self.record?.atoms = self.dictAtom
                self.sceneSetup()

//                print(self.record)
//                print(myHTMLString)
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        catch let error {
            print("Error: \(error)")
        }
        
    }
    
    func getAtom(id:Int) -> Atoms?{
        if let atom = dictAtom.first(where: { $0.id == id }) {
            return (atom)
        }
        return nil
    }
    
    func sceneSetup() {
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLight.LightType.omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 25)
        scene.rootNode.addChildNode(cameraNode)
        
        let scnView = SCNView(frame: view.frame)
        view.addSubview(scnView)
        scnView.scene = scene
        scnView.backgroundColor = UIColor.black
        scnView.allowsCameraControl = true
        scnView.pointOfView = cameraNode
        // scnView.showsStatistics = true
        
        for atom in (record?.atoms)! {
            var col: Color
            col = ColorFactory.makeCPKColor(atom: atom)
//            print(atom)
            let sphereGeometry = SCNSphere(radius: 0.5)
            let sphereNode = SCNNode(geometry: sphereGeometry)
            sphereGeometry.firstMaterial?.diffuse.contents = UIColor(red: CGFloat(col.r) / 255.0, green: CGFloat(col.g) / 255.0, blue: CGFloat(col.b) / 255.0, alpha: 1)
            sphereNode.position = SCNVector3(x: atom.x, y: atom.y, z: atom.z)
            sphereNode.name = atom.name
            scene.rootNode.addChildNode(sphereNode)
        }
        
        
        
//        sphereGeometry.firstMaterial?.diffuse.contents = UIColor.red

        
        
//        let secondSphereGeometry = SCNSphere(radius: 0.5)
//        let secondSphereNode = SCNNode(geometry: secondSphereGeometry)
//        //color
//        secondSphereGeometry.firstMaterial?.diffuse.contents = UIColor.green
//        //position
//        secondSphereNode.position = SCNVector3(x: 3.0, y: 0.0, z: 0.0)
//        scene.rootNode.addChildNode(secondSphereNode)


        
        
//        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
//        sceneView.addGestureRecognizer(panRecognizer)

    }
    
    func setUpValues() {
//        print(record.name)
        nameTF.text = record?.name
        nameTF.textColor = .white
        nameTF.textAlignment = .center
        view.addSubview(nameTF)
    }
    
    func setUpConstraints() {
        //add autolayout contstraints
//        sceneView.translatesAutoresizingMaskIntoConstraints = false
//        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        sceneView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        let edgesInset: CGFloat = 10.0
//        let centerOffset: CGFloat = 62.0
//        segmentedControl.autoPinEdge(toSuperviewEdge: .bottom, withInset: edgesInset)
//        segmentedControl.autoPinEdge(toSuperviewEdge: .left, withInset: edgesInset)
//        segmentedControl.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInset)
        
    }
    
    
}
private extension SCNVector3{
    func distance(receiver:SCNVector3) -> Float{
        let xd = receiver.x - self.x
        let yd = receiver.y - self.y
        let zd = receiver.z - self.z
        let distance = Float(sqrt(xd * xd + yd * yd + zd * zd))
        return (distance)
    }
}
