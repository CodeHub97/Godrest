//
//  AccountSetup.swift
//  Godterest
//
//  Created by Varjeet Singh on 08/09/23.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct AccountSetup: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var TermsPolicyLinkOpen = false
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    var body: some View {
        VStack{
            BackButton().padding(.top)
            
            VStack(alignment: .leading,spacing: 20 ) {
                VStack(alignment: .leading,spacing: 2 ) {
                    Text("What’s your email address?").fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 20))
                    Text("We’ll email you a code to verify your identity").fontWeight(.regular).foregroundColor(Color.gray).font(.custom("Avenir", size: 16)).frame(maxWidth: .infinity,alignment: .leading).padding(.bottom)
                    
                    AddText(TextString: "Email", TextSize: 14,Color: .primary, FontWeight: .medium, Alignment: .leading)
                    HStack {
                        Image("Mail").font(.custom("Avenir", size: 16))
                        TextField("Email Address", text: $CreateAccountVM.Email).font(.custom("Avenir", size: 16))
                    }.padding().frame(height: 50).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.2)))
                }
                VStack(alignment: .leading,spacing: 2 ) {
                    AddText(TextString: "Password", TextSize: 14,Color: .primary, FontWeight: .medium, Alignment: .leading)
                    HStack {
                        Image(systemName: "lock").resizable().frame(width: 15,height: 18) .foregroundColor(.black.opacity(0.4)).padding(.leading,3)
                        
                        if CreateAccountVM.PasswordOpen{
                            TextField( "Password", text: $CreateAccountVM.Password).font(.custom("Avenir", size: 16))
                        }else{
                            SecureField( "Password", text: $CreateAccountVM.Password).font(.custom("Avenir", size: 16))
                        }
                        Image(systemName:  CreateAccountVM.PasswordOpen ? "eye.fill" : "eye.slash.fill" ).font(.custom("Avenir", size: 16)).foregroundColor(.black.opacity(0.4)).onTapGesture {
                            CreateAccountVM.PasswordOpen.toggle()
                        }
                        
                    }.padding().frame(height: 50).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.2)))
                }
                
                VStack(alignment: .leading,spacing: 2 ) {
                    
                    AddText(TextString: "Confirm Password", TextSize: 14,Color: .primary, FontWeight: .medium, Alignment: .leading)
                    HStack {
                        Image(systemName: "lock").resizable().frame(width: 15,height: 18) .foregroundColor(.black.opacity(0.4)).padding(.leading,3)
                        
                        if CreateAccountVM.ConfirmPasswordOpen{
                            TextField( "Confirm Password", text: $CreateAccountVM.ConfirmPassword).font(.custom("Avenir", size: 16))
                        }else{
                            SecureField( "Confirm Password", text: $CreateAccountVM.ConfirmPassword).font(.custom("Avenir", size: 16))
                        }
                        Image(systemName:  CreateAccountVM.ConfirmPasswordOpen ? "eye.fill" : "eye.slash.fill" ).font(.custom("Avenir", size: 16)).foregroundColor(.black.opacity(0.4)).onTapGesture {
                            CreateAccountVM.ConfirmPasswordOpen.toggle()
                        }
                        
                    }.padding().frame(height: 50).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.2)))
                    
//                    AddText(TextString: "Confirm Password", TextSize: 14,Color: .primary, FontWeight: .medium, Alignment: .leading)
//                    HStack {
//                        Image(systemName: "lock").resizable().frame(width: 15,height: 18) .foregroundColor(.black.opacity(0.4)).padding(.leading,3)
//                        TextField( "Confirm Password", text: $CreateAccountVM.ConfirmPassword).font(.custom("Avenir", size: 16))
//                    }.padding().frame(height: 50).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.2)))
                }
                
                VStack{
                    AddText(TextString: "• Password must be at least 8 characters long.", TextSize: 10,Color: .primary.opacity(0.5), FontWeight: .medium, Alignment: .leading)
                    AddText(TextString: "• Must contain at least one uppercase letter.", TextSize: 10,Color: .primary.opacity(0.5), FontWeight: .medium, Alignment: .leading)
                    AddText(TextString: "• Must contain at least one lowercase letter.", TextSize: 10,Color: .primary.opacity(0.5), FontWeight: .medium, Alignment: .leading)
                    AddText(TextString: "• Must include at least one numeric digit (0-9).", TextSize: 10,Color: .primary.opacity(0.5), FontWeight: .medium, Alignment: .leading)
                }
            }.padding(20)
            
            CustomButton(ButtonTitle: "Continue", ButtonType: .Email ,View: AnyView(GenderView())).padding(.all)
            
            
            
            HStack {
                Text("By continuing you agree to our ").fontWeight(.medium).font(.custom("Avenir", size: 15)).foregroundColor(.white) +
                Text("Terms and Privacy Policy.").fontWeight(.medium).font(.custom("Avenir", size: 15)).underline().foregroundColor(.white)
                
            }.onTapGesture {
                TermsPolicyLinkOpen.toggle()
            }.navigationDestination(isPresented: $TermsPolicyLinkOpen, destination: {
                WebViewContainer(urlString: "https://godterest.com/terms-and-conditions/")
            })
            Spacer().onAppear{
                // Convert it to a JSON string
                //        let randomJSON = CreateAccountVM.generateRandomJSON()
                //        print(randomJSON)
                //        CreateAccountVM.SignupapiCompleted = false
                //        CreateAccountVM.SignupapiLoaded = true
                //        CreateAccountVM.showToast = false
            }
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct AccountSetup_Previews: PreviewProvider {
    static var previews: some View {
        AddHobbies().environmentObject(QuestionsVM())
    }
}



struct GenderView:View{
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    
    
    var body: some View {
        VStack{
            BackButton().padding(.top)
            
            VStack(alignment: .center,spacing: 20 ) {
                Text("What is your gender?").fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 20)).frame(maxWidth: .infinity,alignment:.leading)
                
                
                HStack(spacing: 25) {
                    
                    GenderSelect(GenderType: "Male")
                        .onTapGesture {
                            CreateAccountVM.GenderSelect = .Male
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors: CreateAccountVM.GenderSelect == .Male ?
                                            [Color("App Red"), Color("App Yellow")] : [Color.clear]
                                        ),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                    
                    GenderSelect(GenderType: "Female")
                        .onTapGesture {
                            CreateAccountVM.GenderSelect = .Female
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors: CreateAccountVM.GenderSelect == .Female ?
                                            [Color("App Red"), Color("App Yellow")] : [Color.clear]
                                        ),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                    
                }
                CustomButton(ButtonTitle: "Continue", ButtonType: .GenderSelect ,View: AnyView(NameView())).padding(.all)
            }.padding(20)
            
            
            Spacer()
            
        }
    }
    
    
}

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left").font(.system(size: 20)).bold()
            }
            Spacer()
        }.foregroundColor(.black).padding(.leading)
    }
}

struct GenderSelect: View {
    @State var GenderType: String
    
    var body: some View {
        VStack {
            Image(GenderType).resizable().frame(width: 120, height: 120, alignment: .center)
            Text(GenderType).fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 20))
        }
    }
}

struct NameView:View{
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    
    var body: some View {
       
        VStack{
            BackButton().padding(.top)
            Spacer(minLength: 20)
            ScrollView {
                VStack(alignment: .center,spacing: 20 ) {
//                    Image("Name Select").resizable().frame(width: 180, height: 150, alignment: .center)
                    VStack(alignment: .leading,spacing: 20 ) {
                        Text("What’s your name?").fontWeight(.heavy).foregroundColor(Color.primary).font(.custom("Avenir", size: 20))
                        HStack {
                           // Image("User").font(.custom("Avenir", size: 16))
                            TextField("John Doe", text: $CreateAccountVM.Name).font(.custom("Avenir", size: 16))
                        }.padding().frame(height: 60).background(RoundedRectangle(cornerRadius: 10)
                            
                            .foregroundColor(.white))
                            
                        Spacer()
                        
                        
                    }.padding(.horizontal ,20)
                    
                }.padding(0)
                
               
            }
            Text("We never share this with anyone. It won't be on your profile.")
                .frame(width: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(-10)
            CustomButton(ButtonTitle: "Create account", ButtonType: .Name ,View: AnyView(GenderSelectionView()), fontSize: 22).cornerRadius(30).padding(.all)
            Spacer()
            
        }.background( Color(Color("App Background")))
    }
    
    
}


struct DateView:View{
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    
    @State private var Age = 0
    
    var body: some View {
        VStack{
            BackButton().padding(.top,30)
            
            VStack(alignment: .center,spacing: 20 ) {
                Image("Date Select").resizable().frame(width: 180, height: 150, alignment: .center)
                VStack(alignment: .leading,spacing: 20 ) {
                    Text("What is your date of birth?").fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 20))
                    
                    DatePicker(
                        "", selection: $CreateAccountVM.dateofBirth,
                        in: ...Date(),
                        displayedComponents: [.date]
                    ).datePickerStyle(.wheel).accentColor(.teal)
                        .onChange(of: CreateAccountVM.calculateAge(birthdate: CreateAccountVM.dateofBirth)) { newValue in
                            Age = newValue
                        }
                    
                    Text("You’re \(Age) years old").fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 20))
                    
                    CustomButton(ButtonTitle: "Continue", ButtonType: .dateofBirth ,View: AnyView(ProfilePictureView())).padding(.all)
                }.padding(.horizontal ,20)
            }.padding(20)
            Spacer()
        }
    }
}


struct ProfilePictureView:View {
    
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    @ObservedObject var ImagePickerVM = ImagePickerViewModel()
    @State var SafetydatingLinkOpen = false
    @State var FaqsLinkOpen = false
    @State var CommunityLinkOpen = false
    @State var SiteLinkOpen = false
    var body: some View {
        VStack{
            ZStack {
                BackButton()
                Text("Upload profile picture").fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 20))
            }.padding(.top)
            
            VStack(alignment: .center,spacing: 20 ) {
                ZStack (alignment: .bottomTrailing){
                    Image(uiImage: (ImagePickerVM.selectedImage ?? UIImage(named: "Profile User 1"))!).resizable().frame(width: 120, height: 120, alignment: .center).cornerRadius((ImagePickerVM.selectedImage != nil) ? 60 : 0)
                    Image("Edit icon").resizable().frame(width: 45, height: 45).onTapGesture {
                        ImagePickerVM.selectImage()
                    }.onChange(of: ImagePickerVM.selectedImage) { newValue in
                        if let newImage = newValue {
                            CreateAccountVM.SelectedProfileUIImage = newImage
                        }
                    }
                }
                VStack(alignment: .center,spacing: 5 ) {
                    Text(CreateAccountVM.Name).fontWeight(.medium).foregroundStyle(LinearGradient(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)).font(.custom("Avenir", size: 18))
                    Text(CreateAccountVM.Email).fontWeight(.medium).font(.custom("Avenir", size: 15)).foregroundColor(.gray)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Image("Smile").frame(width: 20, height: 20)
                            Text("Safety Dating Tips").fontWeight(.regular).font(.custom("Avenir", size: 15)).foregroundColor(.primary)
                        }.onTapGesture {
                            SafetydatingLinkOpen.toggle()
                        }.navigationDestination(isPresented: $SafetydatingLinkOpen, destination: {
                            WebViewContainer(urlString: "https://godterest.com/safety-dating-tips/")
                        })
                        HStack{
                            Image("Sunglass").frame(width: 20, height: 20)
                            Text("FAQ's").fontWeight(.regular).font(.custom("Avenir", size: 15)).foregroundColor(.primary)
                        }.onTapGesture {
                            FaqsLinkOpen.toggle()
                        }.navigationDestination(isPresented: $FaqsLinkOpen, destination: {
                            WebViewContainer(urlString: "https://godterest.com/faqs/")
                        })
                        HStack{
                            Image("Users_Group").frame(width: 20, height: 20)
                            Text("Community Guidelines").fontWeight(.regular).font(.custom("Avenir", size: 15)).foregroundColor(.primary)
                        }.onTapGesture {
                            CommunityLinkOpen.toggle()
                        }.navigationDestination(isPresented: $CommunityLinkOpen, destination: {
                            WebViewContainer(urlString: "https://godterest.com/community-guidelines/")
                        })
                    }.frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray).opacity(0.3))
                        .padding(.vertical,25)
                    
                    HStack{
                        Image("Shield").frame(width: 20, height: 20)
                        Text("We are here for you").fontWeight(.regular).font(.custom("Avenir", size: 15)).foregroundColor(.primary)
                            .onTapGesture {
                                SiteLinkOpen.toggle()
                            }.navigationDestination(isPresented: $SiteLinkOpen, destination: {
                                WebViewContainer(urlString: "https://godterest.com/support/")
                            })
                    }
                    .frame(maxWidth: .infinity,alignment:.leading).padding(.top)
                    
                    Text("Should you have any questions or concerns when building your profile contact us at support.").fontWeight(.regular).font(.custom("Avenir", size: 15)).foregroundColor(.gray)
                        .frame(maxWidth: .infinity,alignment:.leading).padding(.top,2)
                    
                    CustomButton(ButtonTitle: "Continue", ButtonType: .ProfilePic ,View: AnyView(AddMorePhotos())).padding(.all)
                }.padding(.horizontal ,20)
                
            }.padding(20)
            
            
            Spacer()
            
        }
    }
    
    
}


struct AddMorePhotos: View {
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    @State var IsntaOn: Bool = false
    @State var ShowToast: Bool = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State var images: [UIImage] = []
    
    var body: some View {
        VStack(alignment: .leading){
            BackButton().padding(.top).offset(y: 15)
            
            AddText(TextString: "Add More Photos", TextSize: 20,FontWeight: .medium)
                .padding(.horizontal,30)
                .padding(.top,30)
            
            AddText(TextString: "Pick some photos that reflect the real you", TextSize: 16,Color: .gray)
                .padding(.horizontal,30)
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(),spacing: 20),
                    GridItem(.flexible(),spacing: 20),
                    GridItem(.flexible(),spacing: 20)
                ],spacing: 30) {
                    ForEach(Array(CreateAccountVM.images.enumerated()), id: \.1) { index, image in
                        Image(uiImage: image).resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .mask(RoundedRectangle(cornerRadius: 20))
                            .frame(width: 100, height: 100)
                            .overlay{
                                Image(systemName: "xmark.circle.fill").background(Circle().fill(.white).padding(3)).frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.topTrailing).font(.system(size:30)).offset(x: 10, y: -5)
                                    .gradientText(colors: [Color("App Red"), Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
                                    .onTapGesture {
                                        DispatchQueue.main.async {
                                            
                                            self.images.remove(at: index)
                                            CreateAccountVM.images.remove(at: index)
                                            selectedItems.remove(at: index)
                                        }
                                    }
                            }
                    }
                    
                    // Placeholder rectangle with "Add More" button
                    if CreateAccountVM.images.isEmpty || CreateAccountVM.images.count % 5 != 0 {
                        PhotosPicker(selection: $selectedItems, matching: .images) {
                            RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 2, lineCap: CGLineCap.square,  dash: [4,6], dashPhase: 24)).padding(.top,2)
                                .gradientText(colors: [Color("App Red"), Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
                                .frame(width: 90, height: 90)
                                .overlay(Image("camera"))
                        }
                        .onChange(of: selectedItems) { selectedItems in
                            images = []
                            CreateAccountVM.images = []
                            for item in selectedItems {
                                item.loadTransferable(type: Data.self) { result in
                                    switch result {
                                    case .success(let imageData):
                                        if let imageData = imageData {
                                            
                                            DispatchQueue.main.async {
                                                self.images.append(UIImage(data: imageData)!)
                                                CreateAccountVM.images = self.images
                                            }
                                        } else {
                                            print("No supported content type found.")
                                        }
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                            }
                        }
                    }
                }.padding(.all,20)
            }.frame(height: 270)
            
            
            Toggle("Connect your Instagram", isOn: $IsntaOn)
                .fontWeight(.medium)
                .font(.custom("Avenir", size: 18))
                .foregroundColor(.primary)
                .padding(.horizontal,30)
                .padding(.top,20)
                .disabled(true)
                .onTapGesture {
                    ShowToast.toggle()
                }
            
            AddText(TextString: "Connecting your Instagram will show your latest posts. We value your privacy and will not show your username", TextSize: 16,Color: .gray)
                .padding(.horizontal,30)
                .padding(.bottom,20)
            
            Spacer()
            
            CustomButton(ButtonTitle: "Continue", ButtonType: .OtherPics ,View: AnyView(AddHobbies()))
                .padding(.horizontal,30)
            
            Spacer()
        }.toast(isPresenting: $ShowToast){
            AlertToast(displayMode: AlertToast.DisplayMode.alert, type: .regular, title: "Coming Soon...")
            
        }
    }
}


struct AddHobbies: View {
    
    @EnvironmentObject var CreateAccountVM : QuestionsVM
    @State var IsntaOn: Bool = false
    @State var ShowToast: Bool = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State var images: [UIImage] = []
    
    var body: some View {
        VStack{
            ZStack {
                BackButton()
            }.padding(.top)
            VStack(alignment: .leading) {
                VStack(alignment: .leading,spacing: 05 ) {
                    AddText(TextString: "Let's start with the basics. Your hobbies helps us find the perfect match.", TextSize: 22, FontWeight: .bold).padding(.top)
                    AddText(TextString: "Please select any four", TextSize: 20, FontWeight: .regular)
                    Divider().offset(y: 5)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], spacing: 15) {
                            ForEach(CreateAccountVM.hobbies, id: \.self) { hobby in
                                Button(action: {
                                    self.toggleSelection(for: hobby)
                                }) {
                                    
                                    HStack {
                                        Text(hobby).frame(maxWidth: .infinity,alignment:.leading)
                                            .background(.blue.opacity(0.00005))
                                            .fontWeight(.medium)
                                            .font(.custom("Avenir", size: 18)).foregroundColor(Color.primary).minimumScaleFactor(0.2)
                                        if CreateAccountVM.selectedHobbiesArray.contains(hobby) {
                                            Image("ic_checked").frame(width: 20, height: 20, alignment: .center)
                                                .aspectRatio(contentMode: .fill)
                                        }else {
                                            Image("ic_uncheck").frame(width: 20, height: 20, alignment: .center)
                                                .aspectRatio(contentMode: .fill)
                                        }
                                    }
                                    .lineLimit(1)
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width / 2 - 30) // 165
                                    .background(Color.white)
                                    .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.top)
                    }
                    
                    Spacer()
                    CustomButtonOnboarding(ButtonTitle: "Continue", ButtonType: .Hobbies ,View: AnyView(QuestionsViewNew())).disabled(CreateAccountVM.selectedHobbiesArray.count < 4)
                }.padding(.horizontal ,20)
                
            }
            Spacer()
        }.background(Color("App Background"))
    }
    
    private func getSelectedHobbiesString() -> String {
        return CreateAccountVM.selectedHobbiesArray.joined(separator: ",")
    }
    
    
    private func toggleSelection(for hobby: String) {
        if CreateAccountVM.selectedHobbiesArray.contains(hobby) {
            CreateAccountVM.selectedHobbiesArray.removeAll { $0 == hobby }
        } else {
            if CreateAccountVM.selectedHobbiesArray.count < 4 { // Add this condition to check the limit
                CreateAccountVM.selectedHobbiesArray.append(hobby)
            } else {
                // Optionally, you can show a toast or alert to inform the user they've reached the limit.
                ShowToast = true
            }
        }
        let selectedHobbiesString = getSelectedHobbiesString()
        CreateAccountVM.SelectedHobbies = selectedHobbiesString
        print(CreateAccountVM.SelectedHobbies)
    }
}

struct AddText: View {
    @State var TextString:String
    @State var TextSize:CGFloat
    @State var Color:Color?
    @State var FontWeight:Font.Weight? = .regular
    @State var Alignment:Alignment? = .leading
    @State var FontFamily = "Avenir"
    var body: some View {
        Text(TextString).fontWeight(FontWeight).font(.custom(FontFamily, size: TextSize)).foregroundColor(Color)
            .frame(maxWidth: .infinity,alignment: Alignment ?? .center)
        
    }
}

struct AddTextwithgradint: View {
    @State var TextString:String
    @State var TextSize:CGFloat
    @State var Font:Font?
    @State var FontWeight:Font.Weight? = .regular
    var body: some View {
        Text(TextString).fontWeight(FontWeight).font(Font ??  .custom("Avenir", size: TextSize))
            .gradientText(colors: [Color("App Red"), Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
    }
}
