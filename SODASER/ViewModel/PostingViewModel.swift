//
//  PostingViewModel.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/21.
//

import Foundation
import SwiftUI
import PhotosUI

class PostingViewModel:ObservableObject{
    
    let itemKey:String = "게시물"
    let photoWidth = UIScreen.main.bounds.width
    
    @Published var selectItem:[PhotosPickerItem] = []
    @Published var selectPhotoItem:[Data] = []
    @Published var photoSet:[Int] = []
    @Published var photoData:[PostingModel] = []
//    @Published var postItem:[PostingModel] = []{
//        didSet{
//            savePost()  //값이 변함을 감지하여 저장
//        }
//    }
//    init(){
//        getPost()
//    }
    
    func selectPhoto(item:[PhotosPickerItem]){
        selectPhotoItem.removeAll() //사진을 새로 선택할 때마다 상태변경
        Task {  //사진 저장 동기처러
            for newItem in item {
                //Task - 비동기
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    selectPhotoItem.append(data)
                    print("현재 사진 선택 상태 : \(selectPhotoItem)")
                    print("현재 업로드된 사진 상태 : \(selectItem)")
                }
            }
        }
    }
    func deletePhoto(){
        selectItem.removeAll()
    }
//    func getPost(){
//        guard
//            let data = UserDefaults.standard.data(forKey: itemKey),
//            let saveData = try? JSONDecoder().decode([PostingModel].self, from: data)
//        else{return}
//        self.postItem = saveData
//    }
//    func upadatePost(item:PostingModel){
//        if let index = postItem.firstIndex(where: {$0.id == item.id}){
//            postItem[index] = item.updatePost()
//        }
//    }
//    func savePost(){
//        if let encodeData = try? JSONEncoder().encode(postItem){
//            UserDefaults.standard.set(encodeData,forKey:itemKey)
//        }
//    }
    
    
}
