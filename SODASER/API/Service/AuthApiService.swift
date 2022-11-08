//
//  AuthApiService.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation
import Alamofire
import Combine

//인증 관련 api 호출
enum AuthApiService{
    static func getKakaoToken(redirectURL:URL?)-> AnyPublisher<KakaoTokenModel,AFError>{
        print("AuthAPiService - 토큰값 호출")
        return ApiClient.shared.session
            .request(AuthRouter.getKakaoToken(redirectURL:redirectURL))
            .publishDecodable(type:KakaoTokenModel.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }.eraseToAnyPublisher()
    }
}
