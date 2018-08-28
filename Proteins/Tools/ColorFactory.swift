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
            return Color(r: 105, g: 105, b: 105) // Carbon
        case "O" :
            return Color(r: 240, g:   0, b:   0) // Oxygen
        case "H" :
            return Color(r: 255, g: 255, b: 255) // Hydrogen
        case "N" :
            return Color(r: 143, g: 143, b: 255) // Nitrogen
        case "S" :
            return Color(r: 255, g: 200, b:  50) // Sulphur
        case "Cl" :
            return Color(r:   0, g: 255, b:   0) // Chlorine
        case "B" :
            return Color(r:   0, g: 255, b:   0) // Boron
        case "P" :
            return Color(r: 255, g: 165, b:   0) // Phosphorus
        case "P" :
            return Color(r: 255, g: 165, b:   0) // Iron
        case "P" :
            return Color(r: 255, g: 165, b:   0) // Barium
        case "Na" :
            return Color(r:   0, g:   0, b: 255) // Sodium
        case "Mg" :
            return Color(r:  34, g: 139, b:  34) // Magnesium
        case "Zn" :
            return Color(r: 165, g:  42, b:  42) // ?
        case "Cu" :
            return Color(r: 165, g:  42, b:  42) // ?
        case "Ni" :
            return Color(r: 165, g:  42, b:  42) // ?
        case "Br" :
            return Color(r: 165, g:  42, b:  42) // ?
        case "Ca" :
            return Color(r: 128, g: 128, b: 144) // ?
        case "Mn" :
            return Color(r: 128, g: 128, b: 144) // ?
        case "Al" :
            return Color(r: 128, g: 128, b: 144) // ?
        case "Ti" :
            return Color(r: 128, g: 128, b: 144) // ?
        case "Cr" :
            return Color(r: 128, g: 128, b: 144) // ?
        case "Ag" :
            return Color(r: 128, g: 128, b: 144) // ?
        case "F" :
            return Color(r: 218, g: 165, b:  32) // ?
        case "Si" :
            return Color(r: 218, g: 165, b:  32) // ?
        case "Au" :
            return Color(r: 218, g: 165, b:  32) // ?
        case "I" :
            return Color(r: 160, g:  32, b:  240) // Iodine
        case "Li" :
            return Color(r: 178, g:  34, b:   34) // Lithium
        case "He" :
            return Color(r: 255, g: 192, b: 203) // Lithium
        default:
            return Color(r: 255, g:  20, b: 147) // Unknown
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
