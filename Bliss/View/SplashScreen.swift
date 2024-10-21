//
//  SplashScreen .swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-24.
//

import SwiftUI

struct SplashScreen: View {
    
    //Animation Properties...
    @State var startAnimation = false
    @State var bowAnimation = false
    @State var isFinished = false
    
    //Glow Animatino
    @State var glow = false
    var body: some View {
        HStack{
            if !isFinished {
                ZStack{
                    Color("BG")
                        .ignoresSafeArea()
                    
                    
                    //Bliss Logo..
                    GeometryReader{proxy in
                        
                        //For Screeen Size
                        let size = proxy.size
                        
                        ZStack{
                            Rectangle()
                            //Trimming
                                .trim(from: 0, to: bowAnimation ? 1 : 0)
                                .stroke(
                                //Gradiant
                                    .linearGradient(.init(colors: [
                                        Color.black
                                    ]), startPoint: .leading, endPoint: .trailing)
                                    
                                    ,style: StrokeStyle(lineWidth: 5,lineCap: .round,lineJoin: .round)
                                )
                                .frame(width: size.width / 1.1, height: size.width / 1.1)
                                .overlay(
                                    //Glow Circle...
                                    Circle()
                                        .fill(Color.black.opacity(1))
                                        .frame(width: 5, height: 5)
                                        .overlay(
                                            Circle()
                                                .fill(Color.white.opacity(glow ? 0.2 : 0))
                                                .frame(width: 20, height: 20)
                                        )
                                        .blur(radius: 2.5)
                                    
                                    //moving towords left...
                                        .offset(x: (size.width / 2) / 2)
                                    //moving towords blow...
                                        .rotationEffect(.init(degrees: bowAnimation ? 180 : 0))
                                        .opacity(startAnimation
                                                 ? 1: 0)
                                )
                                .frame(width: size.width / 2, height: size.width / 2)
                                .rotationEffect(.init(degrees: 0))
                                .offset(y: 10)
                            
                            HStack(spacing: -20){
                                Image("blissbanner")
                                   // .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: size.width/1.2, height: size.width/1.2)
                                    .opacity(bowAnimation ? 1: 0)
                                
                                //flowers Image...
//                                Image("flowers")
//                                    //.renderingMode(.template)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 80, height: 80)
                                
                            }
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
                .onAppear(){
                    //Delaying 0.3S...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        withAnimation(.linear(duration: 2)){
                            bowAnimation.toggle()
                        }
                        
                        //Glow Animation...
                        withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)){
                            glow.toggle()
                        }
            
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                            withAnimation(.spring()){
                                startAnimation.toggle()
                            }
                        }
                        
                        //hiding glow befor hitting plus ..
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.spring()){
                                startAnimation.toggle()
                            }
                        }
                        
                        //After 0.4 finishing splash animation...
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation{
                                isFinished.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
