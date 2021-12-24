//
//  RegisterReactor.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/23.
//

import ReactorKit
import RxFlow
import RxRelay
import Darwin

final class RegisterReactor: Reactor, Stepper{
    private let disposeBag: DisposeBag = .init()
    var steps: PublishRelay<Step> = .init()
    var initialState: State = .init()
    
    enum Action{
        case updateFullName(fullName: String)
        case updateEmail(email: String)
        case updatePassword(pwd: String)
        case registerButtonDidTap
    }
    enum Mutation{
        case setFullName(fullName: String)
        case setEmail(email: String)
        case setPassword(pwd: String)
    }
    struct State{
        var fullName: String = ""
        var email: String = ""
        var password: String = ""
    }
}
extension RegisterReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateFullName(let fullName):
            return .just(.setFullName(fullName: fullName))
        case .updateEmail(let email):
            return .just(.setEmail(email: email))
        case .updatePassword(let pwd):
            return .just(.setPassword(pwd: pwd))
        case .registerButtonDidTap:
            return registerUser()
        }
    }
}
extension RegisterReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setFullName(let fullName):
            newState.fullName = fullName
        case .setEmail(let email):
            newState.email = email
        case .setPassword(let password):
            newState.password = password
        
        }
        return newState
    }
}

private extension RegisterReactor{
    func registerUser() -> Observable<Mutation>{
        let user = SignupRequest(fullName: currentState.email, email: currentState.email, password: currentState.password)
        NetworkManager.shared.signUp(user: user)
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
