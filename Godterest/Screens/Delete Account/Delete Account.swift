//
//  Delete Account.swift
//  Godterest
//
//  Created by Varjeet Singh on 14/09/23.
//

import SwiftUI

struct Delete_Account: View {
  @State private var showDeleteAlert = false
  @State private var AlertType = "Delete"
  @ObservedObject var DeleteViewModel = MatchedVM()
    var body: some View {
      VStack{
        ZStack(alignment: .center) {
          BackButton()
          AddText(TextString: "Take a Break", TextSize: 18,FontWeight: .medium,Alignment: .center)
        }.padding(.top)
        AddText(TextString: "Need to take a Break? Don't worry, We’re got you Covered.", TextSize: 20)
          .padding(.horizontal, 20)
          .padding(.vertical, 10)

        VStack{
          AddText(TextString: "Deactivate Account", TextSize: 20,FontWeight: .bold).frame(maxWidth: .infinity,alignment:.leading)
          AddText(TextString: "Take your Profile Temporarily offline for everyone, including matches you can log back in at any time to restore your account", TextSize: 14).frame(maxWidth: .infinity,alignment:.leading)
        }.padding(.horizontal,20).padding(.vertical, 20)
          .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color("App Yellow").opacity(0.2))).padding(20)
          .overlay(alignment: .topTrailing) {
            Image("Deactivater").offset(x: -30, y: -5)
          }
          .onTapGesture {
            AlertType = "Deactivate"
            showDeleteAlert.toggle()
          }

        VStack{
          AddText(TextString: "Delete Account", TextSize: 20,FontWeight: .bold).frame(maxWidth: .infinity,alignment:.leading)
          AddText(TextString: "Permanently remove your account and delete your profile ,Photos and chats in line with our Privacy Policy", TextSize: 14).frame(maxWidth: .infinity,alignment:.leading)
        }.padding(.horizontal,20).padding(.vertical, 30)
          .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color("App Red").opacity(0.2))).padding(20)
          .overlay(alignment: .topTrailing) {
            Image("DeleteAccount").offset(x: -30, y: -5)
          }.onTapGesture {
            AlertType = "Delete"
            showDeleteAlert.toggle()
          }

        Spacer()
      }.overlay{
        if !DeleteViewModel.DeleteapiLoaded{
          ProgressView("Loading").padding(.horizontal , 80).padding(.vertical , 30).background(RoundedRectangle(cornerRadius: 20).fill(Material.ultraThinMaterial).opacity(0.7))
        }
        
    }
      .navigationBarBackButtonHidden(true)
      .toast(isPresenting: $DeleteViewModel.showToast){
        AlertToast(displayMode: AlertToast.DisplayMode.banner(.pop), type: .regular, title: DeleteViewModel.ErrorType.errorMessage)

      }
      .alert(isPresented: $showDeleteAlert) {
                 Alert(
                  title:AlertType != "Delete" ? Text("Attention") : Text("Warning") ,
                  message: Text(AlertType == "Delete" ? "Are you sure you want to delete your account permanently?" : "Are you sure you want to deactivate your account temporarily?"),
                     primaryButton: .destructive(Text("Yes")) {

                       if AlertType == "Delete"{
                         DeleteViewModel.HitDeleteorDeactivateAccount(type: "Delete")
                       }else{
                         DeleteViewModel.HitDeleteorDeactivateAccount(type: "Deactivate")
                       }

                     },
                     secondaryButton: .cancel(Text("No")) {

                         print("User tapped No")
                     }
                 )
             }
    }
}

struct Delete_Account_Previews: PreviewProvider {
    static var previews: some View {
        Delete_Account()
    }
}
