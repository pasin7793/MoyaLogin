//
//  LoginFlow.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//

import UIKit

import RxSwift
import RxFlow
import RxCocoa


struct LoginStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return SampleStep.loginIsRequired
    }
}

final class LoginFlow: Flow{
    var root: Presentable{
        return self.rootVC
    }
    
    private let rootVC: UINavigationController = .init() // UINavigationController()
    private let stepper: LoginStepper
    
    init (
        with stepper: LoginStepper
    ){
        self.stepper = stepper
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asTestStep else { return.none }
        
        switch step{
        case .loginIsRequired:
            return 
        }
    }
}
