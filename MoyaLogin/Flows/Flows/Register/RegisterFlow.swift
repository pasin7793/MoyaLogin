//
//  RegisterFlow.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/23.
//

import UIKit

import RxSwift
import RxFlow
import RxCocoa

struct RegisterStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    var initialStep: Step{
        return SampleStep.registerIsRequired
    }
}

final class RegisterFlow: Flow{
    var root: Presentable{
        return self.rootVC
    }
    private let rootVC: UINavigationController = .init()
    private let stepper: RegisterStepper
    
    init(
        with stepper: RegisterStepper
    ){
        self.stepper = stepper
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asTestStep else { return .none }
        
        switch step{
        case .registerIsRequired:
            
        }
    }
    
}
