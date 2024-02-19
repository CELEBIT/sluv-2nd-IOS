//
//  WebviewVC.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/20.
//

import UIKit
import WebKit

class WebviewVC: BaseController{
    // MARK: - Properties
    // 변수 및 상수, IBOutlet

    var webView: WKWebView!
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션바 없앰
        navigationController?.navigationBar.isHidden = true
        
        // WebView 불러오기
        let myURL = ServiceAPI.webURL
        let myRequest = URLRequest(url: myURL!)
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
        let webConfiguration = WKWebViewConfiguration()
        
        let frame = UIScreen.main.bounds
        webView = WKWebView(frame: frame, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // WKWebView의 내부 스크롤 뷰에 접근하여 배경색상 변경
        if let scrollView = webView.scrollView as? UIScrollView {
            scrollView.backgroundColor = UIColor(named: "white")
        }
        
        // WebView Bounce, Indicator(스크롤 바) 제거
        webView.scrollView.bounces = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        
        //3D 터치 비활성화
        webView.allowsLinkPreview = false
        
        //뒤로가기, 앞으로가기 제스쳐 사용
        webView.allowsBackForwardNavigationGestures = true
        
        view = webView
    }
}

// MARK: - WKNavigationDelegate
extension WebviewVC: WKNavigationDelegate {
    
    // 웹 페이지 로드 완료 시 호출됨
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("웹 페이지 로드 완료")
    }
}
