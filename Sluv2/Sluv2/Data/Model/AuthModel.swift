//
//  AuthModel.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/07.
//

import Foundation

// 소셜로그인
// MARK: - SocialLoginModel
struct SocialLoginModel: Codable {
    let accessToken: String
    let snsType: String
    let fcm: String

}

// MARK: - autoLogin, updateFcm
struct fcmModel : Codable {
    let fcm : String
}
