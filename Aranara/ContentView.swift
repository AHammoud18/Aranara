//
//  ContentView.swift
//  Aranara
//
//  Created by Ali Hamoud on 10/1/22.
//

import SwiftUI
import UIKit
struct ContentView: View {
    // declare some variables
    @StateObject var xmlData = Data()
    @State private var location: CGPoint = CGPoint(x: 205, y:250)
    @State var fingerLocation: CGPoint?
    @State var moveY = false
    @State var signY = false
    @State var msgOpacity = false
    @State var moveLeft = false
    @State var showMsg = false
    @State var showWeather = true
    @State var signsAnimation = false
    @State var weatherBg = Color(red: 0.8, green: 0.6, blue: 0.4)
    @State var Msg = "Hello!"
    @State var area: String?
    var body: some View {
        ZStack{
            Background
                .position(x: 400, y: signY ? 220 : 170)
                .blur(radius: 3)
                .overlay(
                    navSign
                        .offset(x: 180, y: 100)
                        .rotationEffect(Angle(degrees: 7))
                
                )
            Ararycan
                .position(location)
                //drag feature to move aranara
                /*.gesture(
                    drag.simultaneously(with: fingerDrag)
                )*/
                .overlay(Message
                    .position(location)
                    
                )
                .overlay(
                    weatherData
                        .position(x: 450, y: signY ? 210 : -110) //its current position in the view and what the Y value will change to once signY is true
                )
            
                
        }
    }
    
    var navSign : some View{
        ZStack{
            Image("sign")
                .resizable()
                .position(x: 90,y: signY ? 400 : 150)
                .frame(width: 180, height: 300)
                .overlay(
                    Button{
                        xmlData.getData() // grab weahter data
                        withAnimation(.easeInOut(duration: 1.5))
                        {
                            // initiate animation
                            signY.toggle()
                        }
                    }
                    label:{
                        Text("Weather")
                            .foregroundColor(weatherBg)
                            .font(.title)
                    }
                        //.offset(y: -120)
                        .position(x: 90, y: signY ? 280 : 30 )
                )
        }
    }
    

    
    var Message : some View{
        VStack{
            Button{
                showMsg.toggle()
            }
        label:{
            Text("")
                .frame(width: 20, height: 80)
            
        }
            if showMsg {
                Text(Msg)
                    .opacity(1.0)
                    .onAppear(){
                        withAnimation(.easeIn(duration: 1).repeatCount(1)){
                            //msgOpacity.toggle()
                            showMsg.toggle()
                        }
                    }
                    .offset(x: 165, y: -70)
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
    }
    
    
    // this is the image with some animations
    var Ararycan : some View{
        Image("aranara_rightArm")
            .resizable()
            .frame(width: 225, height: 225)
            .offset(x: 3 ,y: moveY ? -20 : 0)
            .rotationEffect(Angle(degrees: moveLeft ? -4 : 0))
            .overlay(Image("aranara_body")
                .resizable()
                .padding()
                .frame(width: 250, height: 250)
                .overlay(
                    Image("aranara_hat")
                        .resizable()
                        .frame(width: 250, height: 200)
                        .offset(x: -2, y: -105)
                        .rotationEffect(Angle(degrees: moveLeft ? 4 : 0))
                )
                .overlay(
                    Image("aranara_leftArm")
                        .resizable()
                        .frame(width: 225, height: 225)
                        .offset(x: -7.5, y: 1)
                        .rotationEffect(Angle(degrees: moveLeft ? 2 : 0))
                )
                .offset(y: moveY ? -20 : 0)
                .onAppear(){
                    withAnimation(.easeInOut(duration: 2).repeatForever()){
                        moveY.toggle()
                        moveLeft.toggle()
                    }
                }
        )
    }
    
    var drag: some Gesture{ //initial drag
        DragGesture()
            .onChanged{ value in self.location = value.location
                
            }
    }
    var fingerDrag: some Gesture { //fixes finger position so that location does not jump
        DragGesture()
            .onChanged { value in
                self.fingerLocation = value.location
            }
            .onEnded { value in
                self.fingerLocation = nil
            }
    }
    
    var weatherData: some View{
        ZStack{
            VStack{
                    Image("Data_sign")
                        .resizable()
                        .frame(width: 400, height: 400)
                        .offset(x: 180, y: -100)
                        .overlay(
                            Button{
                                // initiate animation
                                withAnimation(.easeInOut(duration: 2)){
                                    signY.toggle()
                                    }
                                    
                            } label: {
                                Text("Back")
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                                .offset(x: 185, y: 65)
                        
                        )
                        .overlay(
                            Text(xmlData.location ?? "")
                                .foregroundColor(.white)
                                .font(.title3)
                                .offset(x: 180, y: -165)
                                .padding(EdgeInsets(top: 30, leading: 35, bottom: 30, trailing: 25))
                        )
                        .overlay(
                            Text(xmlData.weather ?? "")
                                .foregroundColor(.white)
                                .font(.title)
                                .offset(x: 180, y: -90)
                        )
                        .overlay(
                            Text(xmlData.temperature ?? "")
                                .foregroundColor(.white)
                                .font(.title)
                                .offset(x: 180, y: -10)
                        )
                }
        }
    }
}


var Background : some View{
    Image("sumeruBackground")
        .resizable()
        .frame(width: 1800/2, height: 900/2)
        
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .ignoresSafeArea(.all)
            .previewInterfaceOrientation(   .landscapeLeft)
    }
}
