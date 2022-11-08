//
//  PhotoAccessView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/20.
//

import SwiftUI
import PhotosUI
import MapKit

struct PhotoAccessView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = MainViewModel()
    @StateObject var vmPost = PostingViewModel()
    @State var tile:String = ""
    @State var diary:String = ""
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Map(coordinateRegion: $vm.mapRegion,showsUserLocation: false)
                        .ignoresSafeArea()
                        .tint(.soda).opacity(0.5)
                        VStack(alignment: .leading,spacing: 0){
                            ScrollView{
                                TabImageView(vmPost:vmPost)
                                HStack(spacing:0){
                                    titleText()
                                    postingCategory()
                                }
                                diaryText()
                            }
                        }
                        .shadow(color:.black.opacity(0.5),radius: 20)
                }.onTapGesture {
                    UIApplication.shared.endEditing()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButtonView)
        .navigationBarTitle("게시물 작성")
        .navigationBarTitleTextColor(.sodaPrimary)
    }
    
    private func postingCategory()-> some View{
        Text("카테고리 ∇")
            .foregroundColor(.sodaPrimary)
            .frame(width: vmPost.photoWidth/2.5 ,height: 50)
            .background(Color.antiPrimary.opacity(0.5))
            .cornerRadius(10)
            .padding(5)
    }
    private func titleText()->some View{
        TextField("제목", text: $tile)
            .foregroundColor(.sodaPrimary)
            .fontWeight(.black)
            .offset(x:10)
            .frame(width: vmPost.photoWidth/2+25,height: 50)
            .background(Color.antiPrimary.opacity(0.5))
            .cornerRadius(10)
            .padding(5)
    }
    private func diaryText()->some View{
        TextEditor(text: $diary)
            .frame(width:vmPost.photoWidth - 5, height:vmPost.photoWidth * 2)
            .colorMultiply(.white.opacity(0.5))
            .foregroundColor(.primary)
            .cornerRadius(10)
            .padding(5)
            
    }
    private var backButtonView:some View{

        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }){
            Image(systemName: "xmark")
                .font(.system(size: 15,weight: .black))
                .foregroundColor(.sodaPrimary)
                .shadow(color:.black ,radius: 20)
        }
    }
    
}

struct PhotoAccessView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PhotoAccessView().environmentObject(PostingViewModel())
        }
        
    }
}
