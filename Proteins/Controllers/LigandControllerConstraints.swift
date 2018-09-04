//
//  LigandControllerConstraints.swift
//  Proteins
//
//  Created by Jean-christophe BLONDEAU on 9/4/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation

import UIKit
import SceneKit

extension LigandController {
    func switchSetup() {
        switchButton.isOn = true
        switchButton.addTarget(self, action: #selector(switchAction(sender:)), for: UIControlEvents.valueChanged)
        scnView.addSubview(switchButton)
        _ = switchButton.constraint(.trailing, to: scnView, constant: 30)
        _ = switchButton.constraint(.top, to: scnView, constant: 80)
        
    }
    
    func segmentedSetup() {
        segmentedControl = UISegmentedControl(items: ["Sticks & Balls", "Space filling"])
        scnView.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(changeModel(sender:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .white
        _ = segmentedControl.center(.horizontaly, scnView)
        _ = segmentedControl.constraint(.bottom, to: scnView, constant: 30)
    }
    
    func infoLabelSetup() {
        scnView.addSubview(infoLabel)
        scnView.addSubview(switchLabel)
        _ = infoLabel.constraint(dimension: .width, constant: 200)
        _ = infoLabel.constraint(dimension: .height, constant: 50)
        _ = infoLabel.constraint(.bottom, to: segmentedControl, .top, constant: -5)
        _ = infoLabel.center(.horizontaly, scnView)
        
        _ = switchLabel.constraint(dimension: .width, constant: 100)
        _ = switchLabel.constraint(dimension: .height, constant: 50)
        _ = switchLabel.constraint(.trailing, to: switchButton, .leading, constant: 5)
        _ = switchLabel.constraint(.top, to: scnView, constant: 70)
    }
    
    func actionButtonsSetup() {
        scnView.addSubview(pauseButton)
        scnView.addSubview(playButton)
        _ = pauseButton.constraint(.leading, to: scnView, constant: 15)
        _ = pauseButton.constraint(.top, to: scnView, constant: 80)
        _ = pauseButton.constraint(dimension: .width, constant: 30)
        _ = pauseButton.constraint(dimension: .height, constant: 30)
        _ = playButton.constraint(.leading, to: scnView, constant: 15)
        _ = playButton.constraint(.top, to: scnView, constant: 80)
        _ = playButton.constraint(dimension: .width, constant: 30)
        _ = playButton.constraint(dimension: .height, constant: 30)
    }
}
