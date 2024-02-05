//
//  AgreementVC.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/05.
//

import UIKit
import SnapKit

class AgreementVC: BaseController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    // [For Button Toggling]
    var isAllAgree: Bool = false
    var button4State: Bool = false
    
    //  [Elements]
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "스럽 서비스 이용약관에\n동의해주세요"
        label.font = .Heading0
        label.textColor = UIColor(named: "Font-primary")
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    // 모두 동의
    let checkBtn0 : UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.setImage(UIImage(named: "checkbox_fill"), for: .selected)
        button.tintColor = UIColor(named: "white")
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let allLabel : UILabel = {
        let label = UILabel()
        label.text = "약관 전체동의"
        label.textColor = UIColor(named: "Font-primary")
        label.font = .Body2
        
        return label
    }()
    
    lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkBtn0, allLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    // 구분선
    let separatorLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "Btn-primary-disabled")
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return view
    }()
    
    // 약관동의 1
    let checkBtn1 : UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.setImage(UIImage(named: "checkbox_fill"), for: .selected)
        button.tintColor = UIColor(named: "white")
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let firstLabel1 : UILabel = {
        let label = UILabel()
        label.text = "[필수]"
        label.textColor = UIColor(named: "Font-emphasis")
        label.font = .Body3
        
        return label
    }()
    
    let firstLabel2 : UILabel = {
        let label = UILabel()
        label.text = "만 14세 이상"
        label.textColor = UIColor(named: "Font-primary")
        label.font = .Body3
        
        return label
    }()
    
    lazy var firstLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstLabel1, firstLabel2])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        return stackView
    }()
    
    lazy var firstStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkBtn1, firstLabelStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    // 약관동의 2
    let checkBtn2 : UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.setImage(UIImage(named: "checkbox_fill"), for: .selected)
        button.tintColor = UIColor(named: "white")
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let secondLabel1 : UILabel = {
        let label = UILabel()
        label.text = "[필수]"
        label.textColor = UIColor(named: "Font-emphasis")
        label.font = .Body3
        
        return label
    }()
    
    let secondLabel2 : UILabel = {
        let label = UILabel()
        label.text = "이용약관 동의"
        label.textColor = UIColor(named: "Font-primary")
        label.font = .Body3
        
        return label
    }()
    
    lazy var secondLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondLabel1, secondLabel2])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        return stackView
    }()
    
    lazy var secondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkBtn2, secondLabelStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    // 약관동의 3
    let checkBtn3 : UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.setImage(UIImage(named: "checkbox_fill"), for: .selected)
        button.tintColor = UIColor(named: "white")
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let thirdLabel1 : UILabel = {
        let label = UILabel()
        label.text = "[필수]"
        label.textColor = UIColor(named: "Font-emphasis")
        label.font = .Body3
        
        return label
    }()
    
    let thirdLabel2 : UILabel = {
        let label = UILabel()
        label.text = "개인정보 처리방침 동의"
        label.textColor = UIColor(named: "Font-primary")
        label.font = .Body3
        
        return label
    }()
    
    lazy var thirdLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thirdLabel1, thirdLabel2])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        return stackView
    }()
    
    lazy var thirdStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkBtn3, thirdLabelStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()

    // 약관동의 4(선택)
    let checkBtn4 : UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.setImage(UIImage(named: "checkbox_fill"), for: .selected)
        button.tintColor = UIColor(named: "white")
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let fourthLabel1 : UILabel = {
        let label = UILabel()
        label.text = "[선택]"
        label.textColor = UIColor(named: "Font-primary")
        label.font = .Body3
        
        return label
    }()
    
    let fourthLabel2 : UILabel = {
        let label = UILabel()
        label.text = " 광고성 정보 수신 및 마케팅 활용 동의"
        label.textColor = UIColor(named: "Font-primary")
        label.font = .Body3
        
        return label
    }()
    
    lazy var fourthLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fourthLabel1, fourthLabel2])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        
        return stackView
    }()
    
    lazy var fourthStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkBtn4, fourthLabelStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        
        return stackView
    }()
    
    lazy var agreementStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [allStackView, separatorLine, firstStackView, secondStackView, thirdStackView, fourthStackView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        
        return stackView
    }()
    
    lazy var tappedAgreeBtn: (() -> Void)? = {
        let closer = {
            print("동의 버튼 클릭!!!!!!")
            print("선택약관 동의여부: ", self.button4State)
        }
        return closer
    }()
    
    lazy var agreeBtn = CustomButton(btnColor: "Btn-primary-disabled", textColor: "Font-Disabled", title: "동의", actionHandler: tappedAgreeBtn, cornerRadius: 12)
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBtn0.addTarget(self, action: #selector(allAgreeBtnTapped), for: .touchUpInside)
        checkBtn1.addTarget(self, action: #selector(agreementBtnTapped(_:)), for: .touchUpInside)
        checkBtn2.addTarget(self, action: #selector(agreementBtnTapped(_:)), for: .touchUpInside)
        checkBtn3.addTarget(self, action: #selector(agreementBtnTapped(_:)), for: .touchUpInside)
        checkBtn4.addTarget(self, action: #selector(agreementBtnTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    override func configureUI() {
        view.backgroundColor = UIColor(named: "white")
    }
    
    override func addview() {
        view.addSubview(titleLabel)
        view.addSubview(agreementStackView)
        view.addSubview(agreeBtn)
    }
    
    override func layout() {
        titleLabel.snp.makeConstraints{ (a) in
            a.top.left.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 0))
        }
        
        agreementStackView.snp.makeConstraints{ (a) in
            a.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            a.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        separatorLine.snp.makeConstraints{ (a) in
            a.left.right.equalToSuperview()
        }
        
        agreeBtn.snp.makeConstraints{ (a) in
            a.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            a.height.equalTo(56)
            a.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
    }
    
    @objc func allAgreeBtnTapped() {
        isAllAgree.toggle()
        
        checkBtn0.isSelected = isAllAgree
        checkBtn1.isSelected = isAllAgree
        checkBtn2.isSelected = isAllAgree
        checkBtn3.isSelected = isAllAgree
        checkBtn4.isSelected = isAllAgree
        button4State = checkBtn4.isSelected
        
        nextBtnActivate()
    }
    
    @objc func agreementBtnTapped(_ sender: UIButton) {
        sender.isSelected.toggle()

        // 개별 동의 버튼 상태에 따라 전체 동의 버튼 및 다음 버튼 업데이트
        updateAllAgreeBtnState()
        nextBtnActivate()
    }
    
    func updateAllAgreeBtnState() {
        let button1State = checkBtn1.isSelected
        let button2State = checkBtn2.isSelected
        let button3State = checkBtn3.isSelected
        button4State = checkBtn4.isSelected
        
        
        // 모든 개별 동의 버튼이 선택되었을 때 전체 동의 버튼도 선택
        isAllAgree = button1State && button2State && button3State && button4State
        checkBtn0.isSelected = isAllAgree
    }
    
    func nextBtnActivate() {
        if isAllAgree || (checkBtn1.isSelected && checkBtn2.isSelected && checkBtn3.isSelected) {
            agreeBtn.isEnabled = true
            agreeBtn.backgroundColor = UIColor(named: "Btn-primary")
            agreeBtn.setTitleColor(UIColor(named: "white"), for: .normal)
        } else {
            agreeBtn.isEnabled = false
            agreeBtn.backgroundColor = UIColor(named: "Btn-primary-disabled")
            agreeBtn.setTitleColor(UIColor(named: "Font-Disabled"), for: .normal)
        }
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의

}
