//
//  ColorSet.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/17.
//

import Foundation
import SwiftUI


extension Color{
    static var soda = Color("SODA")
    static var sodaPrimary = Color("SODAPRI")
    static var sodaAntiPrimary = Color("SODANTI")
    static var antiPrimary = Color("BW")
    
    static func sodaserSet(_ color:String) -> some  View{
        Image(color)
            .resizable()
            .frame(width:100,height:30)
    }
}

extension View {

    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
    
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
    
        return self
    }
}
