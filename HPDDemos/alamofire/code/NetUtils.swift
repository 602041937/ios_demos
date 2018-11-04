//
//  NetUtils.swift
//  HPDDemos
//
//  Created by hpd on 2018/9/11.
//  Copyright © 2018年 hpd. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import Toaster

class NetUtils {
    
    //超时时间
    private static let timeoutIntervalForRequest = 10
    
    //公共请求配置
    private static let sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeoutIntervalForRequest)
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    //当content不是一个数组的时候
    @discardableResult
    static func request<T: Mappable>(url:String,
                                     method: HTTPMethod = .get,
                                     parameters: Parameters? = nil,
                                     successCallback:((T?) -> Void)? = nil,
                                     failureCallback:(() -> Void)? = nil) -> DataRequest {
        
        return sharedSessionManager.request(url, method: method, parameters: parameters).responseObject(completionHandler: { (response: DataResponse<BaseResponse<T>>) in
            
            print("💙💙💙网络请求 url=\(url)")
            print("请求参数 parameters = \(String(describing: parameters))")
            print("请求结果 response = \(String(data: response.data!, encoding: .utf8)!)")
            
            if response.result.isSuccess {
                print("✅✅✅网络请求成功了")
                let baseResponse = response.result.value
                if baseResponse?.status == 0 {
                    successCallback?(baseResponse?.content)
                }else{
                    AppStatusCodeError.dealStatusCode(code:baseResponse?.status, message: baseResponse?.message)
                    failureCallback?()
                }
            } else {
                print("❌❌❌网络请求失败了")
                Toast(text: response.error?.localizedDescription).show()
                failureCallback?()
            }
        })
    }
    
    //当content是一个数组的时候
    @discardableResult
    static func requestArray<T: Mappable>(url:String,
                                          method: HTTPMethod = .get,
                                          parameters: Parameters? = nil,
                                          successCallback:(([T]?) -> Void)? = nil,
                                          failureCallback:(() -> Void)? = nil) -> DataRequest {
        
        let dataRequest =  sharedSessionManager.request(url, method: method, parameters: parameters).responseObject { (response: DataResponse<BaseArrayResponse<T>>) in
            
            print("💙💙💙网络请求 url=\(url)")
            print("请求参数 parameters = \(String(describing: parameters))")
            print("请求结果 response = \(String(data: response.data!, encoding: .utf8)!)")
            
            if response.result.isSuccess {
                print("✅✅✅网络请求成功了")
                let baseResponse = response.result.value
                if baseResponse?.status == 0 {
                    successCallback?(baseResponse?.content)
                }else{
                    AppStatusCodeError.dealStatusCode(code:baseResponse?.status, message: baseResponse?.message)
                    failureCallback?()
                }
            } else {
                print("❌❌❌网络请求失败了")
                Toast(text: response.error?.localizedDescription).show()
                failureCallback?()
            }
        }
        return dataRequest
    }
}
