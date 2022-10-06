//
//  ContentView.swift
//  Aranara
//
//  Created by Ali Hamoud on 10/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var location: CGPoint = CGPoint(x: 425, y:225)
    @State var fingerLocation: CGPoint?
    @State var moveY = false
    @State var opacity = 0.0
    @State var moveLeft = false
    @State var showMsg = false
    //@State var getSizeX: Int?
    //@State var getSizeY: Int?
    var body: some View {
        ZStack{
            Background
                .blur(radius: 3)
            Ararycan
                .position(location)
                //.offset(dragOffset)
            //drag feature to move aranara
                .gesture(
                    drag.simultaneously(with: fingerDrag)
                )
                .gesture(
                    TapGesture(count: 1)
                        .onEnded{ showMsg = true }
                )
                
            Greeting

                
        }
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
    
    
    var Message : some View{
        Text("Hello!")
            .foregroundColor(.white)
            .font(.largeTitle)

    }
    
    var Ararycan : some View{
        Image("aranara_body")
            .resizable()
            .padding()
            .frame(width: 225, height: 225)
            .overlay(
                Image("aranara_hat")
                    .resizable()
                    .frame(width: 250, height: 200)
                    .offset(x: 5, y: -105)
                    .rotationEffect(Angle(degrees: moveLeft ? 4 : 0))
            )
            .overlay(
                Image("aranara_leftArm")
                    .resizable()
                    .frame(width: 225, height: 225)
                    .offset(x: -3, y: 0)
                    .rotationEffect(Angle(degrees: moveLeft ? 3 : 0))
            )
            .overlay(
                Image("aranara_rightArm")
                    .resizable()
                    .frame(width: 225, height: 225)
                    .offset(x: 4, y: 0)
                    .rotationEffect(Angle(degrees: moveLeft ? -4 : 0))
            )
            .offset(y: moveY ? -20 : 0)
            .onAppear(){
                withAnimation(.easeInOut(duration: 2).repeatForever()){
                    moveY.toggle()
                    moveLeft.toggle()
                }
            }
    }
    
    var Greeting : some View{
        Rectangle()
            .opacity(0)
            .frame(width: 150 , height: 150)
            .offset(x:-250 ,y: moveY ? -20 : 0)
            .onTapGesture(){
            print("Hi")
    
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
