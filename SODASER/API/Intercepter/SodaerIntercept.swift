//
//  SodaerIntercept.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation
import Alamofire

class SodaserIntercept:RequestInterceptor{
    
    //api handler
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var request = urlRequest
        //헤더필드 값 추가
        request.addValue("applcation/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("applcation/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        completion(.success(request))       //성공 시 url 요청
    }
}
