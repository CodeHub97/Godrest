//
//  GodterestApp.swift
//  Godterest
//
//  Created by Varjeet Singh on 08/09/23.
//

import SwiftUI

@main
struct GodterestApp: App {

  @State var ColorschemeViewModel = ColorSchemeVM()
  @State var CreateAccountViewModel = QuestionsVM()
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            ContentView()
                  .environment(\.isLoggedIn, false)
          }
          .environmentObject(ColorschemeViewModel)
          .environmentObject(CreateAccountViewModel) 
        }
    }
}
