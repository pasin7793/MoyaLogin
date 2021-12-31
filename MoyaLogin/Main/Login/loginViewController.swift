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
import ReactorKit

//configureUI,provide, registerBtn

class loginViewController: baseVC<LoginReactor>{
    
    let viewModel = ViewModel()
    let provider = MoyaProvider<LoginAPI>()
    let bounds = UIScreen.main.bounds

    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력해주세요"
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 10
    }
    private let passwordTextField = UITextField().then{
        $0.placeholder = "비밀번호를 입력해주세요"
        //$0.isSecureTextEntry = true
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 10
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = #colorLiteral(red: 0.6, green: 0.8078431373, blue: 0.9803921569, alpha: 1)
        $0.layer.cornerRadius = 15
    }
    private let toRegisterBtn = UIButton().then{
        $0.setTitle("회원가입이나 하셈 ㅋ", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
    override func configureUI(){
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
        view.addSubview(toRegisterBtn)
        toRegisterBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton).offset(bounds.height*0.35)
        }
    }
    func setupControl(){
        let input = ViewModel.Input(email: emailTextField.rx.text.orEmpty.asObservable(),
                                    password: passwordTextField.rx.text.orEmpty.asObservable())
        
        let output = viewModel.transform(input)
        output.isValid
            .map { $0 ? 1.0 : 0.3}
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)
    }
    override func provide(){
        setupControl()
        provider.rx.request(.requiredLogin(user: SigninRequest(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")), callbackQueue: .global())
            .asObservable()
            .subscribe { res in
                print(try! res.mapJSON())
            } onError: { err in
                print(err.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: LoginReactor){
        toRegisterBtn.rx.tap
            .map { Reactor.Action.registerButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
