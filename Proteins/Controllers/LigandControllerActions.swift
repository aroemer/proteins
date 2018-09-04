//
//  LigandControllerActions.swift
//  Proteins
//
//  Created by Jean-christophe BLONDEAU on 9/4/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation
import UIKit
import SceneKit


extension LigandController {
    @objc func pauseAction(sender: UIButton) {
        pauseButton.isHidden = true
        playButton.isHidden = !pauseButton.isHidden
        (scnView.scene as! SceneKitView).stopRotate()
    }
    
    @objc func playAction(sender: UIButton) {
        playButton.isHidden = true
        pauseButton.isHidden = !playButton.isHidden
        (scnView.scene as! SceneKitView).startRotate()
    }
    
    @objc func changeModel(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sceneUpdate(hydrogens: (scnView.scene as! SceneKitView).hydrogens, modelType: .sticksAndBalls)
        case 1:
            sceneUpdate(hydrogens: (scnView.scene as! SceneKitView).hydrogens, modelType: .spaceFilling)
        default:
            sceneUpdate(hydrogens: (scnView.scene as! SceneKitView).hydrogens, modelType: .sticksAndBalls)
        }
    }
    
    @objc func switchAction(sender: UISwitch) {
        if sender.isOn {
            sceneUpdate(hydrogens: true, modelType: (scnView.scene as! SceneKitView).modelType)
        }
        else {
            sceneUpdate(hydrogens: false, modelType: (scnView.scene as! SceneKitView).modelType)
        }
    }
    
    @objc func tapGesture(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: scnView)
        let hitResults = scnView.hitTest(location, options: nil)
        if hitResults.count > 0 {
            guard let atomName = hitResults[0].node.name else { print("no name"); return }
            infoLabel.text = atomName
        }
        else {
            infoLabel.text = ""
        }
    }
    
    @objc func shareButton() {
        let textShare = "Look at this beautiful ligand"
        let activityViewController = UIActivityViewController(activityItems: [textShare, scnView.snapshot()], applicationActivities: nil)
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}
