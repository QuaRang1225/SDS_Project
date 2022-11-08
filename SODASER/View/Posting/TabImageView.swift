//
//  TabImageView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/21.
//

import SwiftUI
import MapKit
import SwiftUI
import PhotosUI

struct TabImageView: View {
    
  
    @State var deletePhoto = false
    @StateObject var vm = MainViewModel()
    @StateObject var vmPost:PostingViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if vmPost.selectPhotoItem.isEmpty{
            if colorScheme == .dark{
                tapViewImage(plusButtonView(Color.sodaserSet("logoWhite"), 0, .white, vmPost.photoWidth))
            }else{
                tapViewImage(plusButtonView(Color.sodaserSet("logoSoda"), 0, .white, vmPost.photoWidth))
            }
        }
        else{
            HStack{
                Spacer()
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.sodaPrimary)
                    .onTapGesture {
                        deletePhoto.toggle()
                    }.alert(isPresented : $deletePhoto){
                        Alert(title: Text("사진을 모두 삭제하시겠습니까?"), primaryButton: .destructive(Text("삭제"),action: {
                            vmPost.deletePhoto()
                        }), secondaryButton: .cancel(Text("취소")))
                    }
               
                plusButtonView(Image(systemName: "photo"), 20, .sodaPrimary,10)
            }
            tapViewImage(tapView())
        }
    }
    func tapView()->some View{
        TabView{
            ForEach(vmPost.selectPhotoItem,id: \.self){
                if let image = UIImage(data: $0){
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: vmPost.photoWidth)
                            .clipped()
                           
                }
            }
        }
    }
    private func plusButtonView(_ buttonType:some View , _ size:CGFloat,_ color:Color,_ padding :CGFloat)->some View{
        PhotosPicker(selection: $vmPost.selectItem, maxSelectionCount: 5, matching: .images) {
            buttonType
                .font(.system(size: size))
                .foregroundColor(color)
                .padding(padding)
        }
        .onChange(of: vmPost.selectItem,perform: vmPost.selectPhoto)
    }
    func tapViewImage(_ mode:some View)->some View{
        mode.frame(width: vmPost.photoWidth,height: vmPost.photoWidth)
            .background(Color.antiPrimary.opacity(0.5))
            .tabViewStyle(PageTabViewStyle())
            .padding(.top,30)
    }
}

struct TabImageView_Previews: PreviewProvider {
    static var previews: some View {
        TabImageView(vmPost: PostingViewModel())
    }
}
