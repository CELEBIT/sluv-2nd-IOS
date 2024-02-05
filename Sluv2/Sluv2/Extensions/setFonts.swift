//
//  setFonts.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/05.
//

import UIKit

enum BasicFont: String {
    case light = "Pretendard-Light"
    case regular = "Pretendard-Regular" // width:400
    case medium = "Pretendard-Medium" // width:500
    case semibold = "Pretendard-SemiBold" // width:600
    case bold = "Pretendard-Bold" // width:700
}
extension UIFont {
    // semibold
    static let Heading0 = UIFont(name: BasicFont.semibold.rawValue, size: 24)
    static let Heading2 = UIFont(name: BasicFont.semibold.rawValue, size: 18)
    // medium
    static let Heading1 = UIFont(name: BasicFont.medium.rawValue, size: 22)
    static let Body1 = UIFont(name: BasicFont.medium.rawValue, size: 18)
    static let Body2 = UIFont(name: BasicFont.medium.rawValue, size: 17)
    static let Body3 = UIFont(name: BasicFont.medium.rawValue, size: 15)
    static let Detail1 = UIFont(name: BasicFont.medium.rawValue, size: 14)
    // regular
    static let Textfield = UIFont(name: BasicFont.regular.rawValue, size: 17)
    static let Detail2 = UIFont(name: BasicFont.regular.rawValue, size: 13)
}

