//
//  ApiClient.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation
import Alamofire

//싱글톤
//Api 호출 클라이언트
final class ApiClient{
    
    
    var session:Session
    static let shared = ApiClient()
    static let SODASER_SERVER_URL = "http://210.2.61.231/"
    let moniters = [ApiLogger()] as [EventMonitor]      //api 호출 모니터링
    
    let intercepters = Interceptor(interceptors: [
        BaseIntercept() //application/json
    ])
    
    init(){
        print("AppiClient가 생성되었음")
        session = Session(interceptor: intercepters,eventMonitors: moniters)    //세션에 헤더 내용 추가 및 모니터링
    }
}
