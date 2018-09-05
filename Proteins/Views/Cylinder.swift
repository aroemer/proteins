//
//  Cylinder.swift
//  Proteins
//
//  Created by Audrey Roemer on 29/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit
import SceneKit

class Cylinder: SCNNode
{
    public let fromAtoms: Atoms?
    public let destAtoms: Atoms?
    
    init( parent: SCNNode,
          source: SCNVector3,
          destination: SCNVector3,
          radius: CGFloat,
          radSegmentCount: Int,
          color: UIColor,
          fromAtom: Atoms,
          destAtom: Atoms)
    {
        self.fromAtoms = fromAtom
        self.destAtoms = destAtom
        super.init()
        
        let height = source.distance(receiver: destination)
        position = source
        let nodeDestination = SCNNode()
        nodeDestination.position = destination
        parent.addChildNode(nodeDestination)
        let zAlign = SCNNode()
        zAlign.eulerAngles.x = Float(Double.pi / 2)
        
        // cylinder setUp
        let cyl = SCNCylinder(radius: radius, height: CGFloat(height))
        cyl.radialSegmentCount = radSegmentCount
        cyl.firstMaterial?.diffuse.contents = color
        let nodeCyl = SCNNode(geometry: cyl )
        nodeCyl.name = "bond: \(String(describing: fromAtom.name)) - \(String(describing: destAtom.name))"
        nodeCyl.position.y = -height/2
        zAlign.addChildNode(nodeCyl)
        addChildNode(zAlign)
        
        constraints = [SCNLookAtConstraint(target: nodeDestination)]
    }
    
    override init() {
        self.fromAtoms = nil
        self.destAtoms = nil
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        self.fromAtoms = nil
        self.destAtoms = nil
        super.init(coder: aDecoder)
    }
}

private extension SCNVector3 {

    func distance(receiver:SCNVector3) -> Float{
        let xd = receiver.x - self.x
        let yd = receiver.y - self.y
        let zd = receiver.z - self.z
        let distance = Float(sqrt(xd * xd + yd * yd + zd * zd))
        return (distance)
    }
}
