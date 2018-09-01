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
    /*
     - Parameters:
     - parent: Needed to add node to your SceneKit
     - source: Source point of the line
     - destination: Destination point of the line
     - radius: SCNCylinder initializator need a radius
     - radSegmentCount: SCNCylinder definition for the number of segment for the cylinder
     */
    
    init( parent: SCNNode,
          source: SCNVector3,
          destination: SCNVector3,
          radius: CGFloat,//somes option for the cylinder
        radSegmentCount: Int, //other option
        color: UIColor,
        fromAtom: Atoms,
        destAtom: Atoms)// color of your node object
    {
        super.init()
        
        //Calcul the height of our line
        let  height = source.distance(receiver: destination)
        
        //set position to v1 coordonate
        position = source
        
        //Create the second node to draw direction vector
        let nodeDestination = SCNNode()
        
        //define his position
        nodeDestination.position = destination
        //add it to parent
        parent.addChildNode(nodeDestination)
        
        //Align Z axis
        let zAlign = SCNNode()
        zAlign.eulerAngles.x = Float(Double.pi / 2)
        
        //create our cylinder
        let cyl = SCNCylinder(radius: radius, height: CGFloat(height))
        cyl.radialSegmentCount = radSegmentCount
        cyl.firstMaterial?.diffuse.contents = color
        
        //Create node with cylinder
        let nodeCyl = SCNNode(geometry: cyl )
        nodeCyl.name = "bond: \(String(describing: fromAtom.name)) - \(String(describing: destAtom.name))"
        nodeCyl.position.y = -height/2
        zAlign.addChildNode(nodeCyl)
        
        addChildNode(zAlign)
        
        //set contraints direction to our vector
        constraints = [SCNLookAtConstraint(target: nodeDestination)]
    }
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
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
