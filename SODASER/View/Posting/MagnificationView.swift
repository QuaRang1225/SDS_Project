//
//  MagnificationView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/11/01.
//

import SwiftUI

class Amount:ObservableObject{
    
}
struct MagnificationView: View {
    @State var currentAmount:CGFloat = 0
    @State var lastAmount:CGFloat = 0
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                Rectangle()
                    .stroke()
                    .frame(width: 200,height: 200)
                cutPhoto()
            }
            
            Spacer()
            
            cutPhoto()
        }
        
    }
    func cutPhoto() -> some View{
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.title)
            .padding(40)
            .padding(.vertical,500)
            .background(Color.blue.cornerRadius(20))
            .scaleEffect(1 + currentAmount + lastAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged{ value in
                        currentAmount = value - 1
                    }
                    .onEnded{ value in
                         lastAmount += currentAmount
                         currentAmount = 0
                    }
            )
            .frame(width: 200,height: 200)
            .clipped()
    }
}

struct MagnificationView_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationView()
    }
}
