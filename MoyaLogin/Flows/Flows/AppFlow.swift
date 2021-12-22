//
//  AppFlow.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//
import RxCocoa
import RxSwift
import RxFlow

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    let provider 
    func readyToEmitSteps() {
        
    }
}

final class AppFlow: Flow{
    func navigate(to step: Step) -> FlowContributors {
        <#code#>
    }
    
    var root: Presentable{
        return self.rootWindow
    }
    private let rootWindow: UIWindow
    
}
