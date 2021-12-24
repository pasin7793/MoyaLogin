//
//  NetworkManager.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//

import RxSwift
import Moya

protocol NetworkManagerType: AnyObject{
    func signUp(user: SignupRequest) -> Single<Response>
    func singIn(user: SigninRequest) -> Single<Response>
    
    var provider: MoyaProvider<LoginAPI> { get }
}

final class NetworkManager: NetworkManagerType{
    func signUp(user: SignupRequest) -> Single<Response> {
        return provider.rx.request(.requiredRegister(user: user), callbackQueue: .global())
    }
    
    func singIn(user: SigninRequest) -> Single<Response> {
        return provider.rx.request(.requiredLogin(user: user), callbackQueue: .global())
    }
    
    var provider: MoyaProvider<LoginAPI> = .init()
    
    static let shared = NetworkManager()
}
