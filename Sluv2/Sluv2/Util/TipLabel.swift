//
//  TipLabel.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/04/08.
//

import Foundation

import UIKit
import SnapKit

class MyTopTipView: UIView {
    var labelText: String = ""
    var tipWidth:CGFloat = 0.0
    var tipHeight: CGFloat = 0.0
    var tipLocationX: CGFloat = 0.0
    var viewColor: UIColor = UIColor.white
    let contentLabel = UILabel()
    
    init(
      viewColor: UIColor,
      tipLocationX: CGFloat,
      tipWidth: CGFloat,
      tipHeight: CGFloat,
      labelText: String
    ) {
        super.init(frame: .zero)
        self.backgroundColor = viewColor
        self.labelText = labelText
        self.tipWidth = tipWidth
        self.tipHeight = tipHeight
        self.tipLocationX = tipLocationX
        self.viewColor = viewColor
        self.addLabel() {
            self.drawTri()
        }
    }
    
    private func addLabel(completion: @escaping () -> Void) {
        contentLabel.textColor = .white
        contentLabel.text = self.labelText
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byCharWrapping
        
        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(16)
        }
        completion()
    }
    
    private func drawTri() {
        let path = CGMutablePath()
        
        let tipStartX: CGFloat = ((contentLabel.intrinsicContentSize.width + 36) - tipWidth)/2 + tipLocationX
        let tipStartY: CGFloat = contentLabel.intrinsicContentSize.height + 20

        let tipWidthCenter = tipWidth / 2.0
        let endXWidth = tipStartX + tipWidth

        path.move(to: CGPoint(x: tipStartX, y: tipStartY))
        path.addLine(to: CGPoint(x: tipStartX + tipWidthCenter, y: tipHeight + tipStartY))
        path.addLine(to: CGPoint(x: endXWidth, y: tipStartY))
        path.addLine(to: CGPoint(x: 0, y: tipStartY))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = viewColor.cgColor

        self.layer.insertSublayer(shape, at: 0)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
