//
//  UIView + Constraint.swift
//  Proteins
//
//  Created by Audrey ROEMER on 8/29/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

extension UIView {
    
    enum FillingDirection {
        case horizontaly, verticaly
    }
    
    enum DimensionAttribute {
        case width, height
    }
    
    func fill(_ view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
        var result = [ NSLayoutAttribute: NSLayoutConstraint ]()
        
        result.merge(fill(.horizontaly, view, constant: constant, multiplier: multiplier, active: active)) { (current, _) -> NSLayoutConstraint in current }
        result.merge(fill(.verticaly, view, constant: constant, multiplier: multiplier, active: active)) { (current, _) -> NSLayoutConstraint in current }
        return result
    }
    
    func fill(_ type: FillingDirection, _ view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
        return fill(type, view, leading: constant, trailing: constant, multiplier: multiplier, active: active)
    }
    
    func fill(_ type: FillingDirection, _ view: Any, leading: CGFloat, trailing: CGFloat, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
        var result = [ NSLayoutAttribute: NSLayoutConstraint ]()
        
        switch type {
        case .horizontaly:
            result[.leading] = constraint(.leading, to: view, constant: leading, multiplier: multiplier, active: active)
            result[.trailing] = constraint(.trailing, to: view, constant: trailing, multiplier: multiplier, active: active)
        case .verticaly:
            result[.top] = constraint(.top, to: view, constant: leading, multiplier: multiplier, active: active)
            result[.bottom] = constraint(.bottom, to: view, constant: trailing, multiplier: multiplier, active: active)
        }
        return result
    }
    
    func center(_ view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> [ NSLayoutAttribute: NSLayoutConstraint ] {
        var result = [ NSLayoutAttribute: NSLayoutConstraint ]()
        
        result[.centerX] = center(.horizontaly, view, constant: constant, multiplier: multiplier, active: active)
        result[.centerY] = center(.verticaly, view, constant: constant, multiplier: multiplier, active: active)
        return result
    }
    
    func center(_ type: FillingDirection, _ view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
        switch type {
        case .horizontaly: return constraint(.centerX, to: view, constant: constant, multiplier: multiplier, active: active)
        case .verticaly: return constraint(.centerY, to: view, constant: constant, multiplier: multiplier, active: active)
        }
    }
    
    func constraint(dimension attribute: NSLayoutAttribute, constant: CGFloat, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
        var constraint = NSLayoutConstraint()
        
        switch attribute {
        case .height, .width: constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constant)
        default: return NSLayoutConstraint()
        }
        constraint.isActive = active
        return constraint
    }
    
    func constraint(_ attribute: NSLayoutAttribute, to view: Any, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
        return constraint(attribute, to: view, attribute, constant: constant, multiplier: multiplier, active: active)
    }
    
    func constraint(_ attribute: NSLayoutAttribute, to view: Any, _ parentAttribute: NSLayoutAttribute, constant: CGFloat = 0, multiplier: CGFloat = 1, active: Bool = true) -> NSLayoutConstraint {
        guard view as? UIView != nil || view as? UILayoutGuide != nil else {
            fatalError("[ToolboxLGNT]: Constraint can only be applied between view and another UIView or a UILayoutGuide.")
        }
        
        var inverse: CGFloat {
            switch attribute {
            case .bottom, .trailing, .right: return -1
            default: return 1
            }
        }
        
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: view, attribute: parentAttribute, multiplier: multiplier, constant: constant * inverse)
        
        translatesAutoresizingMaskIntoConstraints = false
        constraint.isActive = active
        return constraint
    }
    
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
                print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}
