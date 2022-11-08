//
//  AuthResponse.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation

struct AuthResponse:Codable{
    var user:UserDataModel
    var token:KakaoTokenModel
    
}
