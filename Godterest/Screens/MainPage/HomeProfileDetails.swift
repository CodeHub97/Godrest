//
//  HomeProfileDetails.swift
//  Godterest
//
//  Created by Varjeet Singh on 25/09/23.
//

import SwiftUI

struct HomeProfileDetails: View {

  @ObservedObject var MatchedViewModel = MatchedVM()
  @State var UserProfileHomepage : ProfileDatum?
  @State var ShowImage = false
  @State var Hobbies:[String] = []
  func getAge(dateString:String) -> Int{
    let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let birthdate = dateFormatter.date(from: dateString) else {
                return 0
            }

            let age = Calendar.current.dateComponents([.year], from: birthdate, to: Date()).year ?? 0
    return age
  }

  func getValueForCurrentDevice(type:String) -> Double {


      let currentHeight = UIScreen.main.nativeBounds.height
      let currentModel = iPhoneModel.allCases.first { $0.physicalHeight == Double(currentHeight) }
      let value: Double
    print("currentModel is: ",currentModel,"Current Height is: ",currentHeight)
      switch currentModel?.physicalHeight {
      case 2796.0: value = type == "Fonts" ? 15 : 5       //Iphone 14 Pro max
      case 2778.0: value = type == "Fonts" ? 15 : 4.5
      case 2688.0: value = type == "Fonts" ? 14 : 4.5      //Iphone 11 Pro max
      case 2556.0: value = type == "Fonts" ? 12 : 5        //Iphone 14 Pro
      case 2532.0: value = type == "Fonts" ? 12 : 4.5
      case 2436.0: value = type == "Fonts" ? 12 : 4.5
      case 2340.0: value = type == "Fonts" ? 12 : 4.5
      case 1334.0: value = type == "Fonts" ? 12 : 4         //Iphone 8
      case 1136.0: value = type == "Fonts" ? 12 : 3.5
      case 480.0: value = type == "Fonts" ? 10 : 2
      default: value = type == "Fonts" ? 14 : 0
      }
      print("value for device is :",value)
    return Double(value)
  }





@State var OtherPics :[String] = [ "https://images.unsplash.com/photo-1527736947477-2790e28f3443?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1962&q=80","https://images.unsplash.com/photo-1536811145290-bc394643e51e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2127&q=80","https://images.unsplash.com/photo-1520694977332-9122aa8e8b7a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2127&q=80"]

var body: some View {
  VStack{
    ZStack(alignment: .center) {
      BackButton()
      AddText(TextString: UserProfileHomepage?.name ?? "Name", TextSize: 20,FontWeight: .medium,Alignment: .center)
      AddText(TextString: "\(getAge(dateString: UserProfileHomepage?.dob ?? ""))", TextSize: 20,FontWeight: .medium,Alignment: .trailing).padding(.trailing)
    }.padding(.top)
    ScrollView {
      VStack {


        ZStack (alignment: .bottom){
          if let url = URL(string:
                            APIConstants.s3BucketUrl + (UserProfileHomepage?.profilePic ?? "")) {
            AsyncImage(url: url) { phase in
              if let image = phase.image {
                image
                  .resizable()
                  .scaledToFill()
                  .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height/2.2, alignment: .center)
                  .cornerRadius(20)

                  .padding(30)

              }else{
                Image(UserProfileHomepage?.gender == "Female" ? "FemalePlaceholder" : "MalePlaceholder")
                  .resizable()
                  .scaledToFill()
                  .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height/2.2, alignment: .center)
                  .background(Rectangle().foregroundColor(.gray).opacity(0.5))
                  .cornerRadius(20)
                  .padding(30)
                  .overlay {
                    ProgressView()
                  }
              }
            }
          }

          VStack(alignment: .leading, spacing: 10){
            AddText(TextString: UserProfileHomepage?.name ?? "Lorea", TextSize: getValueForCurrentDevice(type: "Fonts") + 13,Color: Color.white,FontWeight: .bold, Alignment: .leading,FontFamily: "Grandista").shadow(color: .black.opacity(0.5), radius: 4, x: 1, y: 0.5)
            HStack {
              Image("globe").resizable().frame(width: 15, height: 15)
              AddText(TextString: "\(UserProfileHomepage?.address?.city ?? "LAKESIDE") • 20 KMS AWAY", TextSize: getValueForCurrentDevice(type: "Fonts") + 4,Color: Color.white,FontWeight: .medium).shadow(color: .black.opacity(0.5), radius: 4, x: 1, y: 0.5)

              Spacer() 
            }

            HStack {
              CapsuleLabelSmall(imagename: "suitcase", Title: UserProfileHomepage?.profession ?? "Designer",Color: Color.white,FontSize: getValueForCurrentDevice(type: "Fonts"))
              CapsuleLabelSmall(imagename: "Denominater", Title: UserProfileHomepage?.denomination ?? "Moderately Practicing",Color: Color.white,FontSize: getValueForCurrentDevice(type: "Fonts"))

              Spacer()

            }
            CapsuleLabelSmall(imagename: "Canada", Title: "Canada",Color: Color.white,FontSize: 13)
            Spacer()
          }
          .padding(.top, 20)
          .offset(x: 20)
          .frame( width: UIScreen.main.bounds.width / 1.2   , height: UIScreen.main.bounds.height / getValueForCurrentDevice(type: "Height"), alignment: .center)
          .background(RoundedRectangle(cornerRadius: 20).fill(Material.ultraThinMaterial))
        }



        VStack(spacing: 10) {
          AddText(TextString: "About Me", TextSize: getValueForCurrentDevice(type: "Fonts") + 8,Color: Color.black,FontWeight: .bold)
          HStack {

            VStack(alignment: .leading) {
              AddText(TextString: "Height", TextSize: 12,FontWeight: .medium)
              CapsuleLabel(imagename: "height", Title: UserProfileHomepage?.tall ?? "157 cm ( 5.3 )",FontSize: getValueForCurrentDevice(type: "Fonts") )
            }

            VStack(alignment: .trailing) {
              AddText(TextString: "Marital Status", TextSize: 12,FontWeight: .medium,Alignment: .trailing)
              CapsuleLabel(imagename: "rings", Title: UserProfileHomepage?.maritalStatus ?? "Never  Married",FontSize: getValueForCurrentDevice(type: "Fonts") )
            }


            Spacer()
          }
          HStack {
            VStack(alignment: .leading) {
              AddText(TextString: "Have Kids", TextSize: 12,FontWeight: .medium)
              CapsuleLabel(imagename: "children", Title: UserProfileHomepage?.children ?? "Doesn't have kids",FontSize: getValueForCurrentDevice(type: "Fonts") )
            }
            VStack(alignment: .trailing) {
              AddText(TextString: "Want Kids", TextSize: 12,FontWeight: .medium,Alignment: .trailing)
              CapsuleLabel(imagename: "diamond", Title: UserProfileHomepage?.childrenInFuture ?? "Yes",FontSize: getValueForCurrentDevice(type: "Fonts") )
            }

            Spacer()

          }
        }.padding(.horizontal, 30)


        VStack(spacing: 10) {
          AddText(TextString: "Hobbies", TextSize: getValueForCurrentDevice(type: "Fonts") + 8,Color: Color.black,FontWeight: .bold)
          HStack {
            ForEach(Hobbies,id: \.self) { hobby in
              CapsuleLabelWithoutImage(imagename: "language", Title:hobby ,FontSize: getValueForCurrentDevice(type: "Fonts") )
            }

            Spacer()
          }
        }.padding(.all, 30)

        VStack(spacing: 10) {
          AddText(TextString: "Other Pics", TextSize: getValueForCurrentDevice(type: "Fonts") + 8,Color: Color.black,FontWeight: .bold)


          LazyVGrid(columns: [
            GridItem(.flexible(),spacing: 20),
            GridItem(.flexible(),spacing: 20),
            GridItem(.flexible(),spacing: 20)
          ],spacing: 30) {
            ForEach(0..<OtherPics.count, id: \.self) { index in
              let image = OtherPics[index]
              if let url = URL(string: APIConstants.s3BucketUrl + image) {
                AsyncImage(url: url) { phase in
                  if let image = phase.image {
                    image
                      .resizable()
                      .scaledToFill()
                      .frame(width: 100, height: 100)
                      .mask(RoundedRectangle(cornerRadius: 20))
                      .frame(width: 100, height: 100)
                      .onTapGesture {
                        ShowImage.toggle()
                      }
                  } else { 
                    Image(UserProfileHomepage?.gender == "Female" ? "FemalePlaceholder" : "MalePlaceholder")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 100, height: 100)
                      .mask(RoundedRectangle(cornerRadius: 20))
                      .frame(width: 100, height: 100)

                  }
                }
                  .navigationDestination(isPresented: $ShowImage) {
                    ZoomImage(SelectedImage: index, Gender: UserProfileHomepage?.gender ?? "Male", ShowImages: OtherPics)
                  }.tag(index)
              }

            }

          }.padding(.all,20)

        }.padding(.horizontal, 30)

      }
    }
  }.navigationBarBackButtonHidden(true)
    .onAppear{
      getValueForCurrentDevice(type: "Height")
      Hobbies = UserProfileHomepage?.hobbies?.components(separatedBy: ",") ?? ["Travelling","Gym"]
    }
}



}

struct HomeProfileDetails_Previews: PreviewProvider {
    static var previews: some View {
        HomeProfileDetails()
    }
}
