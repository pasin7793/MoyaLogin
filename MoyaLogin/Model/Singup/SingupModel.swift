//
//  SingupModel.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//

import Foundation

struct SignupModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SignupResponse
}

struct SignupResponse: Codable{
    let fullName, email, password: String
}
