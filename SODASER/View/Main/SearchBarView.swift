//
//  SearchBarView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/17.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var menueButton:Bool
    @Binding var text:String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .center, spacing:0){
            Button(action: {
                menueButton.toggle()
            }){
                Image(systemName:"line.3.horizontal.circle.fill")
                    .foregroundColor(colorScheme == .dark ? .white : .soda)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    
            }
            TextField(text: $text){
                Text("검색..")
                .foregroundColor(.gray)
            }
            .disableAutocorrection(true) //자동 수정기능 비활성화
            .foregroundColor(.soda)
            .fontWeight(.heavy)
            .offset(x:50)
            .frame(width: UIScreen.main.bounds.width - 80,height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .opacity(0.9)
            .shadow(radius: 20)
            .padding(10)
            .overlay(magnifier(),alignment: .leading)
            .overlay(xmark(),alignment: .trailing)
        }
      
    }
}
extension SearchBarView{
    func magnifier() -> some View{
        Image(systemName: "magnifyingglass")
            .foregroundColor(.soda)
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .offset(x:0)
    }
    func xmark() -> some View{
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(.soda)
            .font(.headline)
            .padding(30)
            .opacity(text.isEmpty ?  0.0 : 1.0)
            .onTapGesture {
                UIApplication.shared.endEditing()
                text = ""
                print("눌림")
            }
    }
}
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(menueButton:.constant(false) , text: .constant(""))
    }
}

