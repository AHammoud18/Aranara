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
    @State var currentLocation: String?
    
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
                .onAppear(){
                    // throw the current state and city into a string
                    currentLocation = "\(xmlData.location ?? ""), \(xmlData.state ?? "")"
                }
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
                        .position(x: 380, y: signY ? 240 : -110) //its current position in the view and what the Y value will change to once signY is true
                )
        }.onAppear(){
            xmlData.getLocation()
            // load weather data
            xmlData.loadAPIData()
            xmlData.getWeatherStatus()
            
        }
    }
    
    var navSign : some View{ // create the menu sign
        ZStack{
            Image("sign")
                .resizable()
                .position(x: 90,y: signY ? 400 : 150)
                .frame(width: 180, height: 300)
                .overlay( // add a button to the sign
                    Button{
                        withAnimation(.easeInOut(duration: 1.5))
                        {
                            // initiate animation
                            signY.toggle()
                        }
                    }
                    label:{ // the label for that button
                        Text("Weather")
                            .foregroundColor(weatherBg)
                            .font(.custom("HYWenHei-HEW",size: 20))
                            
                            
                    }
                        // position of this button
                        .position(x: 90, y: signY ? 280 : 30 )
                )
        }
    }
    

    // little test button that says hello when aranara is tapped
    var Message : some View{
        VStack{
            Button{
                showMsg.toggle()
            }
        label:{
            Text("")
                .frame(width: 20, height: 80)
            
        }
            if showMsg { // basically shows the text if bool is true
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
    // I'm utilizing the ternary operator to move between fixed values dependant on the state of the bool
    var Ararycan : some View{
        Image("aranara_rightArm") // first image
            .resizable()
            .frame(width: 225, height: 225)
            .offset(x: 3 ,y: moveY ? -20 : 0)
        // this would rotate his arm -4 degrees and back to 0
            .rotationEffect(Angle(degrees: moveLeft ? -4 : 0))
            .overlay(Image("aranara_body") // second
                .resizable()
                .padding()
                .frame(width: 250, height: 250)
                .overlay(
                    Image("aranara_hat") // third
                        .resizable()
                        .frame(width: 250, height: 200)
                        .offset(x: -2, y: -105)
                        .rotationEffect(Angle(degrees: moveLeft ? 4 : 0))
                )
                .overlay(
                    Image("aranara_leftArm") // fourth..
                        .resizable()
                        .frame(width: 225, height: 225)
                        .offset(x: -7.5, y: 1)
                        .rotationEffect(Angle(degrees: moveLeft ? 2 : 0))
                )
                .offset(y: moveY ? -20 : 0)
                .onAppear(){ // moves aranara up and down
                    withAnimation(.easeInOut(duration: 2).repeatForever()){
                        moveY.toggle()
                        moveLeft.toggle()
                    }
                }
        )
    }
    
    // creating a gesture to move the little guy around
    
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
    
    
    // this block governs the weather data and creates a new sign that displays that in formatted view
    var weatherData: some View{
        ZStack{
            VStack{
                    Image("data_sign2")
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
                                    .font(.custom("HYWenHei-HEW",size: 20, relativeTo: .title))
                            }
                                .offset(x: 185, y: 65)
                        
                        )
                // bunch of overlays..
                        .overlay(
                            Text("\(xmlData.location ?? ""), \(xmlData.state ?? "")")
                                .foregroundColor(.white)
                                .font(.custom("HYWenHei-HEW",size: 20, relativeTo: .title))
                                .offset(x: 180, y: -195)
                                .padding(EdgeInsets(top: 30, leading: 35, bottom: 30, trailing: 25))
                        )
                        .overlay(
                            Text("fetch weahter status")
                                .foregroundColor(.white)
                                .font(Font.custom("HYWenHei-HEW",size: 20, relativeTo: .title))
                                .offset(x: 180, y: -125)
                        )
                        .overlay(
                            Image(xmlData.weatherImg ?? "")
                                .resizable()
                                .frame(width: 58,height: 58)
                                .offset(x: 180, y: -20)
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
