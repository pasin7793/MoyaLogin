//
//  loginViewController.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import Moya

class loginViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    let bounds = UIScreen.main.bounds

    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요"
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
    }
    private let passwordTextField = UITextField().then{
        $0.placeholder = "비밀번호를 입력해주세요"
        //$0.isSecureTextEntry = true
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = #colorLiteral(red: 0.6, green: 0.8078431373, blue: 0.9803921569, alpha: 1)
        $0.layer.cornerRadius = 15
    }
    let provider = MoyaProvider<LoginAPI>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setupControl()
    }
    func configureUI(){
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bounds.height*0.15)
            make.width.equalTo(bounds.width*0.68)
            make.height.equalTo(bounds.height*0.051)
        }
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField).offset(bounds.height*0.1)
            make.width.equalTo(bounds.width*0.68)
            make.height.equalTo(bounds.height*0.051)
        }
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField).offset(bounds.height*0.08)
            make.width.equalTo(bounds.width*0.3)
            make.height.equalTo(bounds.height*0.051)
        }
    }
    func setupControl(){
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.emailObserver)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.passwordObserver)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .map{ $0 ? 1 : 0.3 }
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .subscribe( onNext: { [weak self] _ in
                self?.provider.rx.request(.signIn(SigninRequest(email: (self?.viewModel.emailObserver.value)!, password: (self?.viewModel.passwordObserver.value)!)))
                    .subscribe { event in
                         switch event {
                         case let .success(response):
                            print(response)
                         case let .failure(error):
                             print(error.localizedDescription)
                         }
                     }
                .disposed(by: self!.disposeBag)
            }
        ).disposed(by: disposeBag)
    }
    func provide(){
        setupControl()
        provider.rx.request(.signIn(SigninRequest(email: viewModel.emailObserver.value, password: viewModel.passwordObserver.value)))
            .subscribe { event in
                 switch event {
                 case let .success(response):
                    print(response)
                 case let .failure(error):
                     print(error.localizedDescription)
                 }
             }
        .disposed(by: disposeBag)
    }
}
