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
import AuthenticationServices

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
    
    let lookAroundBtn: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(UIColor(named: "Font-secondary"), for: .normal)
        button.titleLabel?.font = .Body3
        button.setUnderline(text: "로그인 없이 둘러보기")
        button.addTarget(self, action: #selector(lookArd), for: .touchUpInside)
        
        return button
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
        view.addSubview(lookAroundBtn)
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
        
        lookAroundBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        btnStackView.snp.makeConstraints{ (a) in
            a.centerX.equalToSuperview()
            a.bottom.equalTo(lookAroundBtn.snp.top).offset(-32)
        }
        
        setBubbleView()

    }
    
    func setBubbleView() {
        var bubbleView: MyTopTipView
        let viewColor: UIColor = UIColor(named: "Font-emphasis")!
        var tipLocationX: CGFloat
        let tipWidth: CGFloat = 14.0
        let tipHeight: CGFloat = 7.0
        
        let isMember: Bool = UserDefaults.standard.bool(forKey: "isMember")
        
        if isMember {
            let kindOfLogin: String = UserDefaults.standard.string(forKey: "kindOfLogin") ?? ""
            
            switch kindOfLogin {
            case "kakao":
                tipLocationX = -(appleBtn.intrinsicContentSize.width+20)
            case "google":
                tipLocationX = 0.0
            case "apple":
                tipLocationX = appleBtn.intrinsicContentSize.width+20
            default:
                tipLocationX = 0.0
            }
            
            bubbleView = MyTopTipView(viewColor: viewColor, tipLocationX: tipLocationX, tipWidth: tipWidth, tipHeight: tipHeight, labelText: "최근 사용한 로그인 방법이에요")
            
        } else {
            tipLocationX = 0.0
            bubbleView = MyTopTipView(viewColor: viewColor, tipLocationX: tipLocationX, tipWidth: tipWidth, tipHeight: tipHeight, labelText: "SNS 계정으로 간편하게 가입해요!")
        }
        
        // bubbleView 세팅
        view.addSubview(bubbleView)
        
        bubbleView.snp.makeConstraints { a in
            a.centerX.equalToSuperview()
            a.bottom.equalTo(appleBtn.snp.top).offset(-20)
        }
    }
    
    // 소셜 로그인
    @objc func kakaoLogin(_ sender: UITapGestureRecognizer) {
        print("kakao 로그인 버튼 클릭\n", sender)
        
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // Kakao app is existing
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("[Kakao] loginWithKakaoTalk() success.\n")
                    print("* 카카오 aceessToken: ", oauthToken!.accessToken as String)
                    
                    let accessToken: String = oauthToken!.accessToken as String
    
                    // TODO: 서버에 acccessToken 넘기기
                    self.doSocialLogin(token: accessToken, snsType: "KAKAO")  { token in
                        self.manageLogin(kindOfLogin: "kakao", token: token)
                    }
                    
                }
            }
        } else {
            // Kakao app isn't existing
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.\n")
                    print("* 카카오 aceessToken: ", oauthToken!.accessToken as String)

                    let accessToken: String = oauthToken!.accessToken as String
    
                    // TODO: 서버에 acccessToken 넘기기
                    self.doSocialLogin(token: accessToken, snsType: "KAKAO")  { token in
                        self.manageLogin(kindOfLogin: "kakao", token: token)
                    }
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
            self.doSocialLogin(token: idToken ?? "idToken이 비었습니다.", snsType: "GOOGLE") { token in
                self.manageLogin(kindOfLogin: "google", token: token)
            }
        }
        
    }
    
    @objc func appleLogin(_ sender: UITapGestureRecognizer) {
        print("apple 로그인 버튼 클릭\n", sender)
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self // ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self // ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
    func doSocialLogin(token: String, snsType: String, completion: @escaping (String) -> Void) {
        let param: SocialLoginModel = SocialLoginModel(accessToken: token, snsType: snsType)
        AuthManager.shared.getAccessToken(token: param) { result in
            switch result {
            case .success(let result):
                print("\(snsType) 소셜로그인 서버 통신 성공")
                print("발급받은 토큰: \(String(describing: result["token"]!))")
                
                completion((String(describing: result["token"]!)))
                
                // 토큰 발급 성공시 웹뷰로 화면전환
                let url = ServiceAPI.webURL + "/?accessToken=\(result["token"] as! String)&userStatus=\(result["userStatus"] as! String)"
                self.goToWebView(url: url)
                
            case .failure(let error):
                print("\(snsType) 소셜로그인 서버 통신 실패")
                print("에러: \(error)")
            }
        }
    }
    
    func goToWebView(url: String) {
        let root = WebviewVC()
        root.goToUrl = url
        let vc = UINavigationController(rootViewController: root)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: false)
    }
    
    func manageLogin(kindOfLogin: String, token: String) {
        UserDefaults.standard.setValue(true, forKey: "isMember")
        UserDefaults.standard.setValue(kindOfLogin, forKey: "kindOfLogin")
        UserDefaults.standard.setValue(token, forKey: "token")
    }
    
    @objc func lookArd() {
        goToWebView(url: "\(ServiceAPI.webURL)/home")
    }
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
}

extension LoginVC: ASAuthorizationControllerDelegate {
    
    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {

            let idToken = credential.identityToken!
            let tokenString = String(data: idToken, encoding: .utf8)
            print("idToken: ", tokenString ?? "비었음")

            guard let code = credential.authorizationCode else { return }
            let codeString = String(data: code, encoding: .utf8)
            print("codeString: ", codeString ?? "비었음")

            let user = credential.user
            print("user: ", user)
            
            // idToken 저장
            UserDefaults.standard.set(tokenString, forKey: "appleIdToken")
            // TODO: 서버에 acccessToken 넘기기
            self.doSocialLogin(token: tokenString ?? "idToken이 비었습니다.", snsType: "APPLE") { token in
                self.manageLogin(kindOfLogin: "apple", token: token)
            }
        }
    }

    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("애플 로그인 error: ", error)
    }
    
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
