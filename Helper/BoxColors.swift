//
//  BoxColors.swift
//  TBox
//
//  Created by 木本瑛介 on 2023/05/03.
//

import Foundation
import SwiftUI

struct BoxColors {
    func outputBoxColor(index: Int) -> UIColor {
        switch index {
        case 0: return UIColor(.init(red: 0.35, green: 0.34, blue: 0.69))
        case 1: return UIColor(.init(red: 0.59, green: 0.75, blue: 0.89))
        case 2: return UIColor(.init(red: 0.80, green: 0.89, blue: 0.96))
        case 3: return UIColor(.init(red: 0.96, green: 0.81, blue: 0.92))
        case 4: return UIColor(.init(red: 0.97, green: 0.93, blue: 0.42))
        case 5: return UIColor(.init(red: 0.58, green: 0.76, blue: 0.46))
        default: return UIColor(.init(red: 0.89, green: 0.27, blue: 0.35))
        }
    }
}
