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
    
    let disposeBag = DisposeBag()
    
    let viewModel: TestViewModel = TestViewModel()
    
    let zoneCodeSubject = BehaviorSubject<String>(value: "+86")
    
    let name:Variable<String> = Variable("hpd")
    
    static func newInstance() -> RxSwiftViewController{
        return UIStoryboard(name: "rx", bundle: nil).instantiateViewController(withIdentifier: "RxSwiftViewController") as! RxSwiftViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        nameLB.text = "用户名不合法"
        passwordLB.text = "密码不合法"
        
        nameTF.rx.text.orEmpty.bind(to: viewModel.input.name).disposed(by: disposeBag)
        passwordTF.rx.text.orEmpty.bind(to: viewModel.input.password).disposed(by: disposeBag)
        viewModel.output.nameWarnHidden.bind(to: nameLB.rx.isHidden).disposed(by: disposeBag)
        viewModel.output.passwordWarnHidden.bind(to: passwordLB.rx.isHidden).disposed(by: disposeBag)
        viewModel.output.loginBtnEnable.bind(to: btn.rx.isEnabled).disposed(by: disposeBag)
    }
}
