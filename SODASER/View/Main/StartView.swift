//
//  ContentView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/09/30.
//

import SwiftUI
import KakaoSDKAuth

struct StartView: View {
    
    
    @StateObject var vm = MainViewModel()
    
    
    var body: some View {
            ZStack{
                if vm.isLoading{
                    MainView()
                }
                else{
                    Color.soda.ignoresSafeArea()
                    logoLoading()
                }
        }
    }
    func logoLoading() -> some View{
        VStack{
            Image("logoWhite")
                .padding()
                .onAppear(perform: vm.animateLogoOn)
                .opacity(vm.animate ? 1.0:0.0)
                .offset(x:vm.animate ? 0:-100)
            Text("21세기 최고의 소셜 다이어리 서비스!")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .bold()
                .onAppear(perform: vm.animateLogoOn)
                .opacity(vm.animate ? 1.0:0.0)
                .offset(x:vm.animate ? 0:100)
            Spacer().frame(height: 100)
        }.onAppear{
            vm.cheackLocationEnabled()
        }
        
    }
    
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
