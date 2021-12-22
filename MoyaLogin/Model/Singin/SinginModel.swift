//
//  SinginModel.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//

import Foundation

struct SigninModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SigninResponse
}

struct SigninResponse: Codable{
    let email, password: String
}
