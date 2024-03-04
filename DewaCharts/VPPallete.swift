//
//  Color-VisionPro.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 19/02/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import Foundation
import SwiftUI

enum VPPallete: String {
    case primary
    case primaryText
    case dm
    case nakheel
    case dewa
    case chartPlaceHolder
    case others
    case lines
    case background
}

extension VPPallete {
    var color: Color{ Color(assetName)}
    public var assetName: String { rawValue }
}
