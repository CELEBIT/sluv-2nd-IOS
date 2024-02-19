//
//  AuthManager.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/20.
//

import Foundation
import Moya

enum StringError: Error {
    case customError(String)
}

class AuthManager {
    private init() {}
    static let shared = AuthManager()
    lazy var provider = MoyaProvider<AuthAPI>()
    
    // 소셜 로그인
    func getAccessToken(token: SocialLoginModel, completion: @escaping (Result<String, Error>) -> Void ) {
        provider.request(.socialLogin(param: token)) { result in
            switch result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data.data, options: []) as? [String : Any] {
                    if json["isSuccess"] as? Bool == true {
                        let result: [String : Any] = json["result"] as? [String : Any] ?? ["token" : "", "userStatus" : ""]
                        completion(.success(result["token"] as! String))
                    } else {
                        completion(.failure(StringError.customError(json["message"] as! String)))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    
}
