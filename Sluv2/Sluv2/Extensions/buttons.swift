//
//  buttons.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/05/13.
//

import Foundation
import UIKit

extension UIButton {
    func setUnderline(text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: (text.count))
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
