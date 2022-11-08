//
//  MainViewModel.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/17.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

class MainViewModel:NSObject,CLLocationManagerDelegate,ObservableObject{
    

    var manager = CLLocationManager()
    var mySpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    
    @Published var animate:Bool = false
    @Published var mapRegion = MKCoordinateRegion()
    @Published var isLoading:Bool = false
    @Published var isActiveMenu:Bool = false
    @Published var ispresentPhoto:Bool = false
    
    //MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:36.3023209 , longitude: 127.3527746), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func cheackLocationEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            manager = CLLocationManager()
            manager.delegate = self
        }else{
            print("꺼져 있음을 알리고 켜도록 팝업 표시")
        }
    }
    func checkLocationAuthrization(){
        switch manager.authorizationStatus{
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        case .restricted:
            print("위치가 정보가 제한됨")
        case .denied:
            
            print("위치 정보가 거부되었음, 설정 변경 요망")
        case .authorizedAlways, .authorizedWhenInUse:
            withAnimation(.easeInOut(duration: 1.0)){
                self.mapRegion = MKCoordinateRegion(center: self.manager.location!.coordinate, span: self.mySpan)
            }
            if !isLoading{
                animateLogoOn()
                animateLogoOff()
            }else{ return }
            break
        @unknown default:
            break
        }
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthrization()
    }
    func animateLogoOn(){
        DispatchQueue.main.async {
            withAnimation(.easeIn(duration: 0.5)){
                self.animate.toggle()
            }
        }
    }
    func animateLogoOff(){
        DispatchQueue.global().asyncAfter(deadline:.now() + 1.0){
            withAnimation(.easeIn(duration: 0.5)){
                self.isLoading = true
            }
        }
    }
   
}
