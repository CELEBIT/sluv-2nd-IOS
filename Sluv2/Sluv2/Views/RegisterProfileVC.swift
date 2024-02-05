//
//  RegisterProfileVC.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/05.
//

import UIKit

class RegisterProfileVC: BaseController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet

    //  [Elements]
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "프로필 사진과\n닉네임을 등록해 주세요"
        label.font = .Heading0
        label.textColor = UIColor(named: "Font-primary")
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile_big"))
        let length:CGFloat = 128
        
        imageView.contentMode = .scaleToFill
        imageView.heightAnchor.constraint(equalToConstant: length).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: length).isActive = true
        imageView.layer.cornerRadius = (length / 2)
        imageView.clipsToBounds = true

        return imageView
    }()
    
    let addImgBtn: UIButton = {
        let button = UIButton()
        
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
        button.setImage(UIImage(named: "add"), for: .normal)
        button.imageView?.contentMode = .center

        return button
    }()
    
    let nicknameField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = UIColor(named: "white")
        textField.borderStyle = .none
        let placeholderAttributes = [
            NSAttributedString.Key.font: UIFont.Heading3,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Icon")
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "내 닉네임", attributes: placeholderAttributes as [NSAttributedString.Key : Any])
        textField.textColor = UIColor(named: "Font-primary")
        textField.font = .Heading3
        
        return textField
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        
        label.text = "닉네임은 15자까지 입력할 수 있어요."
        label.font = .Detail1
        label.textColor = UIColor.clear
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var tappedDoneBtn: (() -> Void)? = {
        let closer = {
            print("완료 버튼 클릭!!!!!!")
        }
        return closer
    }()
    
    lazy var doneBtn = CustomButton(btnColor: "Btn-primary-disabled", textColor: "Font-Disabled", title: "동의", actionHandler: tappedDoneBtn, cornerRadius: 12)
    
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameField.delegate = self
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    override func configureUI() {
        view.backgroundColor = UIColor(named: "white")
    }
    
    override func addview() {
        view.addSubview(titleLabel)
        view.addSubview(profileImage)
        view.addSubview(addImgBtn)
        view.addSubview(nicknameField)
        view.addSubview(errorLabel)
        view.addSubview(doneBtn)
    }
    
    override func layout() {
        titleLabel.snp.makeConstraints{ (a) in
            a.top.left.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 0))
        }
        
        profileImage.snp.makeConstraints{ (a) in
            a.centerX.equalToSuperview()
            a.top.equalTo(titleLabel.snp.bottom).offset(50)
        }
        
        addImgBtn.snp.makeConstraints{ (a) in
            a.bottom.right.equalTo(profileImage)
        }
        
        nicknameField.snp.makeConstraints{(a) in
            a.centerX.equalToSuperview()
            a.top.equalTo(profileImage.snp.bottom).offset(24)
        }
        
        errorLabel.snp.makeConstraints{ (a) in
            a.centerX.equalToSuperview()
            a.top.equalTo(nicknameField.snp.bottom).offset(4)
        }
        
        doneBtn.snp.makeConstraints{ (a) in
            a.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            a.height.equalTo(56)
            a.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
}

// MARK: - TextField Delegate
extension RegisterProfileVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            errorLabel.textColor = UIColor.clear
            return true
        }
        
        if nicknameField.text?.count ?? 0 >= 15 {
            errorLabel.textColor = UIColor(named: "error")
            return false
        } else {
            errorLabel.textColor = UIColor.clear
            return true
        }
    }
}
