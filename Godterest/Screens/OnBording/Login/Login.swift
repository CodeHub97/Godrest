//
//  Login.swift
//  Godterest
//
//  Created by Varjeet Singh on 08/09/23.
//

import SwiftUI

struct Login: View {

  @ObservedObject var ViewModel = QuestionsVM()
  @State var TermsPolicyLinkOpen = false
    var body: some View {
      ZStack(alignment: .top){

        Image("Login Back").resizable().ignoresSafeArea()
        Color.black.mask(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.8), .black.opacity(0.3)]), startPoint: .bottom, endPoint: .top)).ignoresSafeArea()

        VStack {
          Text("Dating God's Way").fontWeight(.medium).foregroundColor(Color.white).padding(.top,50).font(.custom("Avenir", size: 20))
          Spacer()
//          Text("Continue with").fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 18))

//          VStack(spacing: 20) {
//            LoginButtons(imagename: "Apple Logo", ButtonType: "Continue with Apple", actioner: {
//              print("Apple")
//              ViewModel.HitCreateAccount()
//            })
//            LoginButtons(imagename: "Google Logo", ButtonType: "Continue with Google", actioner: {
//              print("Google")
//            })
//            LoginButtons(imagename: "Facebook Logo", ButtonType: "Continue with Facebook" ,actioner: {
//              print("Facebook")
//            })
//          }

          NavigationLink {
            LoginID()
          } label: {
            Text("Sign In").fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 20))
          }.padding()


          HStack {
            Text("By continuing you agree to our ").fontWeight(.medium).font(.custom("Avenir", size: 15)).foregroundColor(.white) +
            Text("Terms and Privacy Policy.").fontWeight(.medium).font(.custom("Avenir", size: 15)).underline().foregroundColor(.white)

          }.onTapGesture {
            TermsPolicyLinkOpen.toggle()
          }.navigationDestination(isPresented: $TermsPolicyLinkOpen, destination: {
            WebViewContainer(urlString: "https://godterest.com/terms-and-conditions/")
          })
.padding(.horizontal,40)
            .padding(.bottom,40)
        }
      }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonOnboarding(ButtonTitle: "qwe", ButtonType: .Name).environmentObject(QuestionsVM())
    }
}

struct LoginButtons: View {
  @State var imagename:String
  @State var ButtonType:String
  var actioner: () -> Void
  var body: some View {
    Button {
      self.actioner()
    } label: {
      HStack{
        Spacer()
        Image(imagename).frame(width: 25, height: 25, alignment: .center)
        Text(ButtonType).fontWeight(.medium).foregroundColor(Color.black).font(.custom("Avenir", size: 18))
        Spacer()
      }.frame( height: 60, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 50)).foregroundColor(.white).padding(.horizontal,30)

    }
  }
}

enum ButtonTypes {
  case Email
  case Name
  case dateofBirth
  case GenderSelect
  case Hobbies
  case SelectedProfession
  case SelectedDenomination
  case SelectedHeight
  case ProfilePic
  case OtherPics
  case SelectedSmokeHabit
  case SelectedDrinkHabit
  case SelectedHaveChildren
  case SelectedWantChildren
  case SelectedMaritalStatues
  case SelectedEthnic
  case SelectedEthnicOrigins
  case SelectedEducation
  case Bio
case mobileNumber
    case verify
    case otp
}


struct CustomButton: View {
    @State var ButtonTitle:String
    @State var ButtonType:ButtonTypes
    @State var View = AnyView(NameView())
    @State var fontSize: Int = 18
    @EnvironmentObject var CreateAccountVM: QuestionsVM
   
    private var isDisabled: Bool {
        switch ButtonType {
        case .Email:
            return !Validation.isEmailValid(CreateAccountVM.Email) || !Validation.isPasswordValid(CreateAccountVM.Password) || CreateAccountVM.Password != CreateAccountVM.ConfirmPassword
        case .Name:
            return CreateAccountVM.Name.isEmpty
        case .dateofBirth:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let dateComponents = Calendar.current.dateComponents([.year], from: CreateAccountVM.dateofBirth, to: Date())
            
            return dateComponents.year ?? 0 < 18
        case .ProfilePic:
            return CreateAccountVM.SelectedProfileUIImage.size == .zero
        case .OtherPics:
            return CreateAccountVM.images == nil || CreateAccountVM.images.isEmpty
        case .Hobbies:
            return CreateAccountVM.selectedHobbiesArray.count < 4
        case .mobileNumber:
          return CreateAccountVM.mobileNumber.count < 10 
        case .otp:
            return CreateAccountVM.otp.count < 4
        default:
            return false
        }
    }
    
    var body: some View {
        NavigationLink {
            View.navigationBarBackButtonHidden()
          
        } label: {
            HStack{
                Spacer()
                Text(ButtonTitle).fontWeight(.bold).foregroundColor(Color.white).font(.custom("Avenir", size: CGFloat(fontSize)))
                Spacer()
            }.frame( height: 60, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 10)).foregroundStyle(LinearGradient(colors: [ !(isDisabled ?? false) ? Color("App Red"): Color.gray , !(isDisabled ?? false) ? Color("App Yellow")  : Color.gray
                                                                                                       ], startPoint: .leading, endPoint: .trailing)
                )
        }.disabled(isDisabled)
        
    }
}

struct CustomButton3: View {
  
  @State var ButtonTitle:String
  @State var ButtonType:ButtonTypes
  @State var fontSize: Int = 18
  @EnvironmentObject var CreateAccountVM: QuestionsVM
    
 
  private var isDisabled: Bool {
      switch ButtonType {
      case .Email:
          return !Validation.isEmailValid(CreateAccountVM.Email) || !Validation.isPasswordValid(CreateAccountVM.Password) || CreateAccountVM.Password != CreateAccountVM.ConfirmPassword
      case .Name:
          return CreateAccountVM.Name.isEmpty
      case .dateofBirth:
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
          
          let dateComponents = Calendar.current.dateComponents([.year], from: CreateAccountVM.dateofBirth, to: Date())
          
          return dateComponents.year ?? 0 < 18
      case .ProfilePic:
          return CreateAccountVM.SelectedProfileUIImage.size == .zero
      case .OtherPics:
          return CreateAccountVM.images == nil || CreateAccountVM.images.isEmpty
      case .Hobbies:
          return CreateAccountVM.selectedHobbiesArray.count < 4
      case .mobileNumber:
        return CreateAccountVM.mobileNumber.count < 10
      case .otp:
          return CreateAccountVM.otp.count < 6
      default:
          return false
      }
  }
  

  var action:() -> Void
  var body: some View {
    Button {
      action()
    } label: {
      HStack{
        Spacer()
        Text(ButtonTitle)
          .fontWeight(.medium)
          .foregroundColor(Color.white)
          .font(.custom("Avenir", size: CGFloat(fontSize)))
       
        Spacer()
      }.frame( height: 60, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 10)).foregroundStyle(LinearGradient(colors: [ !(isDisabled ?? false) ? Color("App Red"): Color.gray , !(isDisabled ?? false) ? Color("App Yellow")  : Color.gray
                                                                                               ], startPoint: .leading, endPoint: .trailing)
        )
    }
  }
}





struct CustomButton2: View {
  @State var ButtonType:String
  var action:() -> Void
  var body: some View {
    Button {
      action()
    } label: {
      HStack{
        Spacer()
        Text(ButtonType).fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
        Spacer()
      }.frame( height: 60, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 10)).foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
        )
    }


  }
}


struct CustomButtonOnboarding: View {
    @State var ButtonTitle:String
    @State var ButtonType:ButtonTypes
    @State var View = AnyView(NameView())
    @EnvironmentObject var CreateAccountVM: QuestionsVM



    private var isDisabled: Bool {
            switch ButtonType {
            case .Email:
                return !Validation.isEmailValid(CreateAccountVM.Email) || !Validation.isPasswordValid(CreateAccountVM.Password) || CreateAccountVM.Password != CreateAccountVM.ConfirmPassword
            case .Name:
                return CreateAccountVM.Name.isEmpty
            case .dateofBirth:
              let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"

                        let dateComponents = Calendar.current.dateComponents([.year], from: CreateAccountVM.dateofBirth, to: Date())

                        return dateComponents.year ?? 0 < 18
            case .ProfilePic:
              return CreateAccountVM.SelectedProfileUIImage.size == .zero
            case .OtherPics:
              return CreateAccountVM.images == nil || CreateAccountVM.images.isEmpty
            case .Hobbies:
              return CreateAccountVM.selectedHobbiesArray.count < 4
            default:
               return false
             }
        }

    var body: some View {
      NavigationLink {
        View.navigationBarBackButtonHidden()
      } label: {
        HStack{
          Spacer()
          Text(ButtonTitle).fontWeight(.bold).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
          Spacer()
        }.frame( height: 60, alignment: .center)
              .background(RoundedRectangle(cornerRadius: 30)).foregroundStyle(LinearGradient(colors: [ !(isDisabled ) ? Color.black: Color.gray , !(isDisabled ) ? Color.black  : Color.gray
          ], startPoint: .leading, endPoint: .trailing)
          )
      }.disabled(isDisabled)

    }
}


