//
//  QuestionsViewNew.swift
//  Godterest
//
//  Created by Bajrang Sinha on 17/01/24.
//

import SwiftUI

struct QuestionsViewNew: View {

  enum QuestionType {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
    case tenth
    case eleventh
    case twelvth
    case thirteen
  }

  @EnvironmentObject var CreateAccountVM : QuestionsVM
  @State private var selectedItem: Int?
  @State private var selectedQuestion = 1
  @State private var isAnimating = false
  @State var Gonext = true
  var questionType: QuestionType {
    switch selectedQuestion {
    case 1:
      return .first
    case 2:
      return .second
    case 3:
      return .third
    case 4:
      return .fourth
    case 5:
      return .fifth
    case 6:
      return .sixth
    case 7:
      return .seventh
    case 8:
      return .eighth
    case 9:
      return .ninth
    case 10:
      return .tenth
    case 11:
      return .eleventh
    case 12:
      return .twelvth
    case 13:
      return .thirteen
    default:
      return .first
    }
  }
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  var body: some View {

    VStack(alignment: .leading){

//      BACK BUTTON
      ZStack(alignment: .trailing) {
        HStack {
            Button {
              if selectedQuestion == 1{
                self.presentationMode.wrappedValue.dismiss()
              }else{
                isAnimating = true
                prevQuestion()
              }
            } label: {
                if selectedQuestion == 1{
                    Image(systemName: "chevron.left").font(.system(size: 20)).bold()
                }else {
                    Image(systemName: "xmark").font(.system(size: 20)).bold()
                }
            }.disabled(isAnimating)
          Spacer()
        }.foregroundColor(.primary).padding(.leading)
      }
      .padding(.bottom, 5.0)
      .background(Color("App Background"))
      switch questionType {
      case .first:

        FirstQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge:.bottom ))
          )
      case .second:
        SecondQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom ))
          )
      case .third:
        ThirdQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom ))
          )
      case .fourth:
        FourthQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge:.bottom ))
          )
      case .fifth:
        FifthQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
          )
      case .sixth:
        SixthQuestionNew(CreateAccountVM: CreateAccountVM)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
          )
      case .seventh:
        SeventhQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge:.bottom ))
          )
      case .eighth:
        EigthQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom ))
          )
      case .ninth:
        NinthQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
          )
      case .tenth:
        TenthQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge:.bottom ))
          )
      case .eleventh:
        EleventhQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge:.bottom))
          )
      case .twelvth:
          TwelveQuestionNewAdded(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
          ).onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
          }
      case .thirteen:
          TwelvthQuestionNew(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
            .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
            ).onTapGesture {
              UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
      }

      if selectedQuestion == 13{

        HStack{
          Spacer()
          Text("Submit").fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
          Spacer()
        }.frame( height: 60, alignment: .center)
          .background(RoundedRectangle(cornerRadius: 30)).foregroundStyle(LinearGradient(colors: [!shouldDisableNextButton() ? Color.black : Color.gray , !shouldDisableNextButton() ? Color.black : Color.gray ], startPoint: .leading, endPoint: .trailing)
          ).onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            CreateAccountVM.HitCreateAccount()
          }.navigationDestination(isPresented: $CreateAccountVM.SignupapiCompleted) {
            TabbarScreen()
          }.padding()
          .disabled(shouldDisableNextButton())

      }else{
        Button {
          isAnimating = true

          nextQuestion()
        } label: {
          HStack{
            Spacer()
            Text("Update").fontWeight(.bold).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
            Spacer()
          }.frame( height: 60, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 30)).foregroundStyle(LinearGradient(colors: [!shouldDisableNextButton() ? Color.black : Color.gray , !shouldDisableNextButton() ? Color.black : Color.gray ], startPoint: .leading, endPoint: .trailing)
            )
        }.padding()
          .disabled(isAnimating || shouldDisableNextButton())
      }

    }.navigationBarBackButtonHidden(true)
      .toast(isPresenting: $CreateAccountVM.showToast){
        AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title:  CreateAccountVM.errorMessage)

      }
      .overlay{
        if !CreateAccountVM.SignupapiLoaded{
          ProgressView("Creating account Please wait...").padding(.horizontal , 80).padding(.vertical , 30).background(RoundedRectangle(cornerRadius: 20).fill(Material.ultraThinMaterial).opacity(0.7))
        }
      }
      .background(Color("App Background"))
  }

  func shouldDisableNextButton() -> Bool {
    if selectedQuestion == 1 && CreateAccountVM.SelectedDenomination.isEmpty   {
      print("here")
      return true
    } else if selectedQuestion == 2 && CreateAccountVM.SelectedProfession.isEmpty || CreateAccountVM.SelectedProfession != CreateAccountVM.isSelectedProfession {
      return true
    }else if selectedQuestion == 3 && CreateAccountVM.SelectedEthnic.isEmpty || CreateAccountVM.SelectedEthnic != CreateAccountVM.isSelectedEthnic {
      return true
    }else if selectedQuestion == 4 && CreateAccountVM.SelectedEducation.isEmpty || CreateAccountVM.SelectedEducation != CreateAccountVM.isSelectedEducation {
      return true
    }else if (selectedQuestion == 5 &&  CreateAccountVM.PostCode.isEmpty) || (selectedQuestion == 5 && CreateAccountVM.City.isEmpty)  || (selectedQuestion == 5 && CreateAccountVM.Country.isEmpty) || (selectedQuestion == 5 && CreateAccountVM.State.isEmpty) {
      print(selectedQuestion)
      print(CreateAccountVM.PostCode)
      print(CreateAccountVM.City)
      return true
    }else if selectedQuestion == 6 && CreateAccountVM.SelectedHeight.isEmpty  {
      return true
    }else if selectedQuestion == 7 && CreateAccountVM.SelectedMaritalStatues.isEmpty {
      return true
    }else if selectedQuestion == 8 && CreateAccountVM.SelectedSmokeHabit.isEmpty  {
      return true
    }else if selectedQuestion == 9 && CreateAccountVM.SelectedDrinkHabit.isEmpty  {
      return true
    }else if selectedQuestion == 10 && CreateAccountVM.SelectedHaveChildren.isEmpty {
      return true
    }else if selectedQuestion == 11 && CreateAccountVM.SelectedWantChildren.isEmpty {
      return true
    }else if selectedQuestion == 12 && CreateAccountVM.SelectedChurchCommunity.isEmpty {
        return true
    }else if selectedQuestion == 13 && CreateAccountVM.Bio.isEmpty {
      return true
    }
    return false
  }


  func nextQuestion(){

    selectedItem = nil
    Gonext = true

    if selectedQuestion<=12{
      selectedQuestion += 1
    }
    isAnimating = false
  }


  func prevQuestion(){
    Gonext = false
    selectedItem = nil

    if selectedQuestion>=2{
      selectedQuestion -= 1
    }

    isAnimating = false

  }
}
#Preview {
    QuestionsViewNew().environmentObject(QuestionsVM())
}

struct FirstQuestionNew: View {
  @State var CreateAccountVM:QuestionsVM
  @Binding var selectedItem:Int?
  var body: some View {

      AddText(TextString: "What Denomination do you identify with? ☀️", TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
      .padding(.horizontal,20)
    ScrollView() {
      ForEach(0..<CreateAccountVM.religiousDenominations.count,id:\.self) { index in
        HStack {
          Text(CreateAccountVM.religiousDenominations[index]).frame(maxWidth: .infinity,alignment:.leading)
            .background(.blue.opacity(0.00005))
          Spacer()
          if selectedItem == index {
              Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }else {
              Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }
        }.onTapGesture {
          selectedItem = index
          CreateAccountVM.SelectedDenomination = CreateAccountVM.religiousDenominations[index]
          CreateAccountVM.isSelectedDenomination = CreateAccountVM.SelectedDenomination
        }
        .frame(maxWidth: .infinity,alignment:.leading).padding().background(Color.white).cornerRadius(12)
      }.padding(.horizontal,20)
       .background(Color("App Background"))


    }
  }
}

struct SecondQuestionNew: View {
  @StateObject var CreateAccountVM: QuestionsVM
  @Binding var selectedItem: Int?

  var filteredProfessions: [String] {
//    guard !CreateAccountVM.SelectedProfession.isEmpty else {
//      return CreateAccountVM.professions
//    }
    return CreateAccountVM.professions/*.filter { $0.localizedCaseInsensitiveContains(CreateAccountVM.SelectedProfession) }*/
  }


  var body: some View {
      AddText(TextString: "What’s is your profession?", TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
            .padding(.horizontal,20)
    ScrollView{
     
//      VStack(alignment: .leading, spacing: 8) {
//        HStack {
//          Image("Magnifier")
//          TextField("Search Profession", text: $CreateAccountVM.SelectedProfession)
//            .background(Color.clear)
//            .textFieldStyle(PlainTextFieldStyle())
//            .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.black)
//          Spacer()
//        }
//      }.padding(15)
//            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2).background(Color.white).cornerRadius(10)).padding(.horizontal,20)
//
//
//      AddText(TextString: "Recommend for you", TextSize: 20,Color: .primary)
//        .padding(.vertical,10).padding(.horizontal,30)

      ForEach(0..<filteredProfessions.count,id:\.self) { index in
        HStack {
          Text(filteredProfessions[index]).frame(maxWidth: .infinity,alignment:.leading)
            .background(.blue.opacity(0.00005))
          Spacer()
            if selectedItem == index {
                Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                    .aspectRatio(contentMode: .fill)
            }else {
                Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                    .aspectRatio(contentMode: .fill)
            }
        }.onTapGesture {
          selectedItem = index
          CreateAccountVM.SelectedProfession = filteredProfessions[index]
          CreateAccountVM.isSelectedProfession = CreateAccountVM.SelectedProfession

        }.listRowSeparator(.hidden)
          .frame(maxWidth: .infinity,alignment:.leading).padding().background(Color.white).cornerRadius(12)
      }.padding(.horizontal,20)
    }
  }
}

struct ThirdQuestionNew: View {
  @StateObject var CreateAccountVM:QuestionsVM
  @Binding var selectedItem:Int?

    var filteredEthnicGroups: [String] {
      return CreateAccountVM.ethnicGroups
  }


  var body: some View {
      AddText(TextString: "What’s your ethnicity", TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
            .padding(.horizontal,20)
    ScrollView{
      
      ForEach(0..<filteredEthnicGroups.count,id:\.self) { index in
        HStack {
          Text(filteredEthnicGroups[index]).frame(maxWidth: .infinity,alignment:.leading)
            .background(.blue.opacity(0.00005))
          Spacer()
            if selectedItem == index {
                Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                    .aspectRatio(contentMode: .fill)
            }else {
                Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                    .aspectRatio(contentMode: .fill)
            }
        }.onTapGesture {
          selectedItem = index
          CreateAccountVM.SelectedEthnic = filteredEthnicGroups[index]
          CreateAccountVM.isSelectedEthnic = CreateAccountVM.SelectedEthnic
        }.listRowSeparator(.hidden)
              .frame(maxWidth: .infinity,alignment:.leading).padding().background(Color.white).cornerRadius(12)
      }.padding(.horizontal,20)
    }


  }
}

struct FourthQuestionNew: View {
  @StateObject var CreateAccountVM: QuestionsVM
  @Binding var selectedItem: Int?

  var filteredEducationLevels: [String] {

    return CreateAccountVM.EducationLevels
  }
  var body: some View {
      AddText(TextString: "What’s your education level?" ,TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
            .padding(.horizontal,20)
    ScrollView{
      
//      VStack(alignment: .leading, spacing: 8) {
//        HStack {
//          Image("Magnifier")
//          TextField("Search education level", text: $CreateAccountVM.SelectedEducation)
//            .background(Color.clear)
//            .textFieldStyle(PlainTextFieldStyle())
//            .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.black)
//          Spacer()
//        }
//      }.padding(15)
//            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2).background(Color.white).cornerRadius(10)).padding(.horizontal,20)


      ForEach(0..<filteredEducationLevels.count,id:\.self) { index in
        HStack {
          Text(filteredEducationLevels[index]).frame(maxWidth: .infinity,alignment:.leading)
            .background(.blue.opacity(0.00005))
          Spacer()
            if selectedItem == index {
                Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                    .aspectRatio(contentMode: .fill)
            }else {
                Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                    .aspectRatio(contentMode: .fill)
            }
        }.onTapGesture {
          selectedItem = index
          CreateAccountVM.SelectedEducation = filteredEducationLevels[index]
          CreateAccountVM.isSelectedEducation = CreateAccountVM.SelectedEducation
        }.listRowSeparator(.hidden)
              .frame(maxWidth: .infinity,alignment:.leading).padding().background(Color.white).cornerRadius(12)
      }.padding(.horizontal,20)
    }
  }
}



struct FifthQuestionNew: View {
  @ObservedObject var locationViewModel = LocationViewModel.shared
  @StateObject var CreateAccountVM: QuestionsVM
  @Binding var selectedItem: Int?
  @State private var isShowingSettingsAlert = false
    
  var body: some View {
    ScrollView{
      AddText(TextString: "Where are you?",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
            .padding(.horizontal,20)


      VStack(alignment: .leading, spacing: 0) {
          AddText(TextString: "I am in", TextSize: 18, FontWeight: .bold).frame(alignment: .leading)
              .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
          Text(CreateAccountVM.FullAddress).fontWeight(.heavy).font(.custom("Avenir", size: 18)).foregroundColor(Color.gray)
              .frame(maxWidth: .infinity,alignment:.leading)
              .padding(.horizontal,20)
          Button {
              if locationViewModel.locationManager.authorizationStatus == .denied {
                  isShowingSettingsAlert = true
              }else {
                  locationViewModel.askLocation()
              }
          } label: {
            HStack{
              Spacer()
              Text("Find my location").fontWeight(.bold).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
              Spacer()
            }.frame( height: 50, alignment: .center)
                  .background(RoundedRectangle(cornerRadius: 25)).foregroundStyle(LinearGradient(colors:[  Color.black  ,  Color.black ], startPoint: .leading, endPoint: .trailing)
              )
          }.padding(EdgeInsets(top: 15, leading: 20, bottom: 20, trailing: 20))
      }.background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2).background(Color.white).cornerRadius(15)).padding(EdgeInsets(top: 1, leading: 20, bottom: 10, trailing: 20))


    }
    .onChange(of: locationViewModel.placemark, { oldValue, newValue in
        CreateAccountVM.Selectedlatitude = locationViewModel.currentLocation?.coordinate.latitude ?? 0.0
        CreateAccountVM.Selectedlongitude = locationViewModel.currentLocation?.coordinate.longitude ?? 0.0
        if let placemark = locationViewModel.placemark {
            CreateAccountVM.AddressLineOne = placemark.name ?? ""
            CreateAccountVM.City = placemark.locality ?? ""
            CreateAccountVM.PostCode = placemark.postalCode ?? ""
            CreateAccountVM.State = placemark.administrativeArea ?? ""
            CreateAccountVM.Country = placemark.country ?? ""
            CreateAccountVM.FullAddress = "\(CreateAccountVM.AddressLineOne), \(CreateAccountVM.City), \(CreateAccountVM.PostCode), \(CreateAccountVM.State), \(CreateAccountVM.Country)"
        }
    })
    .alert(isPresented: $isShowingSettingsAlert) {
        Alert(
            title: Text("Location Services Disabled"),
            message: Text("Please enable location services for this app in Settings."),
            primaryButton: .default(Text("Settings"), action: {
                openSettings()
            }),
            secondaryButton: .cancel()
        )
    }
  }
    
    func openSettings() {
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }
}
//struct FifthQuestionNew: View {
//  @StateObject var CreateAccountVM: QuestionsVM
//  @Binding var selectedItem: Int?
//  @State var Country:[CountryData] = []
//
//
//  var body: some View {
//    ScrollView{
//      AddText(TextString: "Enter Address Details",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
//            .padding(.horizontal,20)
//
//
//      VStack(alignment: .leading, spacing: 0) {
//        AddText(TextString: " Street Address", TextSize: 12)
//        TextField("Enter Address", text: $CreateAccountVM.AddressLineOne)
//          .background(Color.clear)
//          .textFieldStyle(PlainTextFieldStyle())
//          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
//          .padding(15) .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2).background(Color.white).cornerRadius(10)).padding(.top,2)
//          //.background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2))
//      }.padding(.horizontal,20)
//
//
//      VStack(alignment: .leading, spacing: 0) {
//        AddText(TextString: " City", TextSize: 12)
//        TextField("City", text: $CreateAccountVM.City)
//          .background(Color.clear)
//          .textFieldStyle(PlainTextFieldStyle())
//          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
//          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2).background(Color.white).cornerRadius(10)).padding(.top,2)
//      }.padding(.horizontal,20)
//
//      VStack(alignment: .leading, spacing: 0) {
//        AddText(TextString: " State", TextSize: 12)
//        TextField("State", text: $CreateAccountVM.State)
//          .background(Color.clear)
//          .textFieldStyle(PlainTextFieldStyle())
//          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
//          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2).background(Color.white).cornerRadius(10)).padding(.top,2)
//      }
//      .padding(.vertical,10)
//      .padding(.horizontal,20)
//
//
//
//      VStack(alignment: .leading, spacing: 0) {
//
//          AddText(TextString: " Country", TextSize: 12)
//
//        TextField("Country", text: $CreateAccountVM.Country)
//          .background(Color.clear)
//          .textFieldStyle(PlainTextFieldStyle())
//          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
//          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2).background(Color.white).cornerRadius(10)).padding(.top,2)
//
//      }
//      .padding(.horizontal,20)
//
//
//      VStack(alignment: .leading, spacing: 0) {
//        AddText(TextString: " Post Code", TextSize: 12)
//        TextField("10005", text: $CreateAccountVM.PostCode)
//          .background(Color.clear)
//          .textFieldStyle(PlainTextFieldStyle())
//          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
//          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2).background(Color.white).cornerRadius(10)).padding(.top,2)
//      }.padding(.horizontal,20)
//    }.onAppear{
//
//      DispatchQueue.main.async {
//        Country = CreateAccountVM.getCountries() ?? []
//      }
//    }
//  }
//}

struct SixthQuestionNew: View {
  @State var CreateAccountVM: QuestionsVM

  @Namespace private var namespace
  @State private var selectedHeight = "5' 5\" (165cm)"
  @State private var scrollToHeight = "5' 5\" (165cm)"
 // let HeightArray: [String] = (91...200).map { "\($0) cm" }

  let heightinFt = (30...120).map { String(format: "%.1f Ft", Double($0) * 0.1) }
    let HeightArray = [
        "3' 0\" (91cm)",
        "3' 1\" (94cm)",
        "3' 2\" (97cm)",
        "3' 3\" (99cm)",
         "3' 4\" (102cm)",
         "3' 5\" (104cm)",
         "3' 6\" (107cm)",
         "3' 7\" (109cm)",
         "3' 8\" (112cm)",
         "3' 9\" (114cm)",
         "3' 10\" (117cm)",
         "3' 11\" (119cm)",
         "4' 0\" (122cm)",
         "4' 1\" (124cm)",
         "4' 2\" (127cm)",
         "4' 3\" (130cm)",
         "4' 4\" (132cm)",
         "4' 5\" (135cm)",
         "4' 6\" (137cm)",
         "4' 7\" (140cm)",
         "4' 8\" (142cm)",
         "4' 9\" (145cm)",
         "4' 10\" (147cm)",
         "4' 11\" (150cm)",
         "5' 0\" (152cm)",
         "5' 1\" (155cm)",
         "5' 2\" (157cm)",
         "5' 3\" (160cm)",
         "5' 4\" (163cm)",
         "5' 5\" (165cm)",
         "5' 6\" (168cm)",
         "5' 7\" (170cm)",
         "5' 8\" (173cm)",
         "5' 9\" (175cm)",
         "5' 10\" (178cm)",
         "5' 11\" (180cm)",
         "6' 0\" (183cm)",
         "6' 1\" (185cm)",
         "6' 2\" (188cm)",
         "6' 3\" (190cm)",
         "6' 4\" (193cm)",
         "6' 5\" (196cm)",
         "6' 6\" (198cm)",
         "6' 7\" (201cm)",
         "6' 8\" (203cm)",
         "6' 9\" (206cm)",
         "6' 10\" (208cm)",
         "6' 11\" (211cm)",
         "7' 0\" (213cm)",
         "7' 1\" (216cm)",
         "7' 2\" (218cm)",
         "7' 3\" (221cm)",
         "7' 4\" (224cm)",
         "7' 5\" (226cm)",
         "7' 6\" (229cm)"
    ]
  var body: some View {
    VStack {
      AddText(TextString: "What's your height?",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
    .padding(.horizontal,0)
      GeometryReader { geometry in
        ScrollViewReader { proxy in
          ScrollView(showsIndicators: false) {
            VStack(spacing: 5) {
              ForEach(HeightArray, id: \.self) { value in
                Text(value)
                  .font(.custom("Avenir", size: value == selectedHeight ? 35 : 25))
                  .frame(maxWidth : .infinity)
                  .fontWeight(.bold)
                  .lineLimit(1)
                  .foregroundStyle(LinearGradient(colors: [value == selectedHeight ? Color.black : Color.gray, value == selectedHeight ? Color.black : Color.gray], startPoint: .leading, endPoint: .trailing))
                  .onTapGesture {
                    withAnimation {
                      selectedHeight = value
                      CreateAccountVM.SelectedHeight = value
                    }
                  }
              }
            }
            .onChange(of: scrollToHeight) { newHeight in

              withAnimation {
                proxy.scrollTo(newHeight, anchor: .center)
              }

            }
          }

        }.frame(maxWidth: .infinity)
              .padding(.horizontal, 25.0)
      }.frame(height: 250)
       .background(Color.white)
       .cornerRadius(12)



      Spacer()
    }
    .padding(.horizontal, 25.0)

  }

  func calculateDisplayValue(value: Int, selectedUnit: String) -> String {
    switch selectedUnit {
    case "cm":
      return "\(value) cm"
    case "Ft":
      let feet = Double(value) * 0.0328084
      return String(format: "%.1f ft", feet)
    default:
      return "\(value)"
    }
  }

  func convertToCentimeters(heightString: String) -> String? {
    guard let feet = Double(heightString) else {
      return nil
    }

    let centimeters = feet * 30.48

    return String(format: "%.1f cm", centimeters)
  }


}


struct SeventhQuestionNew: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "What’s your relationship status?",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
          .padding(.horizontal,20)

    List(0..<CreateAccountVM.MaritalStatues.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.MaritalStatues[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .fontWeight(.medium)
          .font(.custom("Avenir", size: 20)).foregroundColor(Color.primary)
        Spacer()
          if selectedItem == index {
              Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }else {
              Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedMaritalStatues = CreateAccountVM.MaritalStatues[index]
      }
      .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
      .listRowBackground(Color("App Background"))
      .listRowSeparator(.hidden)
        
      .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color.gray.opacity(0.2) : Color.gray.opacity(0.2),
                       selectedItem == index ? Color.gray.opacity(0.2) : Color.gray.opacity(0.2)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ))
      .background(Color.white)
      .cornerRadius(12)
    }
    .listStyle(.plain).padding(.horizontal, 0)
    .background(Color("App Background"))

  }
}

struct EigthQuestionNew: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Do you smoke?",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
          .padding(.horizontal,20)


    List(0..<CreateAccountVM.SmokeHabit.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.SmokeHabit[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .fontWeight(.medium)
          .font(.custom("Avenir", size: 20)).foregroundColor(index == 3 ? Color.gray : Color.primary)
        Spacer()
          if selectedItem == index {
              Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }else {
              Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedSmokeHabit = CreateAccountVM.SmokeHabit[index]
      }.listRowSeparator(.hidden)
       .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
       .listRowBackground(Color("App Background"))

        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ?  Color.gray.opacity(0.2) : Color.gray.opacity(0.25),
                       selectedItem == index ?  Color.gray.opacity(0.2) : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
        .background(Color.white)
        .cornerRadius(12)
    }.listStyle(.plain).padding(.horizontal, 0)
     .background(Color("App Background"))
  }
}

struct NinthQuestionNew: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Do you drink? 🍷",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
          .padding(.horizontal,20)




    List(0..<CreateAccountVM.SmokeHabit.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.SmokeHabit[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .fontWeight(.medium)

          .font(.custom("Avenir", size: 20)).foregroundColor(index == 3 ? Color.gray : Color.primary)
        Spacer()
          if selectedItem == index {
              Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }else {
              Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedDrinkHabit = CreateAccountVM.SmokeHabit[index]
      }.listRowSeparator(.hidden)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
            .listRowBackground(Color("App Background"))


        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color.gray.opacity(0.25) : Color.gray.opacity(0.25),
                       selectedItem == index ? Color.gray.opacity(0.25) : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
        .background(Color.white)
        .cornerRadius(12)
    }.listStyle(.plain).padding(.horizontal, 0)
          .background(Color("App Background"))


  }
}

struct TenthQuestionNew: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Do you have kids? 👋",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
          .padding(.horizontal,20)




    List(0..<CreateAccountVM.ChildrenHaveArray.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.ChildrenHaveArray[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .fontWeight(.medium)
          .font(.custom("Avenir", size: 20)).foregroundColor(index == 2 ? Color.gray : Color.primary)
        Spacer()
          if selectedItem == index {
              Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }else {
              Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedHaveChildren = CreateAccountVM.ChildrenHaveArray[index]
      }.listRowSeparator(.hidden)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
            .listRowBackground(Color("App Background"))

        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color.gray.opacity(0.25) : Color.gray.opacity(0.25),
                       selectedItem == index ? Color.gray.opacity(0.25) : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
        .background(Color.white)
        .cornerRadius(12)

    }.listStyle(.plain).padding(.horizontal, 0)
          .background(Color("App Background"))


  }
}

struct EleventhQuestionNew: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Would you like to have kids? 👶",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
          .padding(.horizontal,20)


    List(0..<CreateAccountVM.WantChildren.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.WantChildren[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .fontWeight(.medium)
          .font(.custom("Avenir", size: 20)).foregroundColor(index == 3 ? Color.gray : Color.primary)
        Spacer()
          if selectedItem == index {
              Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }else {
              Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedWantChildren = CreateAccountVM.WantChildren[index]
        CreateAccountVM.SignupapiCompleted = false
        CreateAccountVM.SignupapiLoaded = true
      }.listRowSeparator(.hidden)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
            .listRowBackground(Color("App Background"))

        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color.gray.opacity(0.25) : Color.gray.opacity(0.25),
                       selectedItem == index ? Color.gray.opacity(0.25) : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
        .background(Color.white)
        .cornerRadius(12)
    }.listStyle(.plain).padding(.horizontal, 0)
          .background(Color("App Background"))




  }
}

struct TwelvthQuestionNew: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  @State var BioCount = ""
  var body: some View {

    ScrollView{
      AddText(TextString: "Tell us about yourself", TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
            .padding(.horizontal,0)

        TextField("Tell us about your walk in faith, your hobbies, interests, and what your seeking in a potential partner.", text: $CreateAccountVM.Bio.max(300),  axis: .vertical)
            .lineLimit(4...200).padding()
            .background(Color.white)
            .cornerRadius(20)
        .onReceive(CreateAccountVM.$Bio) { newval in

          BioCount = newval
        }
       
      Text("\(BioCount.count)/300")
        .frame(maxWidth: .infinity,alignment: .trailing).padding(.trailing).fontWeight(.regular).font(.custom("Avenir", size: 20)).foregroundColor(.gray.opacity(0.5))
      Spacer()
    }.padding(.horizontal, 20.0)

  }
    
}



struct TwelveQuestionNewAdded: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Do you attend a local church community? ⛪",TextSize: 30, FontWeight: .bold).frame(alignment: .leading)
          .padding(.horizontal,20)




    List(0..<CreateAccountVM.ChurchCommunityArray.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.ChurchCommunityArray[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .fontWeight(.medium)
          .font(.custom("Avenir", size: 20)).foregroundColor(Color.primary)
        Spacer()
          if selectedItem == index {
              Image("ic_checked").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }else {
              Image("ic_uncheck").frame(width: 25, height: 25, alignment: .center)
                  .aspectRatio(contentMode: .fill)
          }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedChurchCommunity = CreateAccountVM.ChurchCommunityArray[index]
      }.listRowSeparator(.hidden)
            .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
            .listRowBackground(Color("App Background"))

        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color.gray.opacity(0.25) : Color.gray.opacity(0.25),
                       selectedItem == index ? Color.gray.opacity(0.25) : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
        .background(Color.white)
        .cornerRadius(12)

    }.listStyle(.plain).padding(.horizontal, 0)
          .background(Color("App Background"))
  }
}


extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
    
    func setFormatDate() -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self.wrappedValue) {
            dateFormatter.dateFormat = "MM-dd-yyyy"
            self.wrappedValue = dateFormatter.string(from: date)
        }
        return self
    }
}

