//
//  SampleStep.swift
//  MoyaLogin
//
//  Created by 임준화 on 2021/12/22.
//

import RxFlow

enum SampleStep: Step{
    case alert(title:String?, message: String?)
    case dismiss
    
    case loginIsRequired
    case registerIsRequired
}
