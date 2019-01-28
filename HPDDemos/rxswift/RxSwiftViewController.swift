//
//  RxSwiftViewController.swift
//  HPDDemos
//
//  Created by huangpeidong on 2019/1/19.
//  Copyright © 2019年 hpd. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Action

protocol My {
    var name:String { get set }
}


class RxSwiftViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var passwordLB: UILabel!
    
    @IBOutlet weak var addStudentBtn: UIButton!
    let disposeBag = DisposeBag()
    
    var viewModel: TestViewModel!
    
    let zoneCodeSubject = BehaviorSubject<String>(value: "+86")
    
    let name:Variable<String> = Variable("hpd")
    
    static func newInstance() -> RxSwiftViewController{
        let vc = UIStoryboard(name: "rx", bundle: nil).instantiateViewController(withIdentifier: "RxSwiftViewController") as! RxSwiftViewController
        vc.viewModel = TestViewModel(disposeBag: vc.disposeBag)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        nameLB.text = "用户名不合法"
        passwordLB.text = "密码不合法"
        
        nameTF.rx.text.orEmpty.subscribe(onNext:{ (text) in
            self.viewModel.input.name.onNext(text)
        }).disposed(by: disposeBag)
        
        nameTF.rx.text.orEmpty.bind(to: viewModel.input.name).disposed(by: disposeBag)
        passwordTF.rx.text.orEmpty.bind(to: viewModel.input.password).disposed(by: disposeBag)
        viewModel.output.nameWarnHidden.bind(to: nameLB.rx.isHidden).disposed(by: disposeBag)
        viewModel.output.passwordWarnHidden.bind(to: passwordLB.rx.isHidden).disposed(by: disposeBag)
        viewModel.output.loginBtnEnable.bind(to: btn.rx.isEnabled).disposed(by: disposeBag)
        
        viewModel.output.students.subscribe(onNext: { (students) in
            print("controller")
            print(students.count)
        }).disposed(by: disposeBag)
        
//        addStudentBtn.rx.tap.bind(to: viewModel.input.name)
        
//        addStudentBtn.rx.tap.bind(to: viewModel.input.testObserver)
//        addStudentBtn.rx.tap.subscribe(viewModel.input.testObserver).disposed(by: disposeBag)
        
    }
}
