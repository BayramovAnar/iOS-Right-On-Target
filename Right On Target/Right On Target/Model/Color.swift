//
//  Color.swift
//  Right On Target
//
//  Created by Anar Bayramov on 5/2/22.
//

import Foundation
import UIKit


// to work with colors, we are going to create our own data type Color

protocol ColorProtocol{
    var red: UInt8 {get set}
    var green: UInt8 {get set}
    var blue: UInt8 {get set}
    
    init(from: UIColor)
    
    func getByHEXString() -> String
    func getByUIColor() -> UIColor
}


/*
 The structure will be used in conjuction with the Generic SecretValue, in which type T
 should correspond to the protocol Equatable
*/

struct Color: ColorProtocol, Equatable {
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    
    init() {
        red = 0
        green = 0
        blue = 0
    }
    
    init(from color: UIColor) {
        red = UInt8(CGFloat(255) * color.cgColor.components![0])
        green = UInt8(CGFloat(255) * color.cgColor.components![1])
        blue = UInt8(CGFloat(255) * color.cgColor.components![2])
    }
    
    func getByHEXString() -> String {
        //changing values to hexadecimal values using String init
        
        var redPart = String(red, radix: 16, uppercase: true)
        
        if red <= 16 {
            redPart = "0\(redPart)"
        }
        
        var greenPart = String(green, radix: 16, uppercase: true)
        
        if green <= 16 {
            greenPart = "0\(greenPart)"
        }
        
        var bluePart = String(blue, radix: 16, uppercase: true)
        
        if blue <= 16 {
            bluePart = "0\(bluePart)"
        }
        
        return "\(redPart)\(greenPart)\(bluePart)"
    }
    
    
    func getByUIColor() -> UIColor {
        /*
         to create values of type UIColor for 3 channels we need to use the CGFloat type
         where values change from 0.0 (min) to 1.0 (max)
         
         taking into consideration this analogy, we need to make existing values of 0.0 to 0, and
         255 to 1.0
         */
        
        let redFloat: Float = Float(red)/255
        let greenFloat: Float = Float(green)/255
        let blueFloat: Float = Float(blue)/255
        
        return UIColor(red: CGFloat(redFloat), green: CGFloat(greenFloat), blue: CGFloat(blueFloat), alpha: 1)
    }
    
    static func == (lhs: Color, rhs: Color) -> Bool{
        return
        lhs.red == rhs.red && lhs.green == rhs.green && lhs.blue == rhs.blue
    }
}
