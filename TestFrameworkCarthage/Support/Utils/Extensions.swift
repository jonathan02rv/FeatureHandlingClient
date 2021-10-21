//
//  Extensions.swift
//  AppClient
//
//  Created by Jhonatahan Orlando Rivera Vilcapoma on 8/07/21.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (hexString.hasPrefix("#")) {
            hexString.remove(at: hexString.startIndex)
        }
        let scanner = Scanner(string: hexString)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
}
