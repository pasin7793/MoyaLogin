//
//  LoginAPI.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/21.
//

import Moya

enum LoginAPI{
    case signUp(SignupRequest)
    case signIn(SigninRequest)
}
    
extension LoginAPI: TargetType{
    var baseURL: URL{
        return URL(string: "http://10.53.68.75:3306/api/v1")!
    }
    var path: String{
        switch self{
        case .signUp:
            return "/register"
        case .signIn:
            return "/login"
        }
    }
    var method: Method {
        switch self {
        case .signIn,
                .signUp:
            return .post
        }
    }
    var sampleData: Data{
        return "@@".data(using: .utf8)!
    }
    var task: Task{
        switch self {
        case .signUp(let param):
            return .requestParameters(parameters: [
                "fullName" : param.fullName,
                "password" : param.password,
                "email" : param.email
            ], encoding: JSONEncoding.default)
        case .signIn(let param):
            return .requestParameters(parameters: [
                "email" : param.email,
                "password" : param.password
            ], encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self{
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
