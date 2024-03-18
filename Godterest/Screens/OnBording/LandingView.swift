//
//  Login_new.swift
//  Godterest
//
//  Created by Gaganpreet Singh on 1/17/24.
//

import SwiftUI

struct LandingView: View {
  @EnvironmentObject var CreateAccountVM : QuestionsVM
  @State var TermsPolicyLinkOpen = false
  var body: some View {
    ZStack{
      Color(Color("Dark gray")).ignoresSafeArea()
      VStack(spacing: 30){
        AddText(TextString: "Holy", TextSize: 40, Color: Color("App Background"), Alignment: .center, FontFamily: "Grandista")
       
        VStack{
          AddText(TextString: "A humble, Chirst-honoring friends & dating app",
                  TextSize: 25,
                  Color: Color("App Background"),
                  FontWeight: .heavy).padding(30).frame(width: 260).multilineTextAlignment(.center)
    
        }
        
        VStack{
          Text("By continuing you agree to our ")
            .fontWeight(.regular).font(.custom("Avenir", size: 15))
            .foregroundColor(Color("App Background")) +
          Text("Terms of use")
            .fontWeight(.bold).font(.custom("Avenir", size: 15))
            .foregroundColor(Color("App Background")) +
          Text(" and ")
            .fontWeight(.regular).font(.custom("Avenir", size: 15))
            .foregroundColor(Color("App Background")) +
          Text("Privacy Policy")
            .fontWeight(.bold).font(.custom("Avenir", size: 15))
            .foregroundColor(Color("App Background"))
        }.frame(width: 250)
          .onTapGesture {
            TermsPolicyLinkOpen.toggle()
          }.navigationDestination(isPresented: $TermsPolicyLinkOpen, destination: {
            WebViewContainer(urlString: "https://godterest.com/terms-and-conditions/")
          })
        
        NavigationLink {
          NumberVerificationView()
        } label: {
          VStack {
            Text("Create account").frame(width: 300, height: 50).fontWeight(.heavy)
              .foregroundColor(Color.black).font(.custom("Avenir", size: 20))
              .background(Color("App Background")).cornerRadius(30)
          }
        }.padding(.bottom, -10)

        NavigationLink {
         LoginNew()
           // LoginID()
        } label: {
          Text("Sign in").frame(width: 200, height: 40).fontWeight(.heavy)
            .foregroundColor(Color("App Background")).font(.custom("Avenir", size: 20))
            .cornerRadius(30)
        }.padding()
  
      }.ignoresSafeArea().padding(.top, 200)
      
      
    }.background(Color("Dark gray"))
  }
}

#Preview {
  LandingView()
}
