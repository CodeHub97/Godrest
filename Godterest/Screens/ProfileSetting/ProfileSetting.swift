//
//  ProfileSetting.swift
//  Godterest
//
//  Created by Varjeet Singh on 13/09/23.
//

import SwiftUI

struct ProfileSetting: View {

  @State var isLogout = false
  @State var SafetyDatingLinkOpen = false
  @State var ContactsupportLinkOpen = false
  @State private var isAnimating = false
  @EnvironmentObject var CreateAccountVM : QuestionsVM
    var body: some View {
      VStack(alignment: .leading){
          
          AddText(TextString: "Profile Setting", TextSize: 20,FontWeight: .medium,Alignment: .center).padding(.top)


        Divider().offset(y: 7)
        ScrollView{

          AddText(TextString: "General", TextSize: 18,Color: Color.black,FontWeight: .medium).padding(.leading,30).padding(.top)

          NavigationLink {
            EditProfileScreen()
          } label: {
            SettingRow(ImageUse: "Share", Title: "Edit Your Profile").background{
              RoundedRectangle(cornerRadius: 20).foregroundColor(.gray.opacity(0.1)).frame(height: 60)

            }.padding(.horizontal ,30)
          }

          VStack(spacing: 0) {

            NavigationLink {
              Delete_Account()
            } label: {
              SettingRow(ImageUse: "Settinger", Title: "Check Your Settings")
            }
            Divider()
            SettingRow(ImageUse: "Warninger", Title: "Safety Dating Tips").onTapGesture {
              SafetyDatingLinkOpen.toggle()
            }.navigationDestination(isPresented: $SafetyDatingLinkOpen, destination: {
              WebViewContainer(urlString: "https://godterest.com/safety-dating-tips/")
            })
            Divider()
            SettingRow(ImageUse: "Chatter", Title: "Contact support").onTapGesture {
              ContactsupportLinkOpen.toggle()
            }.navigationDestination(isPresented: $ContactsupportLinkOpen, destination: {
              WebViewContainer(urlString: "https://godterest.com/support/")
            })
          }.background{
            RoundedRectangle(cornerRadius: 20).foregroundColor(.gray.opacity(0.1))

          }.padding(30)


          HStack{
            Image("Exporter").resizable().renderingMode(.template).gradientText(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing).scaledToFit().frame(height: 25).padding(10)
            VStack(alignment: .leading) {
              AddText(TextString: "Invite Friends and tell your church :)", TextSize: 15,FontWeight: .regular)
              Text("Paying it forward helps us forward are mission of bringing love to the world.").font(.custom("Avenir", size: 15)).foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing))
            }
            Spacer()
          }.padding(.vertical).background{
            RoundedRectangle(cornerRadius: 20).foregroundColor(.gray.opacity(0.1))

          }.padding(30)


          SettingRow(ImageUse: "power-off", Title: "Sign Out")
            .background(
              RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.gray.opacity(0.1))
                .frame(height: 60)
            )
            .padding(.horizontal, 30)
            .scaleEffect(isAnimating ? 0.8 : 1.0)
            .animation(Animation.spring(response: 0.3,dampingFraction: 0.2), value: isAnimating)
            .onTapGesture {
              withAnimation {
                isAnimating.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  UserSettings.shared.clearLoginData()
                  isLogout.toggle()
                }
              }
            }
            .navigationDestination(isPresented: $isLogout) {
              ContentView(SplashDone: true, hasRunOnce: true)
            }
          Spacer(minLength: 50)
        }
      }
    }
}

struct ProfileSetting_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetting()
    }
}

struct SettingRow: View {
  var ImageUse:String
  var Title:String

  var body: some View {
    HStack{
      Image(ImageUse).resizable().renderingMode(.template).gradientText(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing).scaledToFit().frame(height: 25)
      AddText(TextString: Title, TextSize: 15,Color: Color.black, FontWeight: .regular)
      Spacer()
    }.padding(.vertical,10)
      .padding(.leading,10)
  }
}
