//
//  registerViewController.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

final class registerViewController: baseVC<RegisterReactor>{
    private let fullNameTextField = AuthTextField(icon: UIImage(systemName: "person") ?? .init(), placeholder: "fullName")
    private let emailTextField = AuthTextField(icon: UIImage(systemName: "lock") ?? .init(), placeholder: "email")
    private let passwordTextField = AuthTextField(icon: UIImage(systemName: "lock") ?? .init(), placeholder: "password")
    
    private let registerButton = UIButton().then{
        $0.setTitle("Register", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue.withAlphaComponent(0.7)
        $0.layer.cornerRadius = 15
    }
}
