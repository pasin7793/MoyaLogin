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
    func readyToEmitSteps() {
        Observable.just(SampleStep.loginIsRequired)
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}

final class AppFlow: Flow{
    var root: Presentable{
        return self.rootWindow
    }
    private let rootWindow: UIWindow
    
    init(
        with window: UIWindow
    ){
        self.rootWindow = window
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asTestStep else { return .none }
        switch step{
        case .loginIsRequired:
            return coordinateToLoginVC()
        case .registerIsRequired:
            return coordinateToRegisterVC()
            
        default:
            return .none
        }
    }
}
private extension AppFlow{
    func coordinateToLoginVC() -> FlowContributors{
        let flow = LoginFlow(with: .init())
        Flows.use(flow, when: .created){ [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        let nextStep = OneStepper(withSingleStep: SampleStep.loginIsRequired)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
    func coordinateToMainVC() -> FlowContributors{
        let flow = lo
    }
}
