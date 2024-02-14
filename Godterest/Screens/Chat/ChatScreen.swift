//
//  ChatScreen.swift
//  Godterest
//
//  Created by Varjeet Singh on 13/09/23.
//

import SwiftUI

struct ChatScreen: View {
  @Binding var selectedTab:Int
  @State var ShowToastBadge: Bool = false
  @State var showback: Bool = false
    var body: some View {
      VStack {

        ZStack{
          if showback{
            BackButton()
          }
          AddText(TextString: "Chat", TextSize: 20,Color: .black,FontWeight: .medium,Alignment:.center)
        }
        Spacer().frame(height: 30)

//        AddText(TextString: "Wed 8:21 AM", TextSize: 14,Color: Color.gray).padding(.horizontal)
//        HStack{
//          Image("Logo").resizable().scaledToFit().frame(height: 30).background{
//            Circle().foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)).frame(height: 120)
//          }.padding()
//          VStack(alignment: .leading){
//            HStack {
//              AddText(TextString: "Godterest Verification", TextSize: 18,Color: .black,FontWeight: .medium)
//              Image("verifier").frame(width: 15, height: 20)
//            }
//            AddText(TextString: "It's time for Christians to change the narrative.. (links to blog)", TextSize: 16,Color: Color.gray).lineLimit(2)
//          }
////          Text("+59").font(.custom("Avenir", size: 18)).fontWeight(.medium).foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)).frame(width: 50, height: 30, alignment: .center).background{
////            Capsule().stroke().foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)).frame(width: 50, height: 30, alignment: .center)
////          }
//          Spacer()
//        }.background{
//          RoundedRectangle(cornerRadius: 20).foregroundColor(.gray.opacity(0.1)).frame(height: 120)
//        }.padding()
//          .onTapGesture {
//            print("Coming Soon")
//            ShowToastBadge.toggle()
//          }


        Spacer()
        VStack(alignment: .center) {
          AddText(TextString: "This is where you will meet your future spouse.", TextSize: 20,Color: .black,FontWeight: .medium,Alignment:.center)
          AddText(TextString: "Connect with someone special and let God handle the details.", TextSize: 16,Color: Color.gray,Alignment:.center)
        }.padding(40).multilineTextAlignment(.center)
        CustomButton2(ButtonType: "Find a match", action:
                        {
          selectedTab = 0
        }).padding()
        Spacer()
      }
      .background(Color.white)
      .toast(isPresenting: $ShowToastBadge){
        AlertToast(displayMode: AlertToast.DisplayMode.hud, type: .regular, title: "Coming Soon...")


      }.navigationBarBackButtonHidden()
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
      ChatScreen(selectedTab: .constant(2))
    }
}
