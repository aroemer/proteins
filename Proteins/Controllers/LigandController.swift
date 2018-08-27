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
    
    var  record = Ligands()
    var  delegate: ListController!
    var dictAtom = [Atoms]()
//    var segmentedControl: UISegmentedControl!

    
    let nameTF = UILabel(frame: CGRect(x: 20, y: 50, width: 200, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        view.backgroundColor = .red
        
//        segmentedControl = UISegmentedControl(items: ["Tweets", "Media", "Likes"])
//        self.addSubview(segmentedControl)

        sceneSetup()
        setUpValues()
        let myURLString = "https://files.rcsb.org/ligands/\(String(describing: record.name.first!))/\(record.name)/\(record.name)_ideal.pdb"
        print(myURLString)
        
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: String.Encoding.utf8)
            DispatchQueue.main.async {
                for atom in myHTMLString.components(separatedBy: "\n") {
                    if atom.starts(with: "ATOM") {
                        let atomDetails = atom.split(separator: " ")
                        self.dictAtom.append(Atoms(id: Int(atomDetails[1])!, x: Float(atomDetails[6])!, y: Float(atomDetails[7])!, z: Float(atomDetails[8])!, name: String(atomDetails[11])))
                    }
                    if atom.starts(with: "CONECT") {
//                        print("conect: \(atom)")
                    }
                }
                self.record.atoms = self.dictAtom
                print(self.record)
//                print(myHTMLString)
            }
        }
        catch let error {
            print("Error: \(error)")
        }
        
    }
    
    func sceneSetup() {
        let scene = SCNScene()
        
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
        
        let sphereGeometry = SCNSphere(radius: 1.0)
        let sphereNode = SCNNode(geometry: sphereGeometry)
        sphereGeometry.firstMaterial?.diffuse.contents = UIColor.red

        
        scene.rootNode.addChildNode(sphereNode)
        
        let secondSphereGeometry = SCNSphere(radius: 0.5)
        let secondSphereNode = SCNNode(geometry: secondSphereGeometry)
        //color
        secondSphereGeometry.firstMaterial?.diffuse.contents = UIColor.green
        //position
        secondSphereNode.position = SCNVector3(x: 3.0, y: 0.0, z: 0.0)
        scene.rootNode.addChildNode(secondSphereNode)


        
        
//        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
//        sceneView.addGestureRecognizer(panRecognizer)

    }
    
    func setUpValues() {
        print(record.name)
        nameTF.text = record.name
        nameTF.textColor = .white
        nameTF.textAlignment = .center
        view.addSubview(nameTF)
    }
    
    func setUpConstraints() {
//        let edgesInset: CGFloat = 10.0
//        let centerOffset: CGFloat = 62.0
//        segmentedControl.autoPinEdge(toSuperviewEdge: .bottom, withInset: edgesInset)
//        segmentedControl.autoPinEdge(toSuperviewEdge: .left, withInset: edgesInset)
//        segmentedControl.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInset)
        
    }
}
