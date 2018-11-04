//
//  NetUtils.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/19.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit
import Alamofire

class NetUtilsWithCodable {

    //超时时间
    private static let timeoutIntervalForRequest = 10
    
    //公共请求配置
    private static let sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeoutIntervalForRequest)
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    @discardableResult
    static func request<T:Codable>(url:String,
                                     method: HTTPMethod = .get,
                                     parameters: Parameters? = nil,
                                     successCallback:((T?) -> Void)? = nil,
                                     failureCallback:(() -> Void)? = nil) -> DataRequest {
        
        print("aaaaa")
        return sharedSessionManager.request(url, method: method, parameters: parameters).responseData(completionHandler: { (data) in
            
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data.data!)
            } catch {
                // 异常处理
                    print("aaaasa")
            }
            
        })
        
//        return sharedSessionManager.request(url, method: method, parameters: parameters).responseData(completionHandler: { (response: DataResponse<BaseEntity<T>>) in
        
//            print("💙💙💙网络请求 url=\(url)")
//            print("请求参数 parameters = \(String(describing: parameters))")
//            print("请求结果 response = \(String(data: response.data!, encoding: .utf8)!)")
//
//            if response.result.isSuccess {
//                print("✅✅✅网络请求成功了")
//                let baseResponse = response.result.value
//                if baseResponse?.status == 0 {
//                    successCallback?(baseResponse?.content)
//                }else{
//                    AppStatusCodeError.dealStatusCode(code:baseResponse?.status, message: baseResponse?.message)
//                    failureCallback?()
//                }
//            } else {
//                print("❌❌❌网络请求失败了")
//                Toast(text: response.error?.localizedDescription).show()
//                failureCallback?()
//            }
//        })
    }
}
