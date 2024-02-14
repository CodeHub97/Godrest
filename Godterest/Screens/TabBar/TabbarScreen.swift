//
//  TabbarScreen.swift
//  Godterest
//
//  Created by Varjeet Singh on 11/09/23.
//

import SwiftUI

struct TabbarScreen: View {
  @State var selectedTab = 0
  @Environment(\.colorScheme) var colorScheme
  @State var selectedcolorScheme:ColorScheme = .dark

    var body: some View {
      TabView(selection: $selectedTab) {

        HomePage().tabItem {
                        VStack{

                          Image("House")
                          Text("Home")
                        }
                      }.tag(0)

              Matched()
                      .tabItem {

                        VStack{

                          Image("Hearty")
                          Text("Match")
                        }
                      }.tag(1)

        ChatScreen(selectedTab: $selectedTab)
                      .tabItem {

                        VStack{

                          Image("message")
                          Text("Chat")
                        }
                      }.tag(2)
        ProfileSetting()
                      .tabItem {

                        VStack{

                          Image("Usery")
                          Text("Profile")
                        }
                      }.tag(3)
      }.foregroundStyle(LinearGradient(colors: [Color.red,Color.green], startPoint: .leading, endPoint: .trailing))
        .accentColor(Color.red)
        .navigationBarBackButtonHidden(true)
        .background(Material.ultraThinMaterial.opacity(0.5))

    }
}

struct TabbarScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabbarScreen()
    }
}
