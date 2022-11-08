//
//  SODASERApp.swift
//  SODASER
//
//  Created by 유영웅 on 2022/09/30.
//

import SwiftUI

@main
struct SODASERApp: App {
    

    var body: some Scene {
        
        WindowGroup {
            StartView()
                .environmentObject(KaKaoAuthViewModel())
                .environmentObject(LoginViewModel())
        }
    }
}
