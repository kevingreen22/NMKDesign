//
//  ColorExtension.swift
//
//  Created by Kevin Green on 7/5/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ColorScheme {
    var nmkMain: Color
    var nmkBackground: Color!
    var nmkDark: Color!
    var nmkLight: Color!
    var nmkShadow: Color!
    var nmkOffWhite: Color!
    
    private var components: [CGFloat]?
        
    init(nmkMain: Color, nmkBackground: Color, nmkDark: Color, nmkLight: Color, nmkShadow: Color, nmkOffWhite: Color) {
        self.nmkMain = nmkMain
        self.nmkBackground = nmkBackground
        self.nmkDark = nmkDark
        self.nmkLight = nmkLight
        self.nmkShadow = nmkShadow
        self.nmkOffWhite = nmkOffWhite
    }
    
    init(main: Color) {
        components = UIColor(main).cgColor.components
        self.nmkMain = main
        self.nmkBackground = setBackground()
        self.nmkDark = setDark()
        self.nmkLight = setLight()
        self.nmkShadow = setShadow()
        self.nmkOffWhite = setOffwhite()
    }
    
    private func setBackground() -> Color {
        return Color(red: Double(components![0]+3.0), green: Double(components![1]+8.0), blue: Double(components![2]+5.0), opacity: Double(components![3]))
    }
    
    private func setDark() -> Color {
        return Color(red: Double(components![0]+3.0), green: Double(components![1]+8.0), blue: Double(components![2]+5.0), opacity: Double(components![3]))
    }
    
    private func setLight() -> Color {
        return Color(red: Double(components![0]+3.0), green: Double(components![1]+8.0), blue: Double(components![2]+5.0), opacity: Double(components![3]))
    }
    
    private func setShadow() -> Color {
        return Color(red: Double(components![0]+3.0), green: Double(components![1]+8.0), blue: Double(components![2]+5.0), opacity: Double(components![3]))
    }
    
    private func setOffwhite() -> Color {
        return Color(red: 0.929, green: 0.949, blue: 0.973, opacity: 1)
    }
    
}


extension Color {
  public static var nmkBackground: Color {
    Color(.nmkBackground)
  }
  
  public static var nmkDark: Color {
    Color(.nmkDark)
  }
  
  public static var nmkShadow: Color {
    Color(.nmkShadow)
  }
  
  public static var nmkMain: Color {
    Color(.nmkMain)
  }
  
  public static var nmkLight: Color {
    Color(.nmkLight)
  }
  
  public static var nmkOffWhite: Color {
    Color(.nmkOffWhite)
  }
}

