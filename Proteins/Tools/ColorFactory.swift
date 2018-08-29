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
    
    /**
     * Amino acid residue colours (default)
     * http://life.nthu.edu.tw/~fmhsu/rasframe/Color.HTM
     */
    class func makeAminoColor(atom: Atoms) -> Color {
        
        switch atom.name {
        case "ASP" :
            return Color(r: 230, g:  10, b:  10)
        case "GLU" :
            return Color(r: 230, g:  10, b:  10)
        case "LYS" :
            return Color(r:  20, g:  90, b: 255)
        case "ARG" :
            return Color(r:  20, g:  90, b: 255)
        case "PHE" :
            return Color(r:  50, g:  50, b: 170)
        case "TYR" :
            return Color(r:  50, g:  50, b: 170)
        case "GLY" :
            return Color(r: 235, g: 235, b: 235)
        case "ALA" :
            return Color(r: 200, g: 200, b: 200)
        case "HIS" :
            return Color(r: 130, g: 130, b: 210)
        case "CYS" :
            return Color(r: 230, g: 230, b:   0)
        case "MET" :
            return Color(r: 230, g: 230, b:   0)
        case "SER" :
            return Color(r: 250, g: 150, b:   0)
        case "THR" :
            return Color(r: 250, g: 150, b:   0)
        case "ASN" :
            return Color(r:   0, g: 220, b: 220)
        case "GLN" :
            return Color(r:   0, g: 220, b: 220)
        case "LEU" :
            return Color(r:  15, g: 130, b:  15)
        case "VAL" :
            return Color(r:  15, g: 130, b:  15)
        case "ILE" :
            return Color(r:  15, g: 130, b:  15)
        case "TRP" :
            return Color(r: 180, g:  90, b: 180)
        case "PRO" :
            return Color(r: 220, g: 150, b: 130)
        default:
            return Color(r: 255, g:  20, b: 147) // Unknown
        }
    }
}
