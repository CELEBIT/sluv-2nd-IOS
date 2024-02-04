//
//  BaseController.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/05.
//

import UIKit

class BaseController: UIViewController {
        
    func configureUI(){}
    func addview(){}
    func layout(){}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.addview()
        self.layout()
    }
    
}
