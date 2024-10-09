//
//  AuthAPI.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/07.
//

import Foundation
import Moya

enum AuthAPI {
    case socialLogin(param: SocialLoginModel)
    case autoLogin(param : fcmModel)
    case fcm(param : fcmModel)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return ServiceAPI.baseURL!
        }
    }
    
    var path: String {
        switch self {
        case .socialLogin:
            return "/app/auth/social-login"
        case .autoLogin:
            return "/app/auth/auto-login"
        case .fcm:
            return "app/auth/fcm"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .socialLogin:
            return .post
        case .autoLogin:
            return .post
        case .fcm:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .socialLogin(let param):
            return .requestJSONEncodable(param)
        case .autoLogin(let param):
            return .requestJSONEncodable(param)
        case .fcm(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .autoLogin, .fcm:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "token") as! String)"]
        default:
            return ["Content-Type" : "application/json"]
        }

    }
    
    
}
