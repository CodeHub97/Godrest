//
//  ProfileDetails.swift
//  Godterest
//
//  Created by Varjeet Singh on 21/09/23.
//

import SwiftUI


enum iPhoneModel: String, CaseIterable {
    
    case iPhone15ProMax
    case iPhone15Plus
    case iPhone14ProMax
    case iPhone14Plus
    case iPhone13ProMax
    case iPhone12ProMax
    case iPhone11ProMax
    case iPhoneXSMax
    case iPhone15Pro
    case iPhone15
    case iPhone14Pro
    case iPhone14
    case iPhone13
    case iPhone13Pro
    case iPhone12
    case iPhone12Pro
    case iPhone11Pro
    case iPhoneXS
    case iPhoneX
    case iPhone13Mini
    case iPhone12Mini
    case iPhone8Plus7Plus6sPlus6Plus
    case iPhone11XRSE2ndGen
    case iPhoneSE3rdGen
    case iPhoneSE1stGen5C5S5
    case iPhone4S43GS3G1stGen
    
    var physicalHeight: Double {
        switch self {
        case .iPhone15ProMax, .iPhone15Plus, .iPhone14ProMax, .iPhone14Plus: return 2796.0
        case .iPhone13ProMax, .iPhone12ProMax, .iPhone11ProMax: return 2778.0
        case .iPhoneXSMax: return 2688.0
        case .iPhone15Pro, .iPhone15, .iPhone14Pro, .iPhone14: return 2556.0
        case .iPhone13, .iPhone13Pro, .iPhone12, .iPhone12Pro: return 2532.0
        case .iPhone11Pro, .iPhoneXS, .iPhoneX: return 2436.0
        case .iPhone13Mini, .iPhone12Mini, .iPhone8Plus7Plus6sPlus6Plus: return 2340.0
        case .iPhone11XRSE2ndGen, .iPhoneSE3rdGen: return 1334.0
        case .iPhoneSE1stGen5C5S5: return 1136.0
        case .iPhone4S43GS3G1stGen: return 480.0
        }
    }
}

struct ProfileDetails: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var MatchedViewModel = MatchedVM()
    @State var UserProfile : ProfileDatum?
    @State var ShowImage = false
    @State var isDisplayActionSheet = false
    @State var Hobbies:[String] = []
    
    @State private var isPresentingReportScreen = false
    @State private var selectedReportText: String? {
        didSet{
            print("After Selected Data \(selectedReportText)")
            if selectedReportText != nil && selectedReportText != ""{
                let userId = UserProfile?.id ?? 0
                self.MatchedViewModel.reportUser(otherUserId: userId, reason: "Report") { status in
                    if status {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

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
        print("currentModel is: ", currentModel,"Current Height is: ",currentHeight)
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

    @State var OtherPics :[String] = []
    
    var body: some View {
        VStack{
            ZStack(alignment: .trailing) {
                BackButton()
                
                HStack {
                    AddText(TextString: UserProfile?.name ?? "Name", TextSize: 20, FontWeight: .medium, Alignment: .center)
                    Spacer() // Pushes the "dots" image to the rightmost side
                }
                
                HStack {
                    AddText(TextString: "\(getAge(dateString: UserProfile?.dob ?? ""))", TextSize: 20, FontWeight: .medium, Alignment: .trailing)
                        .padding(.trailing, 8) // Add some padding to create space between age and "dots"
                    
                    Image("dots")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.isDisplayActionSheet.toggle()
                        }
                }
            }.padding(.top)

            ScrollView {
                VStack {
                    
                    ZStack (alignment: .bottom){
                               
                        
                        if let url = URL(string:
                                            APIConstants.s3BucketUrl + (UserProfile?.profilePic ?? "")) {
                            AsyncImage(url: url) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height/2.2, alignment: .center)
                                        .cornerRadius(20)
                                    
                                        .padding(30)
                                    
                                } else {
                                    
                                    Image(UserProfile?.gender == "Female" ? "FemalePlaceholder" : "MalePlaceholder")
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
                            AddText(TextString: UserProfile?.name ?? "Lorea", TextSize: getValueForCurrentDevice(type: "Fonts") + 13,Color: Color.white,FontWeight: .bold, Alignment: .leading,FontFamily: "Grandista").shadow(color: .black.opacity(0.5), radius: 4, x: 1, y: 0.5)
                            HStack {
                                Image("globe").resizable().frame(width: 15, height: 15)
                                AddText(TextString: "\(UserProfile?.address?.city ?? "LAKESIDE") • 20 KMS AWAY", TextSize: getValueForCurrentDevice(type: "Fonts") + 4,Color: Color.white,FontWeight: .bold).shadow(color: .black.opacity(0.5), radius: 4, x: 1, y: 0.5)
                                
                                Spacer()
                            }
                            HStack {
                                CapsuleLabelSmall(imagename: "suitcase", Title: UserProfile?.profession ?? "Designer",Color: Color.white,FontSize: getValueForCurrentDevice(type: "Fonts"))
                                CapsuleLabelSmall(imagename: "Denominater", Title: UserProfile?.denomination ?? "Moderately Practicing",Color: Color.white,FontSize: getValueForCurrentDevice(type: "Fonts"))
                                
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
                                CapsuleLabel(imagename: "height", Title: UserProfile?.tall ?? "157 cm ( 5.3 )",FontSize: getValueForCurrentDevice(type: "Fonts") )
                            }
                            
                            VStack(alignment: .trailing) {
                                AddText(TextString: "Marital Status", TextSize: 12,FontWeight: .medium,Alignment: .trailing)
                                CapsuleLabel(imagename: "rings", Title: UserProfile?.maritalStatus ?? "Never  Married",FontSize: getValueForCurrentDevice(type: "Fonts") )
                            }
                            
                            
                            Spacer()
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                AddText(TextString: "Have Kids", TextSize: 12,FontWeight: .medium)
                                CapsuleLabel(imagename: "children", Title: UserProfile?.children ?? "Doesn't have kids",FontSize: getValueForCurrentDevice(type: "Fonts") )
                            }
                            VStack(alignment: .trailing) {
                                AddText(TextString: "Want Kids", TextSize: 12,FontWeight: .medium,Alignment: .trailing)
                                CapsuleLabel(imagename: "diamond", Title: UserProfile?.childrenInFuture ?? "Yes",FontSize: getValueForCurrentDevice(type: "Fonts") )
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
                                            Image(UserProfile?.gender == "Female" ? "FemalePlaceholder" : "MalePlaceholder")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .mask(RoundedRectangle(cornerRadius: 20))
                                                .frame(width: 100, height: 100)
                                            
                                        }
                                    }
                                    .navigationDestination(isPresented: $ShowImage) {
                                        ZoomImage(SelectedImage: index, Gender: UserProfile?.gender ?? "Male", ShowImages: OtherPics)
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
                Hobbies = UserProfile?.hobbies?.components(separatedBy: ",") ?? ["Social Media","Travelling","Gym","18+"]
                
            }.actionSheet(isPresented: $isDisplayActionSheet) {
                ActionSheet(title: Text("Report/Block"), message: Text(""), buttons: [
                    .default(Text("Block")) { 
                            let userId = UserProfile?.id ?? 0
                            self.MatchedViewModel.blockUser(otherUserId: userId, reason: "Block") { status in
                                if status {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                    },
                    .default(Text("Report")) {
                        print("Before Selected Data \(selectedReportText)")
                        selectedReportText = ""
                        isPresentingReportScreen.toggle()
                    },
                    .cancel() {
//                        self.
                    }
                ])
            }
            .fullScreenCover(isPresented: $isPresentingReportScreen) {
                ReportOtherUserView(selectedData: $selectedReportText)
            }
    }
}


struct ProfileDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Group {
            ProfileDetails().environmentObject(ColorSchemeVM())
                .previewDevice("iPhone 8")
                .previewDisplayName("iPhone 8")
            
            ProfileDetails().environmentObject(ColorSchemeVM())
                .previewDevice("iPhone 14 Pro")
                .previewDisplayName("iPhone 14 Pro")
            
            ProfileDetails().environmentObject(ColorSchemeVM())
                .previewDevice("iPhone 14 Pro Max")
                .previewDisplayName("iPhone 14 Pro Max")
        }
    }
}

struct CapsuleLabel: View {
    @State var imagename:String
    @State var Title:String
    @State var Color:Color?
    @State var FontSize:Double?
    
    var body: some View {
        HStack(spacing: 10){
            Image(imagename).resizable().frame(width: 15, height: 15)
            Text(Title).foregroundColor(Color ?? .black)
        }
        .padding(.horizontal)
        .padding(.vertical,5)
        .background(Capsule().fill(Material.ultraThinMaterial).background(Capsule().fill(.gray.opacity(0.3)))).font(.custom("Avenir", size: FontSize ?? 14))
    }
}

struct CapsuleLabelWithoutImage: View {
    @State var imagename:String
    @State var Title:String
    @State var Color:Color?
    @State var FontSize:Double?
    
    var body: some View {
        Text(Title).foregroundColor(Color ?? .black)
            .lineLimit(1)
            .padding(.horizontal,10)
            .padding(.vertical,5)
            .background(Capsule().fill(Material.ultraThinMaterial).background(Capsule().fill(.gray.opacity(0.3)))).font(.custom("Avenir", size: FontSize ?? 14))
    }
}

struct CapsuleLabelSmall: View {
    
    @State var imagename:String
    @State var Title:String
    @State var Color:Color?
    @State var FontSize:Double?
    
    var body: some View {
        HStack(spacing: 4){
            Image(imagename).resizable().frame(width: 13, height: 13)
            Text(Title).font(.custom("Avenir", size: FontSize ?? 14)).foregroundColor(Color ?? .black)
        }
        .padding(.horizontal,6)
        .padding(.vertical,5)
        .background(Capsule().foregroundColor(.black.opacity(0.4))).font(.custom("Avenir", size:  11))
    }
}
