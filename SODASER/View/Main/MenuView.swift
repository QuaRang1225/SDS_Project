//
//  MenuView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/20.
//

import SwiftUI

struct MenuView: View {
    
    @State var logOut:Bool = false
    @Binding var backButton:Bool
    @EnvironmentObject var vmKaKao:KaKaoAuthViewModel
    let userData:UserDataModel
    let loginStatusInfo : (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 상태" : "로그아웃 상태"
    }
    var body: some View {
        NavigationView{
            ZStack{
                Color.soda
                VStack{
                    backButtonView()
                        profileView()
                        Divider()
                            .frame(width: UIScreen.main.bounds.width/3)
                            .background(Color.black)
                            .padding()
                    Text("이메일 : ")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title3)
                            .padding(10)
                        Text("프로필 편접")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title3)
                            .padding(10)
                        Text("게시물")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title3)
                            .padding(10)
                        Spacer()
                    HStack{
                        kakaoLogoutButton()
                        Spacer()
                        Text(loginStatusInfo(vmKaKao.isLogedIn))
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .padding()
                    }.padding()
                    
                    
                   
                }.padding()
            }.ignoresSafeArea()
        }.environmentObject(vmKaKao)
    }
    func kakaoLogoutButton() -> some View{
        Button(action: {
            logOut.toggle()
        }){
            Text("로그아웃")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }.alert(isPresented : $logOut){
            Alert(title: Text("로그아웃을 하시겠습니까?"),message: Text("로그아웃을 할 경우 로그인 화면으로 바로 넘어가게 됩니다."), primaryButton: .destructive(Text("로그아웃"),action: {
                vmKaKao.kakoLogout()
            }), secondaryButton: .cancel(Text("취소")))
        }
    }
    func profileView() -> some View{
        VStack(spacing:0){
            profileImgaeView()
            Text("\(userData.name)")
                .font(.title)
                .foregroundColor(.white)
        }
    }
    func backButtonView() -> some View{
        HStack(spacing:0){
            Button(action: {
                backButton.toggle()
            }){
                HStack(spacing:0){
                    Image(systemName: "delete.left.fill")
                        .foregroundColor(.white)
                        .font(.title)
                    Text("홈")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.title2)
                }
            }
            
            Spacer()
        }.padding(.top,60).padding(.leading,20)
        
    }
    func profileImgaeView()->some View{
        AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS726NO-bsmgdmEijZb_udjpAs229ATg79a9w&usqp=CAU")){ image in
            switch image{
            case .empty:
                ProgressView()
                    .frame(width: UIScreen.main.bounds.width/3,height: UIScreen.main.bounds.width/3)
            case .success(let item):
                item
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: UIScreen.main.bounds.width/1.5,height: UIScreen.main.bounds.width/1.5)
                    .shadow(radius: 20)
            case .failure(_):
                Text("아이콘을 불러올수 없습니다.")
            @unknown default:
                Image("")
            }
        }
          
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(backButton: .constant(false),userData: dataSet.info).environmentObject(KaKaoAuthViewModel())
    }
}
