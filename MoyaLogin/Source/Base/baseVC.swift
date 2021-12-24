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
    }
    init(reactor: T){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    func configureUI() {}
    func provide() {}
    
    func bindView(reactor: T) {}
}
extension baseVC: View{
    func bind(reactor: T) {
        bindView(reactor: reactor)
    }
}
