//
//  WebviewVC.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/20.
//

import UIKit
import WebKit
import YPImagePicker

class WebviewVC: BaseController{
    // MARK: - Properties
    // 변수 및 상수, IBOutlet

    var webView: WKWebView!
    var token: String = ""
    var status: String = ""
//    var selectedImage: [YPMediaItem] = []
    var base64Image: [String] = []
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션바 없앰
        navigationController?.navigationBar.isHidden = true
        
        // WebView 불러오기
        let myURL = ServiceAPI.webURL
        let myRequest = URLRequest(url: URL(string: myURL + "/?accessToken=\(token)&userStatus=\(status)")!)
        webView.load(myRequest)
        
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    override func configureUI() {
        view.backgroundColor = UIColor(named: "white")
    }
    
    override func addview() {
    }
    
    override func layout() {
        // 상태바만큼 Top Constraint 설정
        
    }
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의

}

// MARK: - WKUIDelegate
extension WebviewVC: WKUIDelegate {
    override func loadView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "IOSBridge")

        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController
        
        let frame = UIScreen.main.bounds
        webView = WKWebView(frame: frame, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // WKWebView의 내부 스크롤 뷰에 접근하여 배경색상 변경
        if let scrollView = webView.scrollView as? UIScrollView {
            scrollView.backgroundColor = UIColor(named: "white")
        }
        
        webView.backgroundColor = .clear
        webView.isOpaque = false
        
        // WebView Bounce, Indicator(스크롤 바) 제거
        webView.scrollView.bounces = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        
        //3D 터치 비활성화
        webView.allowsLinkPreview = false
        
        //뒤로가기, 앞으로가기 제스쳐 사용
        webView.allowsBackForwardNavigationGestures = true
        
        // ios 16.4 에서 DEBUG 모드인 경우에만
        // webview inspector 가능하도록 설정
        if #available(iOS 16.4, *) {
            #if DEBUG
            webView.isInspectable = true  // webview inspector 가능하도록 설정
            #endif
        }
        
        view = webView
        
    }
    
    
}

// MARK: - WKNavigationDelegate
extension WebviewVC: WKNavigationDelegate {
    
    // 웹 페이지 로드 완료 시 호출됨
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("웹 페이지 로드 완료")
        
        // 웹으로 토큰 및 유저 상태 보내기
//        setToken(token: token, userStatus: status)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .cancel) { _ in
            print("컴플리션 핸들러 호출")
            completionHandler()
        })
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }

    
    // 웹으로 토큰 및 유저 상태 보내는 함수
    func setToken(token: String, userStatus: String) {
        
        let token = ["token": token] as [String : Any]
        let status = ["status": userStatus] as [String : Any]
        
        do {
            // 토큰
            let TokenJsonData = try JSONSerialization.data(withJSONObject: token, options: [])

            if let tokenJsonString = String(data: TokenJsonData, encoding: .utf8) {
                webView.evaluateJavaScript("window.setToken('\(tokenJsonString)');") { (result, error) in
                    if let error {
                        print("token 세팅 에러: ", error)
                    }
                    if let result {
                        print("token 세팅 결과: ", result)
                    }
                }
            }
            
            // 유저 상태
            let StatusJsonData = try JSONSerialization.data(withJSONObject: status, options: [])

            if let statusJsonString = String(data: StatusJsonData, encoding: .utf8) {
                webView.evaluateJavaScript("window.setUserStatus('\(statusJsonString)');") { (result, error) in
                    if let error {
                        print("status 세팅 에러: ", error)
                    }
                    if let result {
                        print("status 세팅 결과: ", result)
                    }
                }
            }
            
        } catch {
            print("웹 통신 실패")
        }

    }
    
    // 웹 뷰 통신
}

extension WebviewVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "IOSBridge", let jsonString = message.body as? String {
            print("아아아아아")
            print(message.body)
            
            // Parse JSON
            if let data = jsonString.data(using: .utf8) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {

                        guard let type = json["type"] as? String else { return }
                        switch type {
                        case "openGallery":
                            print("MessageHandelr: \(type)")
                            
                            guard let totalPhotos = json["totalPhotos"] as? Int else { return }
                            guard let photosToSelect = json["photosToSelect"] as? Int else { return }
                            
                            loadImagePicker(maxPicNum: photosToSelect)
                        case "logout":
                            print("MessageHandelr: \(type)")
                            
                            goToLoginVC()
                            break
                        case "withdraw":
                            print("MessageHandelr: \(type)")
                            
                            UserDefaults.setValue(false, forKey: "isMember")
                            UserDefaults.setValue("", forKey: "kindOfLogin")
                            
//                            ManageLogin.isMember = false
//                            ManageLogin.kindOfLogin = ""
                            goToLoginVC()
                            break
                        default:
                            print("정의하지 않은 MessageHandler입니다.")
                        }

                    }
                } catch {
                    print("Error parsing JSON:", error)
                }
            }
        }
        
    }
    
    func goToLoginVC() {
        let root = LoginVC()
        let vc = UINavigationController(rootViewController: root) // 네비게이션 컨트롤러 추가
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: false)
    }

}
