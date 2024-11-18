//
//  Functions.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/11/18.
//

import Foundation
import UIKit

class Functions {
    
    static func goToWebView(url: String) {
        let root = WebviewVC()
        root.goToUrl = url
        let vc = UINavigationController(rootViewController: root)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: false)
        
    }
    
    static func goToLookArdView(from viewController: UIViewController, url: String) {
        let vc = WebviewVC()
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
        vc.goToUrl = url
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToLoginVC(redirectionPath: String = "") {
        let root = LoginVC()
        root.redirectionPath = redirectionPath
        let vc = UINavigationController(rootViewController: root) // 네비게이션 컨트롤러 추가
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: false)
    }
    
    static func backToLoginVC(from viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    static func checkJWTToken(successCompletion: @escaping (_ token: String, _ status: String) -> Void,
                              failureCompletion: @escaping () -> Void = {
                                      print("기본 동작 - 로그인 화면으로 이동!")
                                  }
    ) {
        
        if let token: String = UserDefaults.standard.value(forKey: "token") as? String {
            let tempFcm = UserDefaults.standard.string(forKey: "fcmToken") ?? ""
            AuthManager.shared.checkTokenAccess(fcm: fcmModel(fcm: tempFcm)) { result in
                switch result {
                case .success(let status):
                    if status != "만료" {
                        // checkJWTToken 함수 호출 시, 토큰 만료 아닐 때 할 일 정의
                        successCompletion(token, status)
                    } else {
                        print("토큰 만료.")
                        failureCompletion()
                    }
                default:
                    print("서버 통신 실패.")
                    failureCompletion()
                }
            }
            
        } else {
            print("저장된 토큰 없음.")
            failureCompletion()
        }

    }
    
    
}
