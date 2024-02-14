//
//  EditProfileScreen.swift
//  Godterest
//
//  Created by Varjeet Singh on 18/09/23.
//

import SwiftUI

struct EditProfileScreen: View {
    
    @State var BadgeOn: Bool = false
    @State var ShowToast: Bool = false
    @State var ShowToastBadge: Bool = false
    @State var ShowValidationToast: Bool = false
    @ObservedObject var imagePickerVM = ImagePickerViewModel()
    @ObservedObject var ProfileViewModel = EditProfileViewModel()
    @State private var isProgresViewOverlayVisible = false
    @State private var isDatePickerVisible = false
    @State private var success = false
    @State private var failure = false
    
    @State private var selectedDate = Date()
    
    // Gender
    var genders = ["Male", "Female", "Other"]
    @State private var isGenderPickerVisible = false
    
    // Alcohol
    @State private var isAlcoholPickerVisible = false

    //Smoking
    @State private var isSmokingPickerVisible = false

    // Marital
    @State private var isMaritalPickerVisible = false
    var maritalStatusess = ["Single", "Married", "Widowed", "Divorced", "Deparated"]
    
    // Height
    @State private var isHeightPickerVisible = false
    var heights = [   "3' 0\" (91cm)",
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
                       "7' 6\" (229cm)"]
    
    // Education
    @State private var isEducationVisible = false
    var EducationLevels = [
        "High school",
        "Non- degree qualification",
        "Undergraduate degree",
        "Postgraduate degree",
        "Doctorate",
        "Other",
    ]
    
    // Profession
    @State private var isProfessionsVisible = false

    @State var isEditingBio = false
    var professions = [
        "Accountant",
        "Actor",
        "Air Hostess",
        "Administration Employee",
        "Administration Professional",
        "Architect",
        "Artist",
        "Astronomer",
        "Athlete",
        "Author",
        "Baker",
        "Barista",
        "Bartender",
        "Biologist",
        "Botanist",
        "Carpenter",
        "Chef",
        "Chemist",
        "Coach",
        "Dancer",
        "Dentist",
        "Designer",
        "Detective",
        "Doctor",
        "Economist",
        "Electrician",
        "Engineer",
        "Farmer",
        "Firefighter",
        "Fisherman",
        "Flight Attendant",
        "Freelancer",
        "Geologist",
        "Graphic Designer",
        "Hair Stylist",
        "Historian",
        "Insurance Agent",
        "Interpreter",
        "Journalist",
        "Judge",
        "Lawyer",
        "Librarian",
        "Linguist",
        "Mathematician",
        "Mechanic",
        "Meteorologist",
        "Musician",
        "Nurse",
        "Optometrist",
        "Painter",
        "Paramedic",
        "Pharmacist",
        "Photographer",
        "Physicist",
        "Pilot",
        "Plumber",
        "Police Officer",
        "Professor",
        "Programmer",
        "Psychologist",
        "Real Estate Agent",
        "Receptionist",
        "Singer",
        "Software Engineer",
        "Statistician",
        "Surgeon",
        "Teacher",
        "Translator",
        "Veterinarian",
        "Waiter/Waitress",
        "Writer"
    ]
    
    // Children
    var ChildrenHaveArray = [
        "Have kids",    "Don't have kids" , "Prefer not to say"
    ]
    @State private var isChildrenrPickerVisible = false
    
    var eitherValues = ["Yes", "No"]
    
    init() {
        
    }
    @State private var isEditing = false

    var body: some View {
        VStack{
            VStack {
                ZStack(alignment: .center) {
                    BackButton()
                    AddText(TextString: "Profile", TextSize: 20,FontWeight: .medium,Alignment: .center)
                }.padding(.top)
                Divider().offset(y: 8)
            }
            ScrollView {
                VStack(spacing: 0) {
                    ZStack (alignment: .bottomTrailing){
                        if let url = URL(string: APIConstants.s3BucketUrl + ProfileViewModel.ProfilePic) {
                            AsyncImage(url: url) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 120, height: 120, alignment: .center)
                                        .cornerRadius(60)
                                        .padding(3)
                                        .background(Circle().fill(Material.ultraThinMaterial))
                                } else {
                                    Image(ProfileViewModel.GenderSelect == "Female" ?  "FemalePlaceholder" : "MalePlaceholder")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 120, alignment: .center)
                                        .cornerRadius(60)
                                        .padding(3)
                                        .background(Circle().fill(.white))
                                        .overlay {
                                            ProgressView()
                                        }
                                }
                            }
                        } else {
                            Image(ProfileViewModel.GenderSelect == "Female" ?  "FemalePlaceholder" : "MalePlaceholder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120, alignment: .center)
                                .cornerRadius(60)
                                .padding(3)
                                .background(Circle().fill(.white))
                        }
                        Image("Edit icon").resizable().frame(width: 45, height: 45).onTapGesture {
                            imagePickerVM.selectImage()
                        }.onChange(of: imagePickerVM.selectedImage) { newValue in
                            if let newImage = newValue {
                                ProfileViewModel.SelectedProfileUIImage = newImage
                                ProfileViewModel.uploadProfileImage { imageUrl in
                                    let finalUrl = imageUrl?.replacingOccurrences(of: "AKIAUWX5SL2ZDHVG7KO2", with: "")
                                    self.ProfileViewModel.ProfilePic = finalUrl ?? ""
                                }
                            }
                        }

                    }
                    
                    AddTextwithgradint(TextString: ProfileViewModel.Name, TextSize: 30,Font: .custom("Grandista", size: 22), FontWeight: .medium).frame(maxWidth: .infinity,alignment: .center)
                        .padding(.vertical,5)
                    
                }.padding(.top,30)
                
                
                AddTextwithgradint(TextString: "OTHER PHOTOS", TextSize: 16,FontWeight: .medium).frame(maxWidth: .infinity,alignment: .leading).offset(y: 20)
                    .padding(.leading,30)
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(),spacing: 20),
                        GridItem(.flexible(),spacing: 20),
                        GridItem(.flexible(),spacing: 20)
                    ],spacing: 30) {
                        ForEach(ProfileViewModel.images.indices, id: \.self) { index in
                            let image = ProfileViewModel.images[index]
                            if let url = URL(string: APIConstants.s3BucketUrl + image) {
                                AsyncImage(url: url) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .mask(RoundedRectangle(cornerRadius: 20))
                                            .frame(width: 100, height: 100)
                                    }else{
                                        Image(ProfileViewModel.GenderSelect == "Female" ?  "FemalePlaceholder" : "MalePlaceholder")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .mask(RoundedRectangle(cornerRadius: 20))
                                            .frame(width: 100, height: 100).overlay {
                                                ProgressView()
                                            }.padding(1)
                                            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth:1).foregroundColor(.gray.opacity(0.5)))
                                    }
                                }
                                .id(index) // Use index as the ID
                            }
                        }
                        
                        // Placeholder rectangle with "Add More" button
                        if ProfileViewModel.images.isEmpty || ProfileViewModel.images.count % 3 != 0 {
                            RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 2, lineCap: CGLineCap.square,  dash: [4,6], dashPhase: 24)).padding(.top,2)
                                .gradientText(colors: [Color("App Red"), Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
                                .frame(width: 90, height: 90)
                                .overlay(Image("camera").onTapGesture {
                                    ShowToast.toggle()
                                })
                        }
                    }.padding(.all,20)
                }.frame(height: 180)
                
                VStack(spacing: 0){
                    AddTextwithgradint(TextString: "ABOUT ME", TextSize: 16,FontWeight: .medium).frame(maxWidth: .infinity,alignment: .leading).padding(.bottom)
                    CustomizedFields(Placeholder: "First Name", LabelText: "First Name", isDisabled: false, BinderVar: $ProfileViewModel.Name)
                    CustomizedFields(Placeholder: "Date of birth", LabelText: "Date of birth",isDisabled: false,  BinderVar: $ProfileViewModel.dateofBirth.setFormatDate())
                        .onTapGesture {
                            self.dismissPreviousOverlays()
                            isDatePickerVisible.toggle()
                        }
                    CustomizedFields(Placeholder: "Gender", LabelText: "Gender",isDisabled: false,  BinderVar: $ProfileViewModel.GenderSelect).onTapGesture {
                        self.dismissPreviousOverlays()
                        isGenderPickerVisible.toggle()
                    }
                    CustomizedFields(Placeholder: "Height", LabelText: "Height",isDisabled: false,  BinderVar: $ProfileViewModel.SelectedHeight).onTapGesture {
                        self.dismissPreviousOverlays()
                        isHeightPickerVisible.toggle()
                    }
                    CustomizedFields(Placeholder: "Material Status", LabelText: "Material Status",isDisabled: false,  BinderVar: $ProfileViewModel.SelectedMaritalStatues).onTapGesture {
                        self.dismissPreviousOverlays()
                        isMaritalPickerVisible.toggle()
                    }
                    CustomizedFields(Placeholder: "Children", LabelText: "Children",isDisabled: false,  BinderVar: $ProfileViewModel.SelectedHaveChildren).onTapGesture {
                            self.dismissPreviousOverlays()
                            isChildrenrPickerVisible.toggle()
                        }
                    AddText(TextString: "Bio ℹ️", TextSize: 16,FontWeight: .medium).frame(maxWidth: .infinity,alignment: .leading) .onTapGesture {
                        isEditingBio.toggle()
                    }
                    TextField("Bio", text: $ProfileViewModel.Bio,axis: isEditingBio ? .vertical : .horizontal)
                        .disabled(false).font(.custom("Avenir", size: 14)).frame(minHeight: 52, maxHeight: isEditingBio ? .infinity : 50)
                    Color(.gray).opacity(0.1).frame(height: 1).padding(.bottom,10)
                        //.background(RoundedRectangle(cornerRadius: 10).frame(height: 2).foregroundColor(.gray.opacity(0.1)).offset(y: 0)).offset(y: 0)
                       
                    //CustomizedFields(Placeholder: "Bio", LabelText: "Bio",isDisabled: false,  BinderVar: $ProfileViewModel.Bio)
                    CustomizedFields(Placeholder: "Zip Code", LabelText: "Zip Code",isDisabled: false,  BinderVar: $ProfileViewModel.Location)
                }
                .padding(.horizontal,30)
                .padding(.top,10)
                
                VStack(spacing: 0){
                    CustomizedFields(Placeholder: "Alcohol", LabelText: "Alcohol",isDisabled: false,  BinderVar: $ProfileViewModel.SelectedDrinkHabit).onTapGesture {
                        self.dismissPreviousOverlays()
                        isAlcoholPickerVisible.toggle()
                    }
                    CustomizedFields(Placeholder: "Smoking", LabelText: "Smoking",isDisabled: false,  BinderVar: $ProfileViewModel.SelectedSmokeHabit).onTapGesture {
                        self.dismissPreviousOverlays()
                        isSmokingPickerVisible.toggle()
                    }
                } .padding(.horizontal,30)
                
                VStack(spacing: 0){
                    AddTextwithgradint(TextString: "EDUCATION & CAREER", TextSize: 16,FontWeight: .medium).frame(maxWidth: .infinity,alignment: .leading).padding(.bottom)
                    CustomizedFields(Placeholder: "Education", LabelText: "Education",isDisabled: false,  BinderVar: $ProfileViewModel.SelectedEducation).onTapGesture {
                        self.dismissPreviousOverlays()
                        isEducationVisible.toggle()
                    }
                    CustomizedFields(Placeholder: "Profession", LabelText: "Profession",isDisabled: false,  BinderVar: $ProfileViewModel.SelectedProfession).onTapGesture {
                        self.dismissPreviousOverlays()
                        isProfessionsVisible.toggle()
                    }
                    
                }
                .padding(.horizontal,30)
                .padding(.vertical,10)
                Button {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.validateFeilds()
                } label: {
                    HStack{
                        Spacer()
                        Text("Save").fontWeight(.medium).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
                        Spacer()
                    }.frame( height: 60, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 10)).foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
                        )
                }.padding()
                
            }
        }.onAppear(perform: {
            ProfileViewModel.setProfileData()
        })
        .overlay(childrenPickerOverlay)
        .overlay(dobPickerOverlay)
            .overlay(genderPickerOverlay)
            .overlay(drinkPickerOverlay)
            .overlay(smokePickerOverlay)
            .overlay(maritalPickerOverlay)
            .overlay(heightPickerOverlay)
            .overlay(educationPickerOverlay)
            .overlay(professionalPickerOverlay)
            .overlay(progresViewOverlay)
            .navigationBarBackButtonHidden(true)
            .toast(isPresenting: $ShowToast){
                AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title: "Working in progres...")
            }
            .toast(isPresenting: $ShowValidationToast){
                AlertToast(displayMode: AlertToast.DisplayMode.banner(.pop), type: .regular, title: "Please fill all the feilds")
            }
           .toast(isPresenting: $ShowToastBadge){
            AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title: "Coming Soon...")
           }
           .toast(isPresenting: $success){
               AlertToast(displayMode: AlertToast.DisplayMode.banner(.pop), type: .regular, title: "Profile updated")
           }
           .toast(isPresenting: $failure){
               AlertToast(displayMode: AlertToast.DisplayMode.banner(.pop), type: .regular, title: "Something went wrong! Please try again")
           }
    }
    
    //MARK: Gender selection view
    @ViewBuilder private var progresViewOverlay: some View {
        if isProgresViewOverlayVisible {
            ProgressView("Updating...").font(.custom("Grandista", size: 16)) .gradientText(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
        }
    }
    
    
    
    //MARK: Gender selection view
    @ViewBuilder private var genderPickerOverlay: some View {
        if isGenderPickerVisible {
           PickerView(header: "Select gender", selections: genders, binderVar: $ProfileViewModel.GenderSelect, showKeyboardBinder: $isGenderPickerVisible)
        }
    }
    
    //MARK: DOB selection view
    @ViewBuilder private var dobPickerOverlay: some View {
        if isDatePickerVisible {
            self.toggleDatePicker()
        }
    }
    
    //MARK: Drink selection view
    @ViewBuilder private var drinkPickerOverlay: some View {
        if isAlcoholPickerVisible {
            PickerView(header: "Select option", selections: eitherValues, binderVar: $ProfileViewModel.SelectedDrinkHabit, showKeyboardBinder: $isAlcoholPickerVisible)
        }
    }
    
    //MARK: Smoking selection view
    @ViewBuilder private var smokePickerOverlay: some View {
        if isSmokingPickerVisible {
            PickerView(header: "Select option", selections: eitherValues, binderVar: $ProfileViewModel.SelectedSmokeHabit, showKeyboardBinder: $isSmokingPickerVisible)
        }
    }
    
    //MARK: Marital status selection view
    @ViewBuilder private var maritalPickerOverlay: some View {
        if isMaritalPickerVisible {
            PickerView(header: "Select option", selections: maritalStatusess, binderVar: $ProfileViewModel.SelectedMaritalStatues, showKeyboardBinder: $isMaritalPickerVisible)
        }
    }
    
    //MARK: Height selection view
    @ViewBuilder private var heightPickerOverlay: some View {
        if isHeightPickerVisible {
            PickerView(header: "Select option", selections: heights, binderVar: $ProfileViewModel.SelectedHeight, showKeyboardBinder: $isHeightPickerVisible)
        }
    }
    
    //MARK: Education selection view
    @ViewBuilder private var educationPickerOverlay: some View {
        if isEducationVisible {
            PickerView(header: "Select option", selections: EducationLevels, binderVar: $ProfileViewModel.SelectedEducation, showKeyboardBinder: $isEducationVisible)
        }
    }
    
    //MARK: Professional selection view
    @ViewBuilder private var professionalPickerOverlay: some View {
        if isProfessionsVisible {
            PickerView(header: "Select option", selections: professions, binderVar: $ProfileViewModel.SelectedProfession, showKeyboardBinder: $isProfessionsVisible)
        }
    }
    
    //MARK: Children selection view
    @ViewBuilder private var childrenPickerOverlay: some View {
        if isChildrenrPickerVisible {
           PickerView(header: "Select option", selections: ChildrenHaveArray, binderVar: $ProfileViewModel.SelectedHaveChildren, showKeyboardBinder: $isChildrenrPickerVisible)
        }
    }
    
    func toggleDatePicker() -> AnyView {
        return AnyView( VStack {
            Spacer()
            VStack {
                HStack {
                    Button("Cancel") {
                        isDatePickerVisible = false
                    }
                    Spacer()
                    Button("Done") {
                        ProfileViewModel.dateofBirth = dateFormatter.string(from: self.selectedDate)
                        isDatePickerVisible = false
                    }
                }
                .padding()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .environment(\.locale, Locale(identifier: "us"))
                    .labelsHidden()
                    .frame(maxHeight: 200)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 5).onAppear {
                        self.dismissKeyboard()
                    }
            }.background(Color.white)
        }.background(Color.clear)
        .transition(.move(edge: .bottom))
        .animation(.easeInOut))
    }
}

extension EditProfileScreen {
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func validateFeilds() {
        dismissPreviousOverlays()
        if ProfileViewModel.validateFeilds() {
            isProgresViewOverlayVisible.toggle()
            ProfileViewModel.callEditProfileAPI { success in
                self.isProgresViewOverlayVisible.toggle()
                _ = success ? self.success.toggle() : self.failure.toggle()
            }
        } else {
            ShowValidationToast.toggle()
        }
    }
    
    private func dismissPreviousOverlays() {
        isDatePickerVisible = false
        isGenderPickerVisible = false
        isAlcoholPickerVisible = false
        isSmokingPickerVisible = false
        isMaritalPickerVisible = false
        isHeightPickerVisible = false
        isProfessionsVisible = false
        isEducationVisible = false
        isChildrenrPickerVisible = false
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileScreen()
    }
}

struct CustomizedFields: View {
    @State var Placeholder: String
    @State var LabelText: String
    @State var isDisabled: Bool
    
    @Binding var BinderVar:String
    var body: some View {
        VStack(spacing: 0){
            AddText(TextString: LabelText, TextSize: 16,FontWeight: .medium).frame(maxWidth: .infinity,alignment: .leading)
            TextField(Placeholder, text: $BinderVar)
                .disabled(isDisabled).font(.custom("Avenir", size: 14)).frame(height: 50).background(RoundedRectangle(cornerRadius: 10).frame(height: 2).foregroundColor(.gray.opacity(0.1)).offset(y: 12)).offset(y: -10)
        }
    }
}

//MARK: Picker view
struct PickerView: View {
    @State var header: String
    @State var selections: [String]
    @Binding var binderVar:String
    @Binding var showKeyboardBinder: Bool
    var body: some View {
        var height = 40.0 * CGFloat(selections.count) > (UIScreen.main.bounds.height / 4) ? (UIScreen.main.bounds.height / 4) : 40.0 * CGFloat(selections.count)
        VStack {
            Spacer()
            VStack {
                HStack {
                    Button("Cancel") {
                        showKeyboardBinder = false
                    }
                    Spacer()
                    Button("Done") {
                        showKeyboardBinder = false
                    }
                }
                .padding()
                Picker(header, selection: $binderVar){
                    ForEach(selections, id: \.self) {
                        Text($0)
                    }
                }.frame(height: height)
                 .onAppear {
                    self.dismissKeyboard()
                 }
            }.background(Color.white)
        }.background(Color.clear)
        .transition(.move(edge: .bottom))
        .animation(.easeInOut)
        .pickerStyle(.wheel)
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
