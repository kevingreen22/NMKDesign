[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

# NMKDesign

A collection of SwiftUI neumorphic views and modifiers.

If you like the project, please do not forget to `star ★` this repository and follow me on GitHub.


## 📦 Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3


## Installation 

To install the component add it to your project using Swift Package Manager with url below.

```
https://github.com/kevingreen22/NMKDesign
```

Import the package.

```swift
import KGViews
```


## Table of Contents

- [Image Example](#image-example)
- [Text Example](#text-example)
- [Background Example](#background-example)
- [Progress View Style Example](#progress-view-style-example)
- [Border Button Style Example](#border-button-style-example)
- [Plain Button Style Example](#plain-button-style-example)
- [Toggle Style Example](#toggle-style-example)
- [Embossed Example](#embossed-example)
- [Raised Shadow Example](#raised-shadow-example)
- [Depth Example](#depth-example)

![Sliders Screenshot](https://github.com/kevingreen22/KGViews/tree//developer/readMe_resources/bar_sliders.gif)

### Image Example

```swift
Image(systemName: "photo")
  .NMKImageMod(
```

### Text Example

```swift
Text("Title")
  .NMKText()
```

### Background Example

```swift
Rectangle()
  .NMKBackground()
```

### Progress View Style Example

```swift
ProgressView(value: progressValue)
  .progressViewStyle(NMK.NMKProgressViewStyle())
```

### Bordered Button Style Example

```swift
Button("Bordered Button Style") { }
  .buttonStyle(NMK.NMKBordered(iconName: "gearshape.2.fill") )   
```

### Plain Button Style Example

```swift
Button("Plain Button Style") { }
  .buttonStyle(NMK.NMKPlain(iconName: "gear"))
```

### Toggle Style Example

```swift
Toggle("Toggle", isOn: $isOn)
  .toggleStyle(NMK.NMKToggleStyle())
```

### Embossed Example

```swift
Circle()
  .foregroundColor(.nmkBackground)
  .NMKEmbossed(using: Circle())
```

### Raised Shadow Example

```swift
Circle()
  .foregroundColor(.nmkBackground)
  .NMKRaisedShadow(radius: 7)
```

### Depth Example

```swift
Circle()
  .foregroundColor(.nmkBackground)
  .NMKDepth()
```

