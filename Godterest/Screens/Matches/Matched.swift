//
//  Matched.swift
//  Godterest
//
//  Created by Varjeet Singh on 18/09/23.
//

import SwiftUI

enum ButtonType : CaseIterable {
case All
case Recent
case New

  var stringValue: String {
         switch self {
         case .All:
             return "All"
         case .Recent:
             return "Recent"
         case .New:
             return "New"
         }
     }
}
struct Matched: View {
  @State  var selectedButton: ButtonType = .All
  @ObservedObject var MatchedViewModel = MatchedVM()
  @EnvironmentObject var ColorschemeViewModel:ColorSchemeVM

  init(){
    MatchedViewModel.HitAllMatchedList(type: "Liked")
  }

    var body: some View {
      VStack{
//        TOP TITLE
        AddText(TextString: "Matches", TextSize: 25,FontWeight: .medium).padding(.leading)

//        ALL BUTTONS TOP
        HStack{
          ForEach(ButtonType.allCases, id: \.self) { buttonTypee in
            Button {
              selectedButton = buttonTypee
               print(buttonTypee)
              MatchedViewModel.HitAllMatchedList(type: selectedButton.stringValue)
            } label: {
              Text(buttonTypee.stringValue).foregroundColor(selectedButton == buttonTypee ? .white :  .black)
                .frame(width: 100)
                .padding(.vertical,10)
                .background(
                  ZStack{
                    if selectedButton == buttonTypee{
                      Capsule().gradientText(colors: [Color("App Red"), Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
                    }else{
                      Capsule().stroke().gradientText(colors: [Color("App Red"), Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
                    }
                  }


                )
            }

          }
          Spacer()
        }.padding(.horizontal)

        if MatchedViewModel.allMatchedProfiles.isEmpty{
            VStack{
                Spacer()
                Image("img_noMatches")
                Text("No matches yet.")
                    .fontWeight(.bold).foregroundColor(Color.primary).font(.custom("Avenir", size: 25))
                Text("With a little faith and patience the right one will comein God's perfect timing!")
                    .fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 16))
                    .frame(maxWidth: 250,alignment: .center)
                    .multilineTextAlignment(.center)
                Spacer()
                Spacer()
            }.frame(maxHeight: .infinity,alignment: .center)
        }else{

          ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: 200)),GridItem(.flexible()),]) {
              ForEach(0..<MatchedViewModel.allMatchedProfiles.count , id:\.self){index in
                NavigationLink {
                  ProfileDetails(UserProfile: MatchedViewModel.allMatchedProfiles[index],OtherPics: MatchedViewModel.allMatchedProfiles[index].otherPic?.components(separatedBy: ",") ?? [])
                } label: {
                  ZStack(alignment: .top){
                    GeometryReader { geometry in
                      Rectangle().foregroundColor(.white)
                      AsyncImage(
                        url: URL(string: APIConstants.s3BucketUrl +  (MatchedViewModel.allMatchedProfiles[index].profilePic ?? ""))
                      ) { image in
                        image
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: geometry.size.width , height: geometry.size.height)
                          .overlay{
                            LinearGradient(colors: [Color.clear,Color.clear,Color.black.opacity(0.2),Color.black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                          }
                      } placeholder: {
                        Image(MatchedViewModel.allMatchedProfiles[index].gender == "Female" ? "FemalePlaceholder" : "MalePlaceholder")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: geometry.size.width , height: geometry.size.height)
                          .overlay{
                            LinearGradient(colors: [Color.clear,Color.clear,Color.black.opacity(0.2),Color.black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                          }
                          .overlay {
                            ProgressView()
                          }
                      }
                    }
                    .frame(height: UIScreen.main.bounds.height/3.5)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.5)).overlay{
                      VStack(alignment: .leading, spacing: 0){
                        AddText(TextString: MatchedViewModel.allMatchedProfiles[index].name ?? "", TextSize: 16,Color: Color.white, FontWeight: .bold, Alignment: .center)
                        HStack(spacing: 2) {
                          Image("globe").resizable().renderingMode(.template).frame(width: 10, height: 10).foregroundColor(.white)
                            AddText(TextString: "\(MatchedViewModel.allMatchedProfiles[index].address?.city ?? "LAKESIDE") • 12 Miles AWAY", TextSize: 10,Color: Color.white,FontWeight: .bold).lineLimit(1).minimumScaleFactor(0.2)
                          Spacer()
                          
                        }.padding(.leading)
//                        AddText(TextString: "10 MIN AGO", TextSize: 10,Color: Color.white,FontWeight: .medium, Alignment: .center)
                      }
                      .overlay{
//                        VStack {
//                          Image("Heart small")
//                        }.frame(width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.height/11, alignment: .topLeading)
                      }
                    }.frame(width: UIScreen.main.bounds.width/2.5 ,height: UIScreen.main.bounds.height/11.5).frame(maxHeight: .infinity,alignment: .bottom).offset(y: UIScreen.main.bounds.height * -2/90)
                    
                  }.frame( height: UIScreen.main.bounds.height/3)
                }

              }
            }


          }.padding(.all)

        }
        Spacer()
      }.onAppear{
                MatchedViewModel.HitAllMatchedList(type: selectedButton.stringValue)
      }
    }
    
    func getIMageUrl() {
        
    }
}

struct Matched_Previews: PreviewProvider {
    static var previews: some View {
        Matched()
    }
}
