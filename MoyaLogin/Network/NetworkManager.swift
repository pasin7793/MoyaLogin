//
//  NetworkManager.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//

import RxSwift
import Moya

protocol NetworkManagerType: class{
    func signUp(query: SignupRequest) -> Observable<Response>
    
    func singIn(query: SigninRequest) -> Observable<Response>
    
    var provider: MoyaProvider<LoginAPI> { get }
}

final class NetworkManager: NetworkManagerType{
    func signUp(query: SignupRequest) -> Observable<Response> {
        return provider.rx.request(.signUp(query), callbackQueue: .main).asObservable()
    }
    func singIn(query: SigninRequest) -> Observable<Response> {
        return provider.rx.request(.signIn(query), callbackQueue: .main).asObservable()
    }
    var provider: MoyaProvider<LoginAPI> = .init()
    
    static let shared = NetworkManager()
}
