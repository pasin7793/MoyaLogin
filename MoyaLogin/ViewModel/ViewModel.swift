//
//  ViewModel.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//

import RxSwift
import RxRelay
import UIKit

class ViewModel{
    struct Input{
        var email: Observable<String>
        var password: Observable<String>
    }
    struct Output{
        var isValid: Observable<Bool>
    }
    func transform(_ input: Input) -> Output{
        let valid = Observable.combineLatest(input.email, input.password).map{self.isValidation($0, $1)}
        return Output(isValid: valid)
    }
    
    func isValidation(_ email: String, _ password: String) -> Bool {
        return email.isEmpty == false && password.isEmpty == false
    }
}
