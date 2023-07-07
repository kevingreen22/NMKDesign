//
//  LinearGradientExtension.swift
//
//  Created by Kevin Green on 7/5/22.
//

import SwiftUI

extension LinearGradient {
  public static var diagonalDarkBorder: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.nmkOffWhite, .nmkMain]), // [.white, .gray]
      startPoint: UnitPoint(x: -0.2, y: 0.5),
      endPoint: .bottomTrailing
    )
  }
  
  public static var diagonalLightBorder: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.nmkOffWhite, .nmkLight]), // [.white, .nmkLight]
      startPoint: UnitPoint(x: 0.2, y: 0.2),
      endPoint: .bottomTrailing
    )
  }
  
  public static var horizontalDark: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.nmkShadow, .nmkDark]),
      startPoint: .leading,
      endPoint: .trailing
    )
  }
  
  public static var horizontalDarkReverse: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.nmkDark, .nmkShadow]),
      startPoint: .leading,
      endPoint: .trailing
    )
  }
  
  public static var horizontalDarkToLight: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.nmkShadow, Color.white.opacity(0.0), .nmkOffWhite]), // [.nmkShadow, Color.white.opacity(0.0), .white]
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  public static var verticalLightToDark: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.nmkOffWhite, Color.white.opacity(0.0), .nmkShadow]), // [.white, Color.white.opacity(0.0), .nmkShadow]
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  public static var horizontalLight: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.nmkOffWhite, .nmkBackground]), //[.white, .nmkBackground]
      startPoint: .leading,
      endPoint: .trailing
    )
  }
}

