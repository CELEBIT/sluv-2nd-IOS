//
//  CustomButton.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/05.
//

import UIKit

class CustomButton: UIButton {
    private var actionHandler: (() -> Void)?
    
    init(btnColor: String, textColor: String, title: String, actionHandler: (() -> Void)?, cornerRadius: CGFloat) {
        super.init(frame: CGRect.zero)
        
        setupButton(btnColor: btnColor, textColor: textColor, title: title, cornerRadius: cornerRadius)
        
        self.actionHandler = actionHandler
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupButton(btnColor: String, textColor: String, title: String, cornerRadius: CGFloat) {
        self.backgroundColor = UIColor(named: btnColor)
        self.layer.cornerRadius = cornerRadius
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor(named: "textColor"), for: .normal)
        self.titleLabel?.font = .Body1
        self.isEnabled = false
        self.addTarget(self, action: #selector(touchBtn(_:)), for: .touchUpInside)
    }

    @objc func touchBtn(_ sender: UIButton) {
        print("버튼이 눌렸습니다.")
        
        if let closure = actionHandler {
            print("Closure exists")
            closure()
        } else {
            print("Closure is nil")
        }
    }

}
