//
//  SelectionBarView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/18.
//

import SwiftUI
import PhotosUI

struct SelectionBarView: View {
    
    @Binding var photoSheet:Bool
    
    
    var body: some View {
        VStack{
            Spacer()
            HStack(spacing:0){
                selectionButtonView("person.2.fill",Text("개발중"))
                selectionButtonView("plus.app.fill",PhotoAccessView())
                selectionButtonView("house.fill",Text("개발중"))
                selectionButtonView("bell.fill",Text("개발중"))
                selectionButtonView("map.fill",Text("개발중"))
            }
        }
    }
    private func selectionButtonView(_ buttonImage:String,_ destnaiton: some View) -> some View{
        NavigationLink(destination: destnaiton){
            buttonView(buttonImage)
        }
    }
    func buttonView(_ buttonImage:String) -> some View{
        Image(systemName: buttonImage)
            .foregroundColor(.white)
            .font(.title)
            .frame(width: UIScreen.main.bounds.width/5,height: 50)
            .padding(.top,10)
            .background(Color.soda)
            .shadow(radius: 20,x: 40)
    }
}

struct SelectionBarView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionBarView(photoSheet: .constant(false))
    }
}
