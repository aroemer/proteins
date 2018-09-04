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
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Hydrogens"
        return label
    }()
    
    lazy var pauseButton: UIButton = {
        let actionImage = UIImage(named: "pause")
        let myButton = UIButton()
        myButton.setImage(actionImage, for: .normal)
        myButton.addTarget(self, action: #selector(pauseAction(sender:)), for: UIControlEvents.touchUpInside)
        return myButton
    }()
    
    lazy var playButton: UIButton = {
        let actionImage = UIImage(named: "play")
        let myButton = UIButton()
        myButton.setImage(actionImage, for: .normal)
        myButton.addTarget(self, action: #selector(playAction(sender:)), for: UIControlEvents.touchUpInside)
        myButton.isHidden = true
        return myButton
    }()
    
    let scnView = SCNView()
    let switchButton = UISwitch()

    var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.action, target: self, action: #selector(LigandController.shareButton))
        
        self.navigationItem.rightBarButtonItem = shareBar
        super.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
            self.parsePdbFile()
            DispatchQueue.main.async {
                self.sceneSetup()
                self.switchSetup()
                self.segmentedSetup()
                self.infoLabelSetup()
                self.actionButtonsSetup()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .listDarkGray
    }
    
    enum MyError: Error {
        case runtimeError(String)
    }
    
    func parsePdbFile() {
        let myURLString = "https://files.rcsb.org/ligands/\(String(describing: record!.name.first!))/\(String(describing: record!.name))/\(String(describing: record!.name))_ideal.pdb"
        
        guard let myURL = URL(string: myURLString) else { return }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: String.Encoding.utf8)
            for line in myHTMLString.components(separatedBy: "\n") {
                if let atom = Atoms(atomString: line){
                    self.record?.allAtoms.append(atom)
                }
                if let conect = Conects(atomString: line) {
                    self.record?.allConects.append(conect)
                }
            }
            
        }
        catch let error {
            let alertController = UIAlertController(title: nil, message: "Loading Error : \(error)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func sceneUpdate(hydrogens: Bool, modelType: SceneKitView.ModelType) {
        scnView.scene = SceneKitView(ligand : record!, hydrogens : hydrogens, modelType: modelType, camera: scnView.pointOfView)
        guard let myScene = scnView.scene as? SceneKitView else {
            return
        }
        let cameraNode = myScene.cameraNode
        scnView.pointOfView = cameraNode
    }
    
    func sceneSetup() {
        view.addSubview(scnView)
        scnView.backgroundColor = .listDarkGray
        scnView.scene = SceneKitView(ligand : record!, hydrogens : true, modelType: .sticksAndBalls, camera: nil)
        scnView.allowsCameraControl = true
        let cameraNode = scnView.scene?.rootNode.childNode(withName: "Camera", recursively: false)
        scnView.pointOfView = cameraNode
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(recognizer:)))
        scnView.addGestureRecognizer(tapGesture)
        _ = scnView.fill(view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
