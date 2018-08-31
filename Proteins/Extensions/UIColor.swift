//
//  UIColor.swift
//  Proteins
//
//  Created by Audrey ROEMER on 8/29/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit

extension UIColor {
    static let listDarkBlue = UIColor(r: 9, g: 51, b: 98)
    static let listLighterBlue = UIColor(r: 16, g: 76, b: 132)
    static let listDarkGray = UIColor(r: 24, g: 24, b: 34)
    static let listLighterGray = UIColor(r: 32, g: 32, b: 39)
    static let listSelectedGray = UIColor(r: 56, g: 56, b: 66)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}

