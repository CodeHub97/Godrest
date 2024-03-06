//
//  DonationVC.swift
//  Godterest
//
//  Created by Sandip Gill on 20/12/23.
//

import SwiftUI

struct DonationVC: View {
    var body: some View {
        VStack {
            ZStack {
                NavigationLink {
                    Login()
                  //LandingView()
                  
                  //  QuestionsViewNew()
                 
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Login").fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 20))
                    }
                }
                
            }.padding(.trailing,10)
                .padding(.top,30)
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(.top, 20)
            
            Image("heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 330, height: 330)
                .padding(.top,20)
                .overlay {
                    
                    Text("Thank you for choosing the Godterest app. While it's a work in progress, our passion and commitment to creating a meaningful platform for Christian dating remains unwavering. Please visit our website and support us by paying it forward. Your support at this stage is crucial, and we're excited to build something incredible together.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding()
                }
            
            // Link Below Text
            Button(action: {
                // Handle link action
            }) {
                Text("https://www.godterest.com")
                    .foregroundColor(.white)
            }
            .padding(.top, 15)
            Spacer()
            Image("couple")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(.bottom, 20)
        }
        .background(Image("bg", bundle: .main))
    }
}

struct DonationVC_Previews: PreviewProvider {
    static var previews: some View {
        DonationVC()
    }
}


//Login() 
