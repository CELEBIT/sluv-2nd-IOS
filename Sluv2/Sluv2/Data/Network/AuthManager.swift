//
//  AuthManager.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/20.
//

import Foundation
import Moya

enum MyError: Error {
    case customStringError(String)
    case communicationFailureError(Error)
}

class AuthManager {
    private init() {}
    static let shared = AuthManager()
    lazy var provider = MoyaProvider<AuthAPI>()
    
    // 소셜 로그인
    func getAccessToken(token: SocialLoginModel, completion: @escaping (Result<[String : Any], Error>) -> Void ) {
        provider.request(.socialLogin(param: token)) { result in
            switch result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data.data, options: []) as? [String : Any] {
                    if json["isSuccess"] as? Bool == true {
                        let result: [String : Any] = json["result"] as? [String : Any] ?? ["token" : "", "userStatus" : ""]
                        completion(.success(result))
                    } else {
                        completion(.failure(MyError.customStringError(json["message"] as! String)))
                    }
                }
            case .failure(let error):
                completion(.failure(MyError.communicationFailureError(error)))
            }
            
        }
    }
    
    // 토큰 유효성 체크
    func checkTokenAccess(completion: @escaping (Result<String, Error>) -> Void ) {
        provider.request(.autoLogin) { result in
            switch result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data.data, options: []) as? [String : Any] {
                    if json["isSuccess"] as? Bool == true {
                        let result: [String : Any] = json["result"] as? [String : Any] ?? ["token" : "", "userStatus" : ""]
                        completion(.success(result["userStatus"] as! String))
                    } else {
                        print("토큰 만료. 재로그인 필요")
                        completion(.success("만료"))
                    }
                }
            case .failure(let error):
                completion(.failure(MyError.communicationFailureError(error)))
            }
        }
    }
    
    
}
