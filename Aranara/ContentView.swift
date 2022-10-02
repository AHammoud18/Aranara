//
//  ContentView.swift
//  Aranara
//
//  Created by Ali Hamoud on 10/1/22.
//

import SwiftUI

struct ContentView: View {
    @State var moveY = false
    @State var opacity = 0.0
    //@State var getSizeX: Int?
    //@State var getSizeY: Int?
    var body: some View {
        ZStack{
            Background
                .blur(radius: 3)
            Ararycan
            Greeting

                
        }
    }
    
    var Ararycan : some View{
        Image("Ararycan")
            .resizable()
            .padding()
            .frame(width: 325, height: 325)
            .offset(x:-250, y: moveY ? -20 : 0)
            .onAppear(){
                withAnimation(.easeInOut(duration: 2).repeatForever()){
                    moveY.toggle()
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
