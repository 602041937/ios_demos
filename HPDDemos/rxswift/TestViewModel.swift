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

class TestViewModel {
    
    struct Input {
        let name = BehaviorSubject<String>(value:"")
        let password = BehaviorSubject<String>(value:"")
        let testObserver: AnyObserver<Any>!
    }
    
    struct Output {
        let nameWarnHidden = BehaviorSubject<Bool>(value:true)
        let passwordWarnHidden = BehaviorSubject<Bool>(value:true)
        let loginBtnEnable = BehaviorSubject<Bool>(value:true)
        let students = BehaviorSubject<[Student]>(value:[])
    }
    
    let input:Input
    let output:Output
    
    init(disposeBag: DisposeBag) {
        
        input = Input(testObserver: AnyObserver.)
        
        output = Output()
        
        input.name.subscribe(onNext:{ text in
            self.output.nameWarnHidden.onNext(text.count == 0)
        }).disposed(by: disposeBag)
        
        input.password.subscribe(onNext: { (text) in
            self.output.passwordWarnHidden.onNext(text.count == 0)
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(input.name, input.password) { (name, password) -> Bool in
            return name.count == 0 && password.count == 0
            }.subscribe(onNext: { (enable) in
                self.output.loginBtnEnable.onNext(!enable)
            }).disposed(by: disposeBag)
        
        //        addStudentBtnTap = {
        //            if var a = try? self.output.students.value(){
        //               a.append(Student())
        //               self.output.students.onNext(a)
        //            }
        //        }
    }
}
