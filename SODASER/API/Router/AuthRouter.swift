//
//  AuthRouter.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation
import Alamofire

//인증라우터
//카카오 토큰 갱신
enum AuthRouter:URLRequestConvertible{


    case getKakaoToken(
        redirectURL:URL?
    )
    
    var baseURL:URL{
        return URL(string: ApiClient.SODASER_SERVER_URL)!
    }
    
    var endPoint:String{
        switch self{
        case .getKakaoToken:
            return "login"
        default:
            return ""
        }
    }
    var method:HTTPMethod{  //어떤 api를 타느냐에 따라 설정
        switch self{
        default:return .post
        }
    }
    var parameters:Parameters{
        switch self{
        case let .getKakaoToken(redirectURL):
            var params = Parameters()
//            params["tokenType"] = tokenType
//            params["accessToken"] = accessToken
//            params["expiresIn"] = expiresIn
//            params["expiredAt"] = expiredAt
//            params["refreshToken"] = refreshToken
//            params["refreshTokenExpiresIn"] = refreshTokenExpiresIn
//            params["refreshTokenExpiredAt"] = refreshTokenExpiredAt
//            params["scope"] = scope
//            params["scopes"] = scopes
//            params["idToken"] = idToken
            params["profileImage"] = try? String(contentsOf: redirectURL!)
            return params
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)   //
        var requset = URLRequest(url:url)
        
        requset.method = method
        requset.httpBody = try JSONEncoding.default.encode(requset, with: parameters).httpBody
        return requset
    }
}
