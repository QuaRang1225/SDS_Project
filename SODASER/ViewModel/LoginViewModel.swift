//
//  LoginViewModel.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/25.
//

import Foundation
import Alamofire
import Combine

class LoginViewModel:ObservableObject{
    
    
    var subscription = Set<AnyCancellable>()
    var sendKakaoToken = PassthroughSubject<Void,Never>()
    @Published var loginUser:KakaoTokenModel? = nil
    @Published var successLoginAlret:Bool  = false
    
    func getkakaoToken(redirectURL:URL){
        print("카카오토큰 서버로 호출")
        AuthApiService.getKakaoToken(redirectURL:redirectURL)
            .sink { (completion:Subscribers.Completion<AFError>) in
                print("completion 형태 : \(completion)")
            } receiveValue: { (receivedUser:KakaoTokenModel) in
                self.loginUser = receivedUser
                self.sendKakaoToken.send()
            }.store(in: &subscription)

    }
}
//tokenType: tokenType, accessToken: accessToken, expiresIn: expiresIn, expiredAt: expiredAt, refreshToken: refreshToken, refreshTokenExpiresIn: refreshTokenExpiresIn, refreshTokenExpiredAt: refreshTokenExpiredAt, scope: scope, scopes: scopes, idToken: idToken

//tokenType: String,
//accessToken: String,
//expiresIn: Double,
//expiredAt: Date,
//refreshToken: String,
//refreshTokenExpiresIn: Double,
//refreshTokenExpiredAt: Date,
//scope: String?,
//scopes: [String]?,
//idToken: String?
