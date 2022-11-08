//
//  LoginView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/22.
//



import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

struct LoginView: View {
    
    
    @EnvironmentObject var loginVM:LoginViewModel
    @EnvironmentObject var kakaoVm:KaKaoAuthViewModel
    @StateObject var vmPost = PostingViewModel()
    
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack{
                Image("logoWhite")
                    .resizable()
                    .frame(width: 200,height: 70)
                    .shadow(radius: 20)
                    .padding()
                Spacer().frame(width: 200,height: 70)
                Text("로그인하기")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.black)
                    .shadow(radius: 20)
                    .padding()
                kakaoLogin().shadow(radius: 20)
                    .padding(.bottom,30)

            }
            .frame(width: vmPost.photoWidth / 1.5)
            .padding()
            .cornerRadius(20)
            .shadow(radius: 20)
            .environmentObject(kakaoVm)
            .onReceive(kakaoVm.sendKakaoToken){
//                loginVM.getkakaoToken(tokenType: (kakaoVm.token?.tokenType!) ?? "", accessToken: (kakaoVm.token?.accessToken) ?? "", expiresIn: (kakaoVm.token?.expiresIn) ?? 0, expiredAt: (kakaoVm.token?.expiredAt) ?? Date(), refreshToken: (kakaoVm.token?.refreshToken) ?? "", refreshTokenExpiresIn: (kakaoVm.token?.refreshTokenExpiresIn) ?? 0, refreshTokenExpiredAt: (kakaoVm.token?.refreshTokenExpiredAt) ?? Date(), scope: (kakaoVm.token?.scope) ?? "", scopes: (kakaoVm.token?.scopes) ?? nil, idToken: (kakaoVm.token?.idToken) ?? "")
                loginVM.getkakaoToken(redirectURL: (kakaoVm.token?.redirectURL ?? URL(string: "")!))
                self.loginVM.successLoginAlret = true
                print("토큰 : \(String(describing: (kakaoVm.token?.redirectURL)!))")
            }
            
        }
        .environmentObject(kakaoVm)
        .environmentObject(loginVM)
        
                
            
    }
    func kakaoLogin() -> some View{
        Button(action: {
            DispatchQueue.main.async {
                withAnimation(.easeIn){
                    kakaoVm.handleKakaoLogin()
                }
            }
            
        }){
            Text("카카오로 로그인")
                .foregroundColor(.black)
                .fontWeight(.black)
                .font(.title3)
                .frame(width : vmPost.photoWidth / 1.5)
                .padding(.vertical,15)
                .background(Color.yellow)
                .cornerRadius(10)
                .overlay(alignment: .leading){
                    Image("kakao")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .scaledToFill()
                        .padding()
                }
            
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(KaKaoAuthViewModel())
    }
}
