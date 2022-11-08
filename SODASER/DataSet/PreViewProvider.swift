//
//  PreViewProvider.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/25.
//

import Foundation
import SwiftUI

extension PreviewProvider{
    static var dataSet:CustomPreView{
        return CustomPreView.instance
    }
}

class CustomPreView{
    static let instance = CustomPreView()
    let info = UserDataModel(name: "콰랑", email: "e-mail", profileImage: "noIcon")
}
