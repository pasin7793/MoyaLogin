//
//  baseVC.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/23.
//

import UIKit
import RxSwift
import ReactorKit

class baseVC<T: Reactor>: UIViewController{
    var disposeBag: DisposeBag = .init()
    
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        provide()
        toRegisterBtn()
    }
    
    func configureUI() {}
    func provide() {}
    func toRegisterBtn() {}
}
