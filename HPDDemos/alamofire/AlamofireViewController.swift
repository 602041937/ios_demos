//
//  AlamofireViewController.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/11.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import Toast_Swift
import MBProgressHUD
import Toaster
import SwiftTryCatch

class AlamofireViewController: BaseViewController {
    
    @IBAction func cancelClick(_ sender: Any) {
        //        dismiss(animated: true, completion: nil)
    }
    
    public static func newInstance() -> AlamofireViewController {
        return UIStoryboard(name: "alamofire", bundle: nil).instantiateViewController(withIdentifier: "AlamofireViewController") as! AlamofireViewController
    }
    
    @IBAction func btnClick(_ sender: Any) {
        
        view.makeToast("ssss")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftTryCatch.try({
            let array = [1,2]
            let aa = array[3]
        }, catch: { (error) in
            print("\(error?.description)")
        }, finally: {
            // close resources
        })
        
        
        
        let a = "aa"
        a.startIndex
        
  
        //        test2()
        //        test3()
        
    }
    
    func test1(){
       
        let url = "http://ban.ke.passthexam.com/academy/chat_ban_words_in_json"
        NetUtils.request(url: url, method: .post, parameters: nil, successCallback: { (entity:BanWordsEntity?) in
            print("sucCallback")
        }, failureCallback: {
            print("failureCallBack")
        })
    }
    
    func test2(){
        
        let URL = "https://ieltsbroap2plicaddtion.hcp.tech:9998/academy/get_comment_to_app"
        NetUtils.requestArray(url: URL, method: .get, parameters: nil, successCallback: { (entity:[RoomCommentResponse]?) in
            print("sucCallback")
        }, failureCallback: {
            print("failureCallBack")
        })
    }
    
    func test3() {
        
        let URL = "https://ieltsbroapplication.hc2p.tech:9998/academy2/lesson_schedule"
        NetUtils.requestArray(url: URL, method: .get, parameters: nil, successCallback: { (entity:[LessonEntity]?) in
            print("sucCallback")
        }, failureCallback: {
            print("failureCallBack")
        })
    }
}

