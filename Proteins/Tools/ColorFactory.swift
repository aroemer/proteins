//
//  ColorFactory.swift
//  Proteins
//
//  Created by Audrey Roemer on 28/08/2018.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation

class ColorFactory {
    
    class func makeCPKColor(atom: Atoms) -> Color {
        
        switch atom.name {
        case "C" :
            return Color(r: 105, g: 105, b: 105) // Carbon (darkGray)
        case "O" :
            return Color(r: 240, g:   0, b:   0) // Oxygen (red)
        case "H" :
            return Color(r: 255, g: 255, b: 255) // Hydrogen (white)
        case "N" :
            return Color(r:  39, g: 102, b: 251) // Nitrogen (blue)
        case "S" :
            return Color(r: 255, g: 200, b:  50) // Sulphur (yellow)
        case "CL" :
            return Color(r:  27, g: 185, b:  31) // Chlorine (green)
        case "B" :
            return Color(r: 253, g: 170, b: 123) // Boron (salmon)
        case "P" :
            return Color(r: 255, g: 165, b:   0) // Phosphorus (orange)
        case "FE" :
            return Color(r: 219, g: 119, b:  30) // Iron (darkOrange)
        case "BA" :
            return Color(r: 244, g: 163, b:  40) // Barium (lightOrange)
        case "NA" :
            return Color(r: 119, g:  37, b: 251) // Sodium (violet)
        case "MG" :
            return Color(r:  34, g: 139, b:  34) // Magnesium (green)
        case "ZN" :
            return Color(r: 165, g:  42, b:  42) // Zinc (brown)
        case "CU" :
            return Color(r: 165, g:  42, b:  42) // Copper (brown)
        case "NI" :
            return Color(r: 165, g:  42, b:  42) // Nickel (brown)
        case "BR" :
            return Color(r: 165, g:  42, b:  42) // Bromine (brown)
        case "CA" :
            return Color(r: 128, g: 128, b: 144) // Calcium (gray)
        case "MN" :
            return Color(r: 128, g: 128, b: 144) // Manganese (gray)
        case "AL" :
            return Color(r: 128, g: 128, b: 144) // Aluminium (gray)
        case "TI" :
            return Color(r: 128, g: 128, b: 144) // Titanium (gray)
        case "CR" :
            return Color(r: 128, g: 128, b: 144) // Chromium (gray)
        case "AG" :
            return Color(r: 128, g: 128, b: 144) // Silver (gray)
        case "F" :
            return Color(r: 217, g: 164, b:  50) // Fluorine (gold)
        case "SI" :
            return Color(r: 217, g: 164, b:  50) // Silicon (gold)
        case "AU" :
            return Color(r: 217, g: 164, b:  50) // Gold (gold)
        case "I" :
            return Color(r: 160, g:  32, b:  240) // Iodine (violet)
        case "LI" :
            return Color(r: 178, g:  34, b:   34) // Lithium (fireBrick)
        case "HE" :
            return Color(r: 255, g: 192, b: 203) // Helium (pink)
        default:
            return Color(r: 255, g:  20, b: 147) // Unknown (deepPink)
        }
    }
}
