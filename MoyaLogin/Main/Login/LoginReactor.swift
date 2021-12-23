//
//  LoginReactor.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/23.
//

import ReactorKit
import RxSwift
import RxFlow
import RxRelay

final class LoginReactor: Reactor, Stepper{
    private let disposeBag: DisposeBag = .init()
    var steps: PublishRelay<Step> = .init()
    var initialState: State = .init()
    
    enum Action{
        case updateEmail(name: String)
        case updatePassword(pwd: String)
        case loginButtonDidTap
        case registerButtonDidTap
    }
    enum Mutation{
        case setEmail(email: String)
        case setPassword(pwd: String)
    }
    struct State{
        var email: String = ""
        var password: String = ""
    }
}

extension LoginReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateEmail(let email):
            return .just(.setEmail(email: email))
        case .updatePassword(let pwd):
            return .just(.setPassword(pwd: pwd))
        case .loginButtonDidTap:
            return login()
        case .registerButtonDidTap:
            steps.accept(SampleStep.registerIsRequired)
            return .empty()
        }
    }
}

extension LoginReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setEmail(let email):
            newState.email = email
        case .setPassword(let pwd):
            newState.password = pwd
        }
        return newState
    }
}

private extension LoginReactor{
    func login() -> Observable<Mutation>{
        let user = SigninRequest(email: currentState.email, password: currentState.password)
        NetworkManager.shared.singIn(query: user)
            .asObservable()
            .subscribe(onNext: { [weak self] res in
                switch res.statusCode{
                case 200:
                    print("Login Success")
                case 400:
                    self?.steps.accept(SampleStep.alert(title: "Error", message: "다시하셈 ㅋ"))
                default:
                    print(res.statusCode)
                    break
                }
            })
        return .empty()
    }
}
