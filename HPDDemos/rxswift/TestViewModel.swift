//
//  TestViewModel.swift
//  HPDDemos
//
//  Created by huangpeidong on 2019/1/22.
//  Copyright © 2019年 hpd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol TestInput {
    var name: BehaviorSubject<String> { get set }
    var password: BehaviorSubject<String> { get set }
}

protocol TestOutput {
    var nameWarnHidden: BehaviorSubject<Bool> { get }
    var passwordWarnHidden: BehaviorSubject<Bool> { get }
    var loginBtnEnable: BehaviorSubject<Bool> { get }
}

protocol TestViewModelType {
    var input:TestInput { get }
    var output:TestOutput { get }
}

class TestViewModel:TestViewModelType,TestInput,TestOutput {
    
    var output: TestOutput { return self }
    var input: TestInput { return self }
    
    var name = BehaviorSubject<String>(value:"")
    var password = BehaviorSubject<String>(value:"")
    
    var nameWarnHidden = BehaviorSubject<Bool>(value:true)
    var passwordWarnHidden =  BehaviorSubject<Bool>(value:true)
    var loginBtnEnable = BehaviorSubject<Bool>(value:true)
    
    init() {
        input.name.subscribe(onNext:{ text in
            self.nameWarnHidden.onNext(text.count == 0)
        })
        
        input.password.subscribe(onNext: { (text) in
            self.passwordWarnHidden.onNext(text.count == 0)
        })
        
        Observable.combineLatest(input.name, input.password) { (name, password) -> Bool in
            return name.count == 0 && password.count == 0
            }.subscribe(onNext: { (enable) in
                self.loginBtnEnable.onNext(!enable)
            })
    }
}
