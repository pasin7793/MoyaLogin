//
//  User.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/24.
//

import Foundation

struct SigninRequest: Codable{
    var email: String
    var password: String
}

struct SignupRequest: Codable{
    var fullName: String
    var email: String
    var password: String
}
