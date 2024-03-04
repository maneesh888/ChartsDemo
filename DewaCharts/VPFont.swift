//
//  VPFont.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 19/02/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import Foundation
import SwiftUI

enum VPFont {
    case boldHeader
    case h4Headline
    case body1
}

extension VPFont {
    var swiftUIFont: Font {
        switch self {
        case .boldHeader:
            return .system(size: 38, weight: .bold)
        case .h4Headline:
            return .system(size: 28, weight: .bold)
        case .body1:
            return .system(size: 16, weight: .regular)
        }
    }
}
