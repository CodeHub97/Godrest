//
//  Questionsview.swift
//  Godterest
//
//  Created by Varjeet Singh on 08/09/23.
//

import SwiftUI

struct Questionsview: View {

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
          if selectedQuestion == 1{
            Button {
              if selectedQuestion == 1{
                self.presentationMode.wrappedValue.dismiss()
              }else{
                isAnimating = true
                prevQuestion()
              }
            } label: {
              Image(systemName: "chevron.left").font(.system(size: 20)).bold()
            }.disabled(isAnimating)
          }
          Spacer()
        }.foregroundColor(.primary).padding(.leading)
        Text("\(selectedQuestion)/12").padding(.trailing)
      }

//      PROGRESSVIEW
      GradientProgressView(value: Double(selectedQuestion)).padding(30).frame(height: 40)

//      QUESTIONVIEW
      switch questionType {
      case .first:

        FirstQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge:.bottom ))
          )
      case .second:
        SecondQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom ))
          )
      case .third:
        ThirdQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom ))
          )
      case .fourth:
        FourthQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge:.bottom ))
          )
      case .fifth:
        FifthQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
          )
      case .sixth:
        SixthQuestion(CreateAccountVM: CreateAccountVM)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
          )
      case .seventh:
        SeventhQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge:.bottom ))
          )
      case .eighth:
        EigthQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom ))
          )
      case .ninth:
        NinthQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
          )
      case .tenth:
        TenthQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge:.bottom ))
          )
      case .eleventh:
        EleventhQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.move(edge:.bottom))
          )
      case .twelvth:
        TwelvthQuestion(CreateAccountVM: CreateAccountVM, selectedItem: $selectedItem)
          .transition(AnyTransition.asymmetric(insertion: AnyTransition.move(edge: !Gonext ? .leading : .trailing), removal: AnyTransition.move(edge: .bottom))
          ).onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
          }
      }

      if selectedQuestion == 12{

        HStack{
          Spacer()
          Text("Submit").fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
          Spacer()
        }.frame( height: 60, alignment: .center)
          .background(RoundedRectangle(cornerRadius: 10)).foregroundStyle(LinearGradient(colors: [!shouldDisableNextButton() ? Color("App Red") : Color.gray , !shouldDisableNextButton() ? Color("App Yellow") : Color.gray ], startPoint: .leading, endPoint: .trailing)
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
            Text("Next").fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
            Spacer()
          }.frame( height: 60, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 10)).foregroundStyle(LinearGradient(colors: [!shouldDisableNextButton() ? Color("App Red") : Color.gray , !shouldDisableNextButton() ? Color("App Yellow") : Color.gray ], startPoint: .leading, endPoint: .trailing)
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
    }else if selectedQuestion == 12 && CreateAccountVM.Bio.isEmpty {
      return true
    }
    return false
  }


  func nextQuestion(){

    selectedItem = nil
    Gonext = true

    if selectedQuestion<=11{
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


struct Questionsview_Previews: PreviewProvider {
  static var previews: some View {
    Questionsview().environmentObject(QuestionsVM())
  }
}



struct GradientProgressView: View {
  var value: Double // Should be between 1 and 12

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .frame(width: geometry.size.width, height: 5)
          .foregroundColor(Color.gray.opacity(0.3))
          .cornerRadius(3)

        LinearGradient(
          gradient: Gradient(colors: [Color("App Red"), Color("App Yellow")]),
          startPoint: .leading,
          endPoint: .trailing
        )
        .mask(
          RoundedRectangle(cornerRadius: 3)
            .frame(width: CGFloat(value) / 12 * geometry.size.width, height: 5)
        )
        .cornerRadius(3)
        .animation(.spring(), value: value)
        .offset(x: -(geometry.size.width / 2) + (CGFloat(value) / 24 * geometry.size.width))
      }
    }
  }
}

struct FirstQuestion: View {
  @State var CreateAccountVM:QuestionsVM
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "What is your Denomination?", TextSize: 20).frame(maxWidth: .infinity,alignment: .leading)
      .padding(.horizontal,30)
    AddText(TextString: "Enter your denomination to find the perfect match.", TextSize: 16,Color: .gray)
      .padding(.vertical,1)
      .padding(.bottom,20)
      .padding(.horizontal,30)

    Divider().offset(y: 7)
    ScrollView() {
      ForEach(0..<CreateAccountVM.religiousDenominations.count,id:\.self) { index in
        HStack {
          Text(CreateAccountVM.religiousDenominations[index]).frame(maxWidth: .infinity,alignment:.leading)
            .background(.blue.opacity(0.00005))
          Spacer()
          if selectedItem == index {
            Image("Radio button")
          }
        }.onTapGesture {
          selectedItem = index
          CreateAccountVM.SelectedDenomination = CreateAccountVM.religiousDenominations[index]
          CreateAccountVM.isSelectedDenomination = CreateAccountVM.SelectedDenomination
        }
        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.3),
                       selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.3)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
      }.padding(.horizontal,30)



    }
  }
}

struct SecondQuestion: View {
  @StateObject var CreateAccountVM: QuestionsVM
  @Binding var selectedItem: Int?

  var filteredProfessions: [String] {
    guard !CreateAccountVM.SelectedProfession.isEmpty else {
      return CreateAccountVM.professions
    }
    return CreateAccountVM.professions.filter { $0.localizedCaseInsensitiveContains(CreateAccountVM.SelectedProfession) }
  }


  var body: some View {
    ScrollView{
      AddText(TextString: "What’s is your profession?", TextSize: 20).frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal,30)
      AddText(TextString: "Let's start with the basics. Your profession helps us find the perfect match", TextSize: 16,Color: .gray)
        .padding(.vertical,1)
        .padding(.bottom,20).padding(.horizontal,30)

      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Image("Magnifier")
          TextField("Search Profession", text: $CreateAccountVM.SelectedProfession)
            .background(Color.clear)
            .textFieldStyle(PlainTextFieldStyle())
            .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
          Spacer()
        }
      }.padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2)).padding(.horizontal,30)


      AddText(TextString: "Recommend for you", TextSize: 20,Color: .primary)
        .padding(.vertical,10).padding(.horizontal,30)

      ForEach(0..<filteredProfessions.count,id:\.self) { index in
        HStack {
          Text(filteredProfessions[index]).frame(maxWidth: .infinity,alignment:.leading)
            .background(.blue.opacity(0.00005))
          Spacer()
          if selectedItem == index {
            Image("Radio button")
          }
        }.onTapGesture {
          selectedItem = index
          CreateAccountVM.SelectedProfession = filteredProfessions[index]
          CreateAccountVM.isSelectedProfession = CreateAccountVM.SelectedProfession

        }.listRowSeparator(.hidden)
          .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
            .foregroundStyle(
              LinearGradient(
                colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.3),
                         selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.3)],
                startPoint: .leading,
                endPoint: .trailing
              )
            ) )
      }.padding(.horizontal,30)
    }
  }
}

struct ThirdQuestion: View {
  @StateObject var CreateAccountVM:QuestionsVM
  @Binding var selectedItem:Int?

  var filteredEthnicGroups: [String] {
    guard !CreateAccountVM.SelectedEthnic.isEmpty else {
      return CreateAccountVM.ethnicGroups
    }
    return CreateAccountVM.ethnicGroups.filter { $0.localizedCaseInsensitiveContains(CreateAccountVM.SelectedEthnic) }
  }


  var body: some View {
    ScrollView{
      AddText(TextString: "What’s your ethnicity", TextSize: 20).frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal,30)
      AddText(TextString: "Let's start with the basics. Your ethnicity helps us find the perfect match", TextSize: 16,Color: .gray)
        .padding(.vertical,1)
        .padding(.bottom,20).padding(.horizontal,30)


      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Image("Magnifier")
          TextField("Search Countries", text: $CreateAccountVM.SelectedEthnic)
            .background(Color.clear)
            .textFieldStyle(PlainTextFieldStyle())
            .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
          Spacer()
        }
      }.padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2)).padding(.horizontal,30)


      ForEach(0..<filteredEthnicGroups.count,id:\.self) { index in
        HStack {
          Text(filteredEthnicGroups[index]).frame(maxWidth: .infinity,alignment:.leading)
            .background(.blue.opacity(0.00005))
          Spacer()
          if selectedItem == index {
            Image("Radio button")
          }
        }.onTapGesture {
          selectedItem = index
          CreateAccountVM.SelectedEthnic = filteredEthnicGroups[index]
          CreateAccountVM.isSelectedEthnic = CreateAccountVM.SelectedEthnic
        }.listRowSeparator(.hidden)
          .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
            .foregroundStyle(
              LinearGradient(
                colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.3),
                         selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.3)],
                startPoint: .leading,
                endPoint: .trailing
              )
            ) )
      }.padding(.horizontal,30)
    }


  }
}

struct FourthQuestion: View {
  @StateObject var CreateAccountVM: QuestionsVM
  @Binding var selectedItem: Int?

  var filteredEducationLevels: [String] {
    guard !CreateAccountVM.SelectedEducation.isEmpty else {
      return CreateAccountVM.EducationLevels
    }
    return CreateAccountVM.EducationLevels.filter { $0.localizedCaseInsensitiveContains(CreateAccountVM.SelectedEducation) }
  }
  var body: some View {
    ScrollView{
      AddText(TextString: "What’s your education level?", TextSize: 20).frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal,30)
      AddText(TextString: "Let's start with the basics. Your education level helps us find the perfect match", TextSize: 16,Color: .gray)
        .padding(.vertical,1)
        .padding(.bottom,20).padding(.horizontal,30)


      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Image("Magnifier")
          TextField("Search education level", text: $CreateAccountVM.SelectedEducation)
            .background(Color.clear)
            .textFieldStyle(PlainTextFieldStyle())
            .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
          Spacer()
        }
      }.padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2)).padding(.horizontal,30)


      ForEach(0..<filteredEducationLevels.count,id:\.self) { index in
        HStack {
          Text(filteredEducationLevels[index]).frame(maxWidth: .infinity,alignment:.leading)
            .background(.blue.opacity(0.00005))
          Spacer()
          if selectedItem == index {
            Image("Radio button")
          }
        }.onTapGesture {
          selectedItem = index
          CreateAccountVM.SelectedEducation = filteredEducationLevels[index]
          CreateAccountVM.isSelectedEducation = CreateAccountVM.SelectedEducation
        }.listRowSeparator(.hidden)
          .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
            .foregroundStyle(
              LinearGradient(
                colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.3),
                         selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.3)],
                startPoint: .leading,
                endPoint: .trailing
              )
            ) )
      }.padding(.horizontal,30)


    }
  }
}

struct FifthQuestion: View {
  @StateObject var CreateAccountVM: QuestionsVM
  @Binding var selectedItem: Int?
  @State var Country:[CountryData] = []


  var body: some View {
    ScrollView{
      AddText(TextString: "Enter Address Details", TextSize: 20,FontWeight: .bold).frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal,30)
      AddText(TextString: "Let's start with the basics. Your locality helps us find the perfect match", TextSize: 16,Color: .gray)
        .padding(.vertical,1)
        .padding(.bottom,20).padding(.horizontal,30)


      VStack(alignment: .leading, spacing: 0) {
        AddText(TextString: " Street Address", TextSize: 12)
        TextField("Enter Address", text: $CreateAccountVM.AddressLineOne)
          .background(Color.clear)
          .textFieldStyle(PlainTextFieldStyle())
          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2))
      }.padding(.horizontal,30)


      VStack(alignment: .leading, spacing: 0) {
        AddText(TextString: " City", TextSize: 12)
        TextField("City", text: $CreateAccountVM.City)
          .background(Color.clear)
          .textFieldStyle(PlainTextFieldStyle())
          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2))
      }.padding(.horizontal,30)

      VStack(alignment: .leading, spacing: 0) {
        AddText(TextString: " State", TextSize: 12)
        TextField("State", text: $CreateAccountVM.State)
          .background(Color.clear)
          .textFieldStyle(PlainTextFieldStyle())
          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2))
      }
      .padding(.vertical,10)
      .padding(.horizontal,30)



      VStack(alignment: .leading, spacing: 0) {

          AddText(TextString: " Country", TextSize: 12)

        TextField("Country", text: $CreateAccountVM.Country)
          .background(Color.clear)
          .textFieldStyle(PlainTextFieldStyle())
          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2))


      }
      .padding(.horizontal,30)


      VStack(alignment: .leading, spacing: 0) {
        AddText(TextString: " Post Code", TextSize: 12)
        TextField("10005", text: $CreateAccountVM.PostCode)
          .background(Color.clear)
          .textFieldStyle(PlainTextFieldStyle())
          .fontWeight(.regular).font(.custom("Avenir", size: 16)).foregroundColor(Color.primary)
          .padding(15).background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.gray).opacity(0.2))
      }.padding(.horizontal,30)
    }.onAppear{

      DispatchQueue.main.async {
        Country = CreateAccountVM.getCountries() ?? []
      }
    }
  }
}

struct SixthQuestion: View {
  @State var CreateAccountVM: QuestionsVM

  @State private var selectedUnit = "Ft"
  @Namespace private var namespace
  @State private var selectedHeight = "5.5 Ft"
  @State private var scrollToHeight = "5.5 Ft"
  let HeightArray: [String] = (91...200).map { "\($0) cm" }

  let heightinFt = (30...120).map { String(format: "%.1f Ft", Double($0) * 0.1) }
  
  var body: some View {
    VStack {
      AddText(TextString: "How tall are you?", TextSize: 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 30)

      AddText(TextString: "Let's start with the basics. Your height helps us find the perfect match", TextSize: 16, Color: .gray)
        .padding(.vertical, 1)
        .padding(.bottom, 20)
        .padding(.horizontal, 30)

      HStack(spacing: 0) {
        Text("Ft")
          .font(.title3)
          .fontWeight(.bold)
          .foregroundColor(selectedUnit == "Ft" ? .white : .primary)
          .padding(.horizontal)
          .padding()
          .background(.red.opacity(0.001))
          .frame(width: 100, height: 50)
          .onTapGesture {
            withAnimation {
              selectedUnit = "Ft"
            }
          }
          .background(ZStack {
            if selectedUnit == "Ft" {
              Capsule()
                .foregroundStyle(LinearGradient(colors: [Color("App Red"), Color("App Yellow")], startPoint: .leading, endPoint: .trailing))
                .frame(width: 100)
                .matchedGeometryEffect(id: "ids", in: namespace)
            }
          })

        Text("cm")
          .font(.title3)
          .fontWeight(.bold)
          .foregroundColor(selectedUnit == "cm" ? .white : .primary)
          .padding(.horizontal)
          .padding()
          .background(.red.opacity(0.001))
          .onTapGesture {
            withAnimation {
              selectedUnit = "cm"
            }
          }

          .frame(width: 100, height: 50)
          .background(ZStack {
            if selectedUnit == "cm" {
              Capsule()
                .foregroundStyle(LinearGradient(colors: [Color("App Red"), Color("App Yellow")], startPoint: .leading, endPoint: .trailing))
                .frame(width: 100)
                .matchedGeometryEffect(id: "ids", in: namespace)
            }
          })

      }
      .frame(width: 200, alignment: .center)
      .background(Capsule().foregroundColor(.gray.opacity(0.2)))
      .frame(maxWidth: .infinity, alignment: .center)



      GeometryReader { geometry in
        ScrollViewReader { proxy in
          ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {



              ForEach(selectedUnit == "Ft" ? heightinFt : HeightArray, id: \.self) { value in
                Text(value)
                  .font(.custom("Times", size: value == selectedHeight ? 50 : 25))
                  .frame(maxWidth : .infinity)
                  .fontWeight(.heavy)
                  .lineLimit(1)
                  .foregroundStyle(LinearGradient(colors: [value == selectedHeight ? Color("App Red") : Color.gray, value == selectedHeight ? Color("App Yellow") : Color.gray], startPoint: .leading, endPoint: .trailing))
                  .onTapGesture {
                    withAnimation {
                      selectedHeight = value
                      scrollToHeight = "\(value) \(selectedUnit)"
                      if selectedUnit == "cm"{
                        CreateAccountVM.SelectedHeight = value
                      } else{
                        if let heightnumericValue = Double(value.components(separatedBy: " ")[0]) {
                          let h =  convertToCentimeters(heightString: "\(heightnumericValue)")
                          CreateAccountVM.SelectedHeight = h ?? ""
                        }
                      }
                    }
                  }
                  .id("\(value) \(selectedUnit)")
              }
            }
            .onChange(of: scrollToHeight) { newHeight in

              withAnimation {
                proxy.scrollTo(newHeight, anchor: .center)
              }

            }
          }

        }.frame(maxWidth: .infinity)
      }



      Spacer()
    }
    .padding()
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


struct SeventhQuestion: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "What’s your Marital status?", TextSize: 20).frame(maxWidth: .infinity,alignment: .leading)
      .padding(.horizontal,30)
    AddText(TextString: "Let's start with the basics. Your marital status helps us find the perfect match", TextSize: 17,Color: .gray.opacity(0.7))
      .padding(.vertical,1)
      .padding(.bottom,20).padding(.horizontal,30)




    List(0..<CreateAccountVM.MaritalStatues.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.MaritalStatues[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .font(.custom("Avenir", size: 20)).foregroundColor(Color.primary)
        Spacer()
        if selectedItem == index {
          Image("Radio button")
        }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedMaritalStatues = CreateAccountVM.MaritalStatues[index]
      }.listRowSeparator(.hidden)
        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.25),
                       selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
    }.listStyle(.plain).padding(.horizontal, 10)


  }
}

struct EigthQuestion: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Do you smoke?", TextSize: 20,FontWeight: .regular).frame(maxWidth: .infinity,alignment: .leading)
      .padding(.horizontal,30)
    AddText(TextString: "Let's start with the basics. Your habits helps us find the perfect match", TextSize: 17,Color: .gray.opacity(0.7))
      .padding(.vertical,1)
      .padding(.bottom,20).padding(.horizontal,30)




    List(0..<CreateAccountVM.SmokeHabit.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.SmokeHabit[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .font(.custom("Avenir", size: 20)).foregroundColor(Color.primary)
        Spacer()
        if selectedItem == index {
          Image("Radio button")
        }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedSmokeHabit = CreateAccountVM.SmokeHabit[index]
      }.listRowSeparator(.hidden)
        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.25),
                       selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
    }.listStyle(.plain).padding(.horizontal, 10)


  }
}

struct NinthQuestion: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Do you drink alcohol?", TextSize: 20,FontWeight: .regular).frame(maxWidth: .infinity,alignment: .leading)
      .padding(.horizontal,30)
    AddText(TextString: "Let's start with the basics. Your habits helps us find the perfect match", TextSize: 17,Color: .gray.opacity(0.7))
      .padding(.vertical,1)
      .padding(.bottom,20).padding(.horizontal,30)




    List(0..<CreateAccountVM.SmokeHabit.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.SmokeHabit[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .font(.custom("Avenir", size: 20)).foregroundColor(Color.primary)
        Spacer()
        if selectedItem == index {
          Image("Radio button")
        }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedDrinkHabit = CreateAccountVM.SmokeHabit[index]
      }.listRowSeparator(.hidden)
        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.25),
                       selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
    }.listStyle(.plain).padding(.horizontal, 10)


  }
}

struct TenthQuestion: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Do you have children?", TextSize: 20,FontWeight: .regular).frame(maxWidth: .infinity,alignment: .leading)
      .padding(.horizontal,30)
    AddText(TextString: "Let's start with the basics. Your family status helps us find the perfect match", TextSize: 17,Color: .gray.opacity(0.7))
      .padding(.vertical,1)
      .padding(.bottom,20).padding(.horizontal,30)




    List(0..<CreateAccountVM.ChildrenHaveArray.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.ChildrenHaveArray[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .font(.custom("Avenir", size: 20)).foregroundColor(Color.primary)
        Spacer()
        if selectedItem == index {
          Image("Radio button")
        }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedHaveChildren = CreateAccountVM.ChildrenHaveArray[index]
      }.listRowSeparator(.hidden)
        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.25),
                       selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
    }.listStyle(.plain).padding(.horizontal, 10)


  }
}

struct EleventhQuestion: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  var body: some View {

    AddText(TextString: "Do you want children in future?", TextSize: 20,FontWeight: .regular).frame(maxWidth: .infinity,alignment: .leading)
      .padding(.horizontal,30)
    AddText(TextString: "Let's start with the basics. Your future family helps us find the perfect match", TextSize: 17,Color: .gray.opacity(0.7))
      .padding(.vertical,1)
      .padding(.bottom,20).padding(.horizontal,30)




    List(0..<CreateAccountVM.WantChildren.count,id:\.self) { index in
      HStack {
        Text(CreateAccountVM.WantChildren[index]).frame(maxWidth: .infinity,alignment:.leading)
          .background(.blue.opacity(0.00005))
          .font(.custom("Avenir", size: 20)).foregroundColor(Color.primary)
        Spacer()
        if selectedItem == index {
          Image("Radio button")
        }
      }.onTapGesture {
        selectedItem = index
        CreateAccountVM.SelectedWantChildren = CreateAccountVM.WantChildren[index]
        CreateAccountVM.SignupapiCompleted = false
        CreateAccountVM.SignupapiLoaded = true
      }.listRowSeparator(.hidden)
        .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
          .foregroundStyle(
            LinearGradient(
              colors: [selectedItem == index ? Color("App Red") : Color.gray.opacity(0.25),
                       selectedItem == index ? Color("App Yellow") : Color.gray.opacity(0.25)],
              startPoint: .leading,
              endPoint: .trailing
            )
          ) )
    }.listStyle(.plain).padding(.horizontal, 10)




  }
}

struct TwelvthQuestion: View {
  @State var CreateAccountVM:QuestionsVM
  @Namespace private var namespace
  @Binding var selectedItem:Int?
  @State var BioCount = ""
  var body: some View {

    ScrollView{
      AddText(TextString: "Tell us about yourself", TextSize: 20,FontWeight: .regular).frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal,30)
      AddText(TextString: "Let's start with the basics. A little about you helps us find the perfect match", TextSize: 17,Color: .gray.opacity(0.7))
        .padding(.vertical,1)
        .padding(.bottom,20).padding(.horizontal,30)


      TextField("Tell us about your walk in faith, your hobbies, interests, and what your seeking in a potential partner.", text: $CreateAccountVM.Bio,  axis: .vertical)
        .lineLimit(4...6).padding().background(RoundedRectangle(cornerRadius: 20).foregroundColor(.gray.opacity(0.2))).padding(.horizontal)
        .onReceive(CreateAccountVM.$Bio) { newval in

          BioCount = newval
        }


      Text("\(BioCount.count)/300")
        .frame(maxWidth: .infinity,alignment: .trailing).padding(.trailing).fontWeight(.regular).font(.custom("Avenir", size: 20)).foregroundColor(.gray.opacity(0.5))
      Spacer()
    }

  }
}



struct CustomTextEditor: View {
  let placeholder: String
  @Binding var text: String
  let internalPadding: CGFloat = 5
  var body: some View {
    ZStack(alignment: .topLeading) {
      if text.isEmpty  {
        Text(placeholder)
          .foregroundColor(Color.primary.opacity(0.25))
          .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
          .padding(internalPadding)
      }
      TextEditor(text: $text)
        .padding(internalPadding)
    }.onAppear() {
      UITextView.appearance().backgroundColor = .clear
    }.onDisappear() {
      UITextView.appearance().backgroundColor = nil
    }
  }
}
extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
