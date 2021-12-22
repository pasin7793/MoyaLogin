//
//  SignupRequest.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/21.
//

import Foundation

struct SignupRequest: Codable{
    var fullName: String
    var email: String
    var password: String
}
