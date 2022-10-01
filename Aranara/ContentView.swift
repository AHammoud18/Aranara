//
//  ContentView.swift
//  Aranara
//
//  Created by Ali Hamoud on 10/1/22.
//

import SwiftUI

struct ContentView: View {
    @State var moveY = false
    var body: some View {
        ZStack{
            Ararycan
                .offset(y: moveY ? -20 : 0)
                .onTapGesture(){
                    withAnimation(.easeInOut(duration: 2).repeatForever()){
                        moveY.toggle()
                    }
                }

        }
    }
}

var Ararycan : some View{
    Image("Ararycan")
        .resizable()
        .padding()
        .frame(width: 325, height: 325)
        .offset(x:-250, y:0)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .ignoresSafeArea(.all)
            .previewInterfaceOrientation(   .landscapeLeft)
    }
}
