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
    @State private var location: CGPoint = CGPoint(x: 205, y:275)
    @State var fingerLocation: CGPoint?
    @State var moveY = false
    @State var msgOpacity = false
    @State var moveLeft = false
    @State var showMsg = false
    @State var Msg = "Hello!"
    var body: some View {
        ZStack{
            Background
                .blur(radius: 3)
            Ararycan
                .position(location)
                //drag feature to move aranara
                /*.gesture(
                    drag.simultaneously(with: fingerDrag)
                )*/
                .overlay(Message
                    .position(location)
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
