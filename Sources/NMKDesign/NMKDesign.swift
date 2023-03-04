//
//  NMK_Modifiers.swift
//
//  Created by Kevin Green on 7/5/22.
//

import SwiftUI

extension View {
        
    public func NMKRaisedShadow(radius: CGFloat = 7) -> some View {
        self
            .shadow(
                color: Color.nmkShadow.opacity(0.7),
                radius: radius,
                x: radius, y: radius)
            .shadow(
                color: Color(white: 1.0).opacity(0.9),
                radius: radius,
                x: -radius, y: -radius)
    }
    
    public func NMKDepth() -> some View {
        self
            .shadow(color: .white, radius: 2, x: -3, y: -3)
            .shadow(color: .nmkShadow, radius: 2, x: 3, y: 3)
    }
        
    public func NMKBackground(cornerRadius: CGFloat = 15) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(LinearGradient.diagonalDarkBorder, lineWidth: 2)
            )
            .foregroundColor(Color.nmkBackground)
            .cornerRadius(cornerRadius)
            .shadow(color: Color(white: 1.0).opacity(0.9), radius: 18, x: -18, y: -18)
            .shadow(color: Color.nmkShadow.opacity(0.5), radius: 14, x: 14, y: 14)
    }
    
    public func NMKEmbossed<S: Shape>(using shape: S, width: CGFloat = 6, blur: CGFloat = 2) -> some View {
        let blackAngle = Angle.degrees(120)
        let blackX = CGFloat(cos(blackAngle.radians - .pi / 2) * width * 0.6)
        let blackY = CGFloat(sin(blackAngle.radians - .pi / 2) * width * 0.6)
        
        let whiteAngle = Angle.degrees(310)
        let whiteX = CGFloat(cos(whiteAngle.radians - .pi / 2) * width * 0.6)
        let whiteY = CGFloat(sin(whiteAngle.radians - .pi / 2) * width * 0.6)
        
        return self
        // dark blured leading top
            .overlay(
                shape
                    .stroke(LinearGradient.horizontalDark, lineWidth: 3)
                    .offset(x: blackX + 0.4, y: blackY + 0.4)
                    .blur(radius: blur)
                    .mask(shape)
            )
        
        // white blured trailing bottom
            .overlay(
                shape
                    .stroke(.white, lineWidth: 5)
                    .offset(x: whiteX - 0.4, y: whiteY - 0.4)
                    .blur(radius: blur)
                    .mask(shape)
            )
        
        // dark hard thin line leading top
            .overlay(
                shape
                    .stroke(LinearGradient.horizontalDark, lineWidth: 0.4)
                    .offset(x: blackX, y: blackY)
                    .blur(radius: 0.7)
                    .mask(shape)
            )
        
        // white hard thin line trailing bottom
            .overlay(
                shape
                    .stroke(.white, lineWidth: 0.4)
                    .offset(x: whiteX, y: whiteY)
                    .mask(shape)
            )
    }
    
    
    fileprivate func inverseMask<Mask>(_ mask: Mask) -> some View where Mask : View {
        self.mask(mask
            .foregroundColor(.black)
            .background(Color.white)
            .compositingGroup()
            .luminanceToAlpha()
        )
    }
    
    fileprivate func innerShadow<S: Shape>(using shape: S, withOffset: Bool = true, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2) * width * 0.6)
        let finalY = CGFloat(sin(angle.radians - .pi / 2) * width * 0.6)
        
        return self
            .overlay(
                shape
                    .stroke(color)
                    .offset(x: withOffset ? finalX : 0 , y: withOffset ? finalY : 0)
                    .blur(radius: blur)
                    .mask(shape)
            )
    }
    
}


extension Text {
    
    public func NMKText() -> SwiftUI.Text {
        self.foregroundColor(.nmkDark)
    }
    
}


extension Image {
    
    public func NMKImageMod() -> some View {
        LinearGradient.horizontalDark
            .mask(self.resizable().scaledToFit())
            .padding(40)
            .font(.system(size: 150, weight: .thin))
            .shadow(color: .white, radius: 2, x: -3, y: -3)
            .shadow(color: .nmkShadow, radius: 2, x: 3, y: 3)
    }
}





public class NMK {
    
    /// Button Style
    public struct NMKButtonStyle: ButtonStyle {
        let iconName: String?
        let image: Image?
        let width: CGFloat
        let height: CGFloat
        
        public init(iconName: String, width: CGFloat = 100, height: CGFloat = 100) {
            self.iconName = iconName
            self.image = nil
            self.width = width
            self.height = height
        }
        
        public init(image: Image, width: CGFloat = 100, height: CGFloat = 100) {
            self.iconName = nil
            self.image = image
            self.width = width
            self.height = height
        }
        
        
        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .modifier(NMKButton(isPressed: configuration.isPressed, iconName: "gear"))
                .scaleEffect(configuration.isPressed ? 0.999 : 1)
                .animation(.easeInOut(duration: 5), value: configuration.isPressed)
        }
        
    }
    
    private struct ButtonUp: View {
        let iconName: String?
        let image: Image?
        
        init(iconName: String) {
            self.iconName = iconName
            self.image = nil
        }
        
        init(image: Image) {
            self.iconName = nil
            self.image = image
        }
        
        var body: some View {
            GeometryReader { proxy in
                ZStack {
                    RoundedRectangle(cornerRadius: proxy.size.height * 0.175)
                        .foregroundColor(.nmkBackground)
                        .shadow(color: .nmkShadow, radius: 3, x: 3, y: 3)
                        .shadow(color: .white, radius: 3, x: -3, y: -3)
                    
                    LinearGradient.horizontalDarkReverse
                        .mask(getImage()
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(0.5)
                        )
                        .shadow(color: .white, radius: 2, x: -3, y: -3)
                        .shadow(color: .nmkShadow, radius: 2, x: 3, y: 3)
                }
                .compositingGroup()
                .innerShadow(using: RoundedRectangle(cornerRadius: proxy.size.height * 0.175), withOffset: false, color: .white, blur: 0)
                .shadow(color: Color.white.opacity(0.9), radius: 10, x: -5, y: -5)
                .shadow(color: Color.nmkShadow.opacity(0.5), radius: 10, x: 5, y: 5)
                .compositingGroup()
                .innerShadow(using: RoundedRectangle(cornerRadius: proxy.size.height * 0.175), withOffset: false, color: .white, blur: 0)
                .shadow(color: Color.white.opacity(0.9), radius: 10, x: -5, y: -5)
                .shadow(color: Color.nmkShadow.opacity(0.5), radius: 10, x: 5, y: 5)
            }
        }
        
        func getImage() -> Image {
            if iconName != nil {
                return Image(systemName: self.iconName!)
            } else {
                return image!
            }
        }
        
    }
    
    private struct ButtonPressed: View {
        let iconName: String?
        let image: Image?
        
        init(iconName: String) {
            self.iconName = iconName
            self.image = nil
        }
        
        init(image: Image) {
            self.image = image
            self.iconName = nil
        }
        
        var body: some View {
            GeometryReader { proxy in
                ZStack {
                    Rectangle()
                        .foregroundColor(.nmkBackground)
                        .cornerRadius(proxy.size.height * 0.175)
                    
                    Rectangle()
                        .foregroundColor(.nmkBackground)
                        .cornerRadius(proxy.size.height * 0.175)
                        .inverseMask(Rectangle()
                            .cornerRadius(proxy.size.height * 0.175)
                            .padding(proxy.size.height / 27)
                        )
                        .shadow(
                            color: Color.nmkShadow.opacity(0.7),
                            radius: proxy.size.height * 0.07,
                            x: proxy.size.width * 0.07, y: proxy.size.height * 0.07)
                        .shadow(
                            color: Color(white: 1.0).opacity(0.9),
                            radius: proxy.size.height * 0.07,
                            x: -proxy.size.width * 0.07, y: -proxy.size.height * 0.07)
                        .clipShape(RoundedRectangle(cornerRadius: proxy.size.height * 0.175))
                    
                    LinearGradient.horizontalDarkReverse
                        .mask(getImage()
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(0.5)
                        )
                        .shadow(
                            color: Color.nmkShadow.opacity(0.5),
                            radius: proxy.size.height * 0.07,
                            x: proxy.size.width * 0.07, y: proxy.size.height * 0.07)
                        .shadow(
                            color: Color(white: 1.0).opacity(0.9),
                            radius: proxy.size.height * 0.07,
                            x: -proxy.size.width * 0.07, y: -proxy.size.height * 0.07)
                }
                
                .overlay(
                    RoundedRectangle(cornerRadius: proxy.size.height * 0.175)
                        .stroke(LinearGradient.diagonalLightBorder, lineWidth: 2)
                )
            }
        }
        
        func getImage() -> Image {
            if iconName != nil {
                return Image(systemName: self.iconName!)
            } else {
                return image!
            }
        }
        
    }
    
    private struct ButtonDisabled: View {
        let iconName: String?
        let image: Image?
        
        init(iconName: String) {
            self.iconName = iconName
            self.image = nil
        }
        
        init(image: Image) {
            self.iconName = nil
            self.image = image
        }
        
        var body: some View {
            GeometryReader { proxy in
                ZStack {
                    LinearGradient.horizontalDarkReverse
                        .scaleEffect(0.5)
                    //                    .frame(width: width, height: height)
                    
                    RoundedRectangle(cornerRadius: proxy.size.height * 0.175)
                        .inverseMask(buttonMask)
                        .foregroundColor(.nmkBackground)
                    //                    .frame(width: width, height: height)
                        .shadow(color: .nmkShadow, radius: 3, x: 3, y: 3)
                        .shadow(color: .white, radius: 3, x: -3, y: -3)
                }
            }
            .compositingGroup()
            .shadow(color: Color.white.opacity(0.9), radius: 10, x: -5, y: -5)
            .shadow(color: Color.nmkShadow.opacity(0.5), radius: 10, x: 5, y: 5)
        }
        
        var buttonMask: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                getImage()
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.5)
            }
        }
        
        func getImage() -> Image {
            if iconName != nil {
                return Image(systemName: self.iconName!)
            } else {
                return image!
            }
        }
        
    }
    
    private struct NMKButton: ViewModifier {
        let isPressed: Bool
        let isDisabled: Bool
        let iconName: String?
        let image: Image?
        
        init(isPressed: Bool, isDisabled: Bool = false, iconName: String) {
            self.isPressed = isPressed
            self.isDisabled = isDisabled
            self.iconName = iconName
            self.image = nil
        }
        
        init(isPressed: Bool, isDisabled: Bool = false, image: Image) {
            self.isPressed = isPressed
            self.isDisabled = isDisabled
            self.image = image
            self.iconName = nil
        }
        
        
        func body(content: Content) -> some View {
            content
            if !isDisabled {
                if isPressed {
                    iconName != nil ? ButtonPressed(iconName: iconName!) : ButtonPressed(image: image!)
                } else {
                    iconName != nil ? ButtonUp(iconName: iconName!) : ButtonUp(image: image!)
                }
            } else {
                iconName != nil ? ButtonDisabled(iconName: iconName!) : ButtonDisabled(image: image!)
            }
        }
        
    }
    
    
    /// Progress View Style
    public struct NMKProgressViewStyle: ProgressViewStyle {
        let width: CGFloat
        
        public init(width: CGFloat = UIScreen.main.bounds.width) {
            self.width = width
        }
        
        public func makeBody(configuration: Configuration) -> some View {
            let fractionCompleted: CGFloat = CGFloat(configuration.fractionCompleted ?? 0)
            
            ZStack(alignment: .leading) {
                ZStack {
                    Capsule()
                        .frame(height: 14)
                        .foregroundColor(Color(white: 0.8))
                    LinearGradient.horizontalDarkToLight
                        .frame(height: 14)
                        .mask(Capsule())
                        .opacity(0.7)
                }.padding(.horizontal)
                
                ZStack {
                    LinearGradient.horizontalLight
                        .frame(
                            width: (width - 32) * fractionCompleted,
                            height: 10)
                        .mask(
                            Capsule()
                                .padding(.horizontal, 2)
                        )
                    LinearGradient.verticalLightToDark
                        .frame(
                            width: (width - 32) * fractionCompleted,
                            height: 10)
                        .mask(
                            Capsule()
                                .padding(.horizontal, 2)
                        )
                        .opacity(0.7)
                }
                .shadow(color: Color.nmkShadow.opacity(0.5), radius: 2, x: 0, y: 1)
                .padding(.horizontal)
            }
            .clipShape(Capsule())
        }
    }
    
    
    /// Toggle Style
    public struct NMKToggleStyle: ToggleStyle {
        public func makeBody(configuration: Configuration) -> some View {
            var tap: some Gesture {
                TapGesture()
                    .onEnded { _ in
                        configuration.isOn.toggle()
                    }
            }
            
            var drag: some Gesture {
                DragGesture(minimumDistance: 5)
                    .onEnded { _ in
                        configuration.isOn.toggle()
                    }
            }
            
//            Button {
//                configuration.isOn.toggle()
//            } label: {
                return ZStack {
                    outerBevel(configuration)
                    innerColor(configuration)
                    paddle(configuration)
                }
                .gesture(drag.simultaneously(with: tap))
//            }
        }
                
        /// Outer bevel
        fileprivate func outerBevel(_ configuration: Configuration) -> some View {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.nmkBackground)
                .frame(width: 60, height: 40)
                .NMKDepth()
                .NMKEmbossed(using: RoundedRectangle(cornerRadius: 5))
        }
        
        /// Inner color
        fileprivate func innerColor(_ configuration: Configuration) -> some View {
            if #available(iOS 16.0, *) {
                return HStack(spacing: 0) {
                    Rectangle()
                        .fill(LinearGradient(
                            colors:
                                [.red,
                                 .red.opacity(0.8),
                                 .red.opacity(0.7),
                                 .red.opacity(0.6),],
                            startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(5, corners: [.topLeft, .bottomLeft])
                    Rectangle()
                        .fill(LinearGradient(
                            colors:
                                [.nmkDark.opacity(0.6),
                                 .nmkDark.opacity(0.7),
                                 .nmkDark.opacity(0.8),
                                 .nmkDark
                                ],
                            startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(5, corners: [.topRight, .bottomRight])
                }
                .frame(width: 53, height: 33)
            } else {
                // Fallback on earlier versions
                return RoundedRectangle(cornerRadius: 5)
                    .fill(LinearGradient(colors: [.red, .red, .nmkLight, .nmkDark, .nmkDark], startPoint: .leading, endPoint: .trailing))
                    .frame(width: 53, height: 33)
            }
            
        }
        
        /// Paddle
        fileprivate func paddle(_ configuration: Configuration) -> some View {
            ZStack {
                Rectangle()
                    .fill(Color.nmkLight)
                    .cornerRadius(5, corners: [.topLeft, .bottomLeft])
                    .frame(width: 25, height: 35)
                    .shadow(color: .nmkShadow, radius: 1, x: configuration.isOn ? 0 : -3, y: 0)
                Spacer()
                
                Rectangle()
                    .fill(Color.nmkLight)
                    .cornerRadius(5, corners: [.topLeft, .bottomLeft])
                    .frame(width: 25, height: 35)
                    .shadow(color: .nmkShadow, radius: 1, x: configuration.isOn ? -3 : 0, y: 0)
            }
            .rotation3DEffect(Angle(degrees: configuration.isOn ? 170 : 30), axis: (x: 0, y: 1, z: 0))
            .offset(x: configuration.isOn ? 9 : -9)
            .animation(.spring(), value: configuration.isOn)
        }
    }
    
}





// MARK: - Preview
struct NMK_View_Modifiers_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.nmkBackground.ignoresSafeArea()
            
            VStack {
                
                // Card
                Group {
                    Rectangle()
                        .overlay(
                            VStack {
                                Image(systemName: "photo")
                                    .NMKImageMod()
                                
                                HStack {
                                    Text("Title")
                                        .NMKText()
                                        .bold()
                                        .padding(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Text("Subtitle")
                                        .NMKText()
                                        .padding([.leading, .bottom])
                                    Spacer()
                                }
                            }
                        )
                        .NMKBackground()
                        .frame(width: 180, height: 260)
                    
                    Text("Card")
                        .NMKText()
                        .bold()
                        .padding(.bottom)
                }
                
                Divider()
                
                // Progress View
                Group {
                    Text("Progress View")
                        .NMKText()
                    
                    ProgressView(value: 0.4)
                        .progressViewStyle(NMK.NMKProgressViewStyle())
                        .padding()
                }
                
                Divider()
               
                // Buttons & Toggle
                HStack {
                    Spacer()
                    Button("") { }
                    .buttonStyle(NMK.NMKButtonStyle(iconName: "gear") )
                    
                    Spacer()
                    
                    Toggle("Toggle", isOn: .constant(false))
                        .toggleStyle(NMK.NMKToggleStyle())
                    
                    Spacer()
                }.padding()
                
                Divider()
                
                // Embossed View
                Group {
                    HStack {
                        Circle()
                            .foregroundColor(.nmkBackground)
                            .NMKEmbossed(using: Circle())
                            .overlay(
                                Text("Embossed")
                                    .NMKText()
                                    .bold()
                            )
                        
                        Circle()
                            .foregroundColor(.nmkBackground)
                            .NMKRaisedShadow(radius: 7)
                            .overlay(
                                Text("Raised Shadow")
                                    .NMKText()
                                    .bold()
                            )
                        
                        Circle()
                            .foregroundColor(.nmkBackground)
                            .NMKDepth()
                            .overlay(
                                Text("Depth")
                                    .NMKText()
                                    .bold()
                            )
                        
                    }
                    .padding()
                }
                
            }
        }
    }
}






fileprivate extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

fileprivate struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
