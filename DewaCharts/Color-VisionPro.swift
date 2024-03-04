//
//  Color-VisionPro.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 19/02/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static var primaryButtonBgColor: Color {
        return VPPallete.primary.color
    }
    
    static var primaryTextColor: Color {
        return VPPallete.primaryText.color
    }
    
    static var primaryBg: Color {
        return VPPallete.background.color
    }
}

extension UIColor {
    static var dewaColor: Color {
        VPPallete.dewa.color
    }
    
    static var dmColor: Color {
        VPPallete.dm.color
    }
    
    static var nakheelColor: Color {
        VPPallete.nakheel.color
    }
    
    static var othersColor: Color {
        VPPallete.others.color
    }
    
    static var chartPlaceholderColor: Color {
        VPPallete.chartPlaceHolder.color
    }
    
    static var emptyColor: Color {
        VPPallete.lines.color
    }
}
