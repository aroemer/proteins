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
    
    let scnView = SCNView()


//    var segmentedControl: UISegmentedControl!

    
//    let nameTF = UILabel(frame: CGRect(x: 20, y: 50, width: 200, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parsePdbFile()
        sceneSetup()

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
//        segmentedControl = UISegmentedControl(items: ["Tweets", "Media", "Likes"])
//        self.addSubview(segmentedControl)

//        setUpValues()
        
    }
    
    func parsePdbFile() {
        let myURLString = "https://files.rcsb.org/ligands/\(String(describing: record!.name.first!))/\(String(describing: record!.name))/\(String(describing: record!.name))_ideal.pdb"
        
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: String.Encoding.utf8)
//            DispatchQueue.main.async {
                for line in myHTMLString.components(separatedBy: "\n") {
                    if let atom = Atoms(atomString: line){
                        self.record?.allAtoms.append(atom)
                    }
                    if let conect = Conects(atomString: line) {
                        self.record?.allConects.append(conect)
                    }
                }
//            }
        }
        catch let error {
            print("Error: \(error)")
        }
    }
    
    func getAtom(id:Int) -> Atoms? {
        if let atom = record?.allAtoms.first(where: { $0.id == id }) {
            return (atom)
        }
        return nil
    }
    
    func sceneSetup() {
        let scene = SCNScene()
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 25)
        scene.rootNode.addChildNode(cameraNode)
        
        view.addSubview(scnView)
        scnView.scene = SceneKitView(ligand : record!)
        scnView.backgroundColor = .listDarkGray
        scnView.allowsCameraControl = true
        scnView.pointOfView = cameraNode
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(recognizer:)))
        scnView.addGestureRecognizer(tapGesture)
        
        _ = scnView.fill(view)
    }
    
    @objc func tapGesture(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: scnView)
        let hitResults = scnView.hitTest(location, options: nil)
        if hitResults.count > 0 {
            guard let atomName = hitResults[0].node.name else { print("no name"); return }
            print(atomName)
        }
        else {
            print("no atom in here")
        }

        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(recognizer:)))
        //        sceneView.addGestureRecognizer(tapGesture)
    }

//        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
//        sceneView.addGestureRecognizer(panRecognizer)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: "sceneTapped:")
//        let gestureRecognizers = NSMutableArray()
//        gestureRecognizers.addObject(tapGesture)
//        if let arr = scnView.gestureRecognizers { gestureRecognizers.addObjectsFromArray(arr) }
//        scnView.gestureRecognizers = gestureRecognizers as [AnyObject]

    }
    
    func setUpValues() {
//        print(record.name)
//        nameTF.text = record?.name
//        nameTF.textColor = .white
//        nameTF.textAlignment = .center
//        view.addSubview(nameTF)
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


