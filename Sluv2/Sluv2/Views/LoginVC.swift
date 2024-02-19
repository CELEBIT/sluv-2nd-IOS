//
//  LoginVC.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/05.
//

import UIKit
import SnapKit
import KakaoSDKUser
import GoogleSignInSwift
import GoogleSignIn

class LoginVC: BaseController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    // MARK: [For UI Components]
    let sluvLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Sluv_logo"))
        
        return imageView
    }()

    let explainLabel1: UILabel = {
        let label = UILabel()
        
        label.text = "셀럽 아이템 정보 집합소"
        label.font = .Heading2
        label.textColor = UIColor(named: "Font-primary")
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let explainLabel2: UILabel = {
        let label = UILabel()
        
        label.text = "나누고 싶은 셀럽의 정보를\n우리만의 아지트에서!"
        label.font = .Body3
        label.textColor = UIColor(named: "Font-secondary")
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let kakaoBtn: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Kakao_logo"), for: .normal)
        
        return button
    }()
    
    let googleBtn: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Google_logo"), for: .normal)
        
        return button
    }()
    
    let appleBtn: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Apple_logo"), for: .normal)
        
        return button
    }()
    
    lazy var btnStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kakaoBtn, googleBtn, appleBtn])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        return stackView
    }()
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kakaoLogin = UITapGestureRecognizer(target: self, action: #selector(kakaoLogin(_:)))
        kakaoBtn.addGestureRecognizer(kakaoLogin)
        let googleLogin = UITapGestureRecognizer(target: self, action: #selector(googleLogin(_:)))
        googleBtn.addGestureRecognizer(googleLogin)
        let appleLogin = UITapGestureRecognizer(target: self, action: #selector(appleLogin(_:)))
        appleBtn.addGestureRecognizer(appleLogin)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    override func configureUI() {
        view.backgroundColor = UIColor(named: "white")
    }
    
    override func addview() {
        view.addSubview(sluvLogo)
        view.addSubview(explainLabel1)
        view.addSubview(explainLabel2)
        view.addSubview(btnStackView)
    }
    
    override func layout() {
        sluvLogo.snp.makeConstraints{ (a) in
            a.width.equalTo(202)
            a.height.equalTo(77)
            a.centerX.equalToSuperview()
            a.top.equalTo(view.safeAreaLayoutGuide).offset(150)
        }
        
        explainLabel1.snp.makeConstraints{ (a) in
            a.width.greaterThanOrEqualTo(168.67)
            a.height.equalTo(22)
            a.centerX.equalToSuperview()
            a.top.equalTo(sluvLogo.snp.bottom).offset(32)
        }

        explainLabel2.snp.makeConstraints{ (a) in
            a.width.greaterThanOrEqualTo(154)
            a.height.equalTo(46)
            a.centerX.equalToSuperview()
            a.top.equalTo(explainLabel1.snp.bottom).offset(12)
        }
        
        btnStackView.snp.makeConstraints{ (a) in
            a.centerX.equalToSuperview()
            a.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
        }
    }
    
    // 소셜 로그인
    @objc func kakaoLogin(_ sender: UITapGestureRecognizer) {
        print("kakao 로그인 버튼 클릭\n", sender)
        
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("[Kakao] loginWithKakaoTalk() success.\n")
                    print("* 카카오 aceessToken: ", oauthToken!.accessToken as String)
                    
                    let accessToken: String = oauthToken!.accessToken as String
                    
                    print(oauthToken)
    
                    // TODO: 서버에 acccessToken 넘기기
                    self.doSocialLogin(token: accessToken, snsType: "KAKAO")
                    
                }
            }
        }
        

    }
    
    @objc func googleLogin(_ sender: UITapGestureRecognizer) {
        print("google 로그인 버튼 클릭\n", sender)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult else { return }
            
            _ = signInResult.user.profile?.email
            _ = signInResult.user.profile?.name
            
            let idToken       = signInResult.user.idToken?.tokenString as? String
            let accessToken   = signInResult.user.accessToken.tokenString
            let refreshToken  = signInResult.user.refreshToken.tokenString
            let clientID      = (signInResult.user.userID ?? "") as String
            
            print("[Google] signIn() success.\n")
            print("* 구글 aceessToken: ", accessToken)
            print("* 구글 idToken: ", idToken ?? "idToken이 비었습니다.")
            print("* 구글 clientID: ", clientID)
            print("* 구글 refreshToken: ", refreshToken)
            
            // TODO: 서버에 acccessToken 넘기기
            self.doSocialLogin(token: idToken ?? "idToken이 비었습니다.", snsType: "GOOGLE")
        }
        
    }
    
    @objc func appleLogin(_ sender: UITapGestureRecognizer) {
        print("apple 로그인 버튼 클릭\n", sender)
    }
    
    func doSocialLogin(token: String, snsType: String) {
        let param: SocialLoginModel = SocialLoginModel(accessToken: token, snsType: snsType)
        AuthManager.shared.getAccessToken(token: param) { result in
            switch result {
            case .success(let token):
                print("소셜로그인 서버 통신 성공")
                print("발급받은 토큰: \(token)")
            case .failure(let error):
                print("소셜로그인 서버 통신 실패")
                print("에러: \(error)")
            }
        }
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
}
