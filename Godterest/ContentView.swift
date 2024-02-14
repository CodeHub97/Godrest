//
//  ContentView.swift
//  Godterest
//
//  Created by Varjeet Singh on 08/09/23.
//
import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {

  
  @State var Animation = false
  @State var SplashDone = false
  @State var hasRunOnce: Bool = false

    
  let scale: CGFloat = 1.5
    var body: some View {
        ZStack {
          Color.black.ignoresSafeArea()
          
            DonationVC()
                .opacity(!SplashDone ? 0 : 1)            
        
          Image("Logo Color")
              .resizable()
              .scaledToFit()
              .frame(width: UIScreen.main.bounds.width, alignment: .center)
              .opacity(SplashDone ? 0 : 1)
              .scaleEffect(SplashDone ? 0.8 : 0.4, anchor: .top) // Scale to top initially, then back to full size
              .offset(y: SplashDone ? 200 : 0) // Offset down initially, then back up
              .animation(
                  .interpolatingSpring(stiffness: 300, damping: 15) // Adjust stiffness and damping for slower effect
                      .delay(SplashDone ? 0.5 : 0) // Delay the animation after a certain duration
              )

        }.frame(width: UIScreen.main.bounds.width,height:  UIScreen.main.bounds.height,alignment: .center)
        .navigationBarBackButtonHidden(true)

        .padding()
        .onAppear {
          print("hasRunOnce",hasRunOnce)
              if !hasRunOnce {
                withAnimation {
                                    Animation.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5 , execute: {
                                    withAnimation(.easeIn(duration: 1)) {
                                        SplashDone.toggle()
                                    }
                                    hasRunOnce = true
                                })
                            }
          }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
