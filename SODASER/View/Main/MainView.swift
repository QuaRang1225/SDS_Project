//
//  MainView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/17.
//

import SwiftUI
import MapKit
import CoreLocationUI
import KakaoSDKCommon
import KakaoSDKAuth

struct MainView: View {

    @State var text:String = ""
    @StateObject var vm = MainViewModel()
    @EnvironmentObject var kakaoVm:KaKaoAuthViewModel
    @EnvironmentObject var loginVM:LoginViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegat
    let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
    init() {// Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
    }
    
       var body: some View {
           NavigationView{
               ZStack(alignment: .top){
                   Map(coordinateRegion: $vm.mapRegion ,showsUserLocation: kakaoVm.isLogedIn ? true : false).onTapGesture {
                       UIApplication.shared.endEditing()
                   }
                       .ignoresSafeArea()
                       .tint(.soda)
                   if kakaoVm.isLogedIn{
                       ZStack{
                           SelectionBarView(photoSheet: $vm.ispresentPhoto)
                               VStack(alignment: .trailing,spacing: 0){
                                   SearchBarView(menueButton:$vm.isActiveMenu ,text: $text)
                                   Spacer()
                                   HStack{
                                       if colorScheme == .dark{
                                           Color.sodaserSet("logoWhite").padding(.leading)
                                       }else{
                                           Color.sodaserSet("logoSoda").padding(.leading)
                                       }
                                       Spacer()
                                       GPSButton()
                                   }
                                   Spacer().frame(height: 85)
                               }
                               menuView()
                       }
                       .onReceive(loginVM.sendKakaoToken){  //동작이 완료되었을때
                           print("서버에 로딩이 완료되었습니다.")
                       }
                   }
                   else{
                       LoginView()
                   }
               }
               .ignoresSafeArea(.keyboard, edges: .bottom) //키보드무시
               .alert(isPresented: $loginVM.successLoginAlret){
                   Alert(title: Text("로그인 성공!"), message: nil,dismissButton: .default(Text("확인")))
               }
           }
           .onOpenURL(perform: { url in
               if (AuthApi.isKakaoTalkLoginUrl(url)) {
                   AuthController.handleOpenUrl(url: url)
                   kakaoVm.token = KakaoTokenModel(redirectURL: url)
                   print("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ:\(url)")
               }
           })
           .animation(.easeIn, value: true)

           .environmentObject(kakaoVm)
           .environmentObject(loginVM)
       }
}
extension MainView{
    func GPSButton() -> some View{
        LocationButton(.currentLocation){
            vm.cheackLocationEnabled()
        }
        .labelStyle(.iconOnly)
        .foregroundColor(.soda)
        .symbolVariant(.fill)
        .tint(.white)
        .cornerRadius(10)
        .shadow(radius: 20)
        .padding(.trailing,20)
    }
    func menuView()->some View{
        ZStack{
            Color.black.opacity(vm.isActiveMenu ? 0.8 : 0.0)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width)
                .onTapGesture {
                    vm.isActiveMenu = false
                }
            HStack{
                if vm.isActiveMenu{
                    MenuView(backButton: $vm.isActiveMenu,userData: CustomPreView.instance.info)
                        .frame(width: UIScreen.main.bounds.width/1.5)
                        .transition(.move(edge: .leading))
                        .animation(.easeInOut(duration: 0.1))
                }
                Spacer()
            }
        }
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(KaKaoAuthViewModel())
    }
}
