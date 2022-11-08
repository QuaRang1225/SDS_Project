//
//  UserDataModel.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/22.
//

import Foundation


struct UserDataModel:Identifiable,Codable{
    
    var id:String = UUID().uuidString
    var name:String
    var email:String
    var profileImage:String?  
    
    func updatePost() -> UserDataModel{
        return UserDataModel(name: name, email: email, profileImage: profileImage)
    }
}
