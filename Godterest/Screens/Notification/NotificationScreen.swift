//
//  NotificationScreen.swift
//  Godterest
//
//  Created by Varjeet Singh on 11/09/23.
//

import SwiftUI

struct NotificationScreen: View {
  var randomColors: [Color] {
          (0..<10).map { _ in
              Color(
                  red: Double.random(in: 0..<1),
                  green: Double.random(in: 0..<1),
                  blue: Double.random(in: 0..<1)
              )
          }
      }
    var body: some View {
      VStack {

        AddText(TextString: "Notifications", TextSize: 20,FontWeight: .medium).frame(maxWidth: .infinity,alignment: .center).padding(.top)

        List(0..<6) { index in
          NotificationRow(color: randomColors[index])

        }.listStyle(.plain)

        Spacer()
      }
    }
}

struct NotificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationScreen()
    }
}


struct NotificationRow: View {
  var color:Color
  var body: some View {
    HStack{
      Circle().frame(width: 60, height: 60).foregroundColor(color).overlay{
        Image(systemName: "heart").font(.system(size: 25)).foregroundColor(.white)
      }
      VStack{
        AddText(TextString: "🔔 New Notification: Huma Liked Your Photo 📸", TextSize: 15,FontWeight: .regular).frame(maxWidth: .infinity,alignment: .leading)
        AddText(TextString: "2 min ago", TextSize: 12,Color: .gray, FontWeight: .regular).frame(maxWidth: .infinity,alignment: .leading)
      }
    }
  }
}
