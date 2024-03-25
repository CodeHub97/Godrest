//
//  HomePage.swift
//  Godterest
//
//  Created by Varjeet Singh on 13/09/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomePage: View {
    @EnvironmentObject var ColorschemeViewModel:ColorSchemeVM
    @ObservedObject var AccountSetupViewModel = QuestionsVM.Shared
    @State var selectedTab = 0
    var body: some View {
        
        VStack(spacing: 0){
            
            if !AccountSetupViewModel.isDataLoaded{
                ProgressView("loading...").font(.custom("Grandista", size: 16)) .gradientText(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
            }else{
                VStack(spacing: 0){
                    if AccountSetupViewModel.allProfiles.isEmpty{
                        VStack {
                            Text("No more users yet...")
                                .font(.custom("Grandista", size: 22))
                                .gradientText(colors: [Color("App Red"),Color("App Yellow")], startPoint: .leading, endPoint: .trailing)
                        }.frame(maxWidth: .infinity,maxHeight:.infinity).background(.black).ignoresSafeArea()
                        
                    }else{
                        VStack(spacing: 0) {
                            GeometryReader { size in
                                TabView(selection: $selectedTab) {
                                    ForEach(AccountSetupViewModel.allProfiles, id: \.id) { profile in
                                        ContentHome(size: size, Imager: profile.profilePic ?? "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80", Name: profile.name ?? "", Gender: profile.gender ?? "Male", PersonUserID: profile.id ?? 2,UserProfile: profile).id(profile.id) // Set explicit identity
                                            .frame(width: size.size.width)
                                            .rotationEffect(Angle(degrees: -90))
                                            .ignoresSafeArea()
                                        
                                    }
                                }.rotationEffect(Angle(degrees: 90))
                                    .frame(width: size.size.height)
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                    .frame(width: size.size.width)
                                    .ignoresSafeArea()
                                
                            }
                            .background(.black)
                            .onAppear {
                                
                            }
                        }.ignoresSafeArea()
                    }
                    Rectangle().fill(Material.ultraThinMaterial.opacity(0.5)).frame(height: 1)
                }.background(Material.ultraThinMaterial.opacity(0.5))
            }
        }.onAppear{
            ColorschemeViewModel.SelectedColorScheme = .dark
           // AccountSetupViewModel.HitAllProfileList()
            
            AccountSetupViewModel.getNearbyUsers()
            
            //      AccountSetupViewModel.allProfiles.append(AccountSetupViewModel.profile1)
        }
        .onDisappear{
            ColorschemeViewModel.SelectedColorScheme = .light
        }
        .preferredColorScheme(ColorschemeViewModel.SelectedColorScheme)
    }
}

struct ContentHome: View {
    @State var size:GeometryProxy
    @State var Imager:String
    @State var Name:String
    @State var Gender:String
    @State var PersonUserID:Int
    @State var UserProfile:ProfileDatum
    @ObservedObject var AccountSetupViewModel = QuestionsVM.Shared
    var body: some View {
        ZStack(alignment: .top){
            Rectangle().foregroundColor(.gray)
            
            GeometryReader { geometry in
                Rectangle().foregroundColor(.white)
                AsyncImage(
                    url: URL(string: APIConstants.s3BucketUrl + Imager)
                ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .overlay{
                            LinearGradient(colors: [Color.clear,Color.clear,Color.clear,Color.black.opacity(0.2),Color.black.opacity(0.6),Color.black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                        }
                } placeholder: {
                    Image(Gender == "Female" ? "FemalePlaceholder" : "MalePlaceholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .overlay{
                            ZStack{
                                LinearGradient(colors: [Color.clear,Color.clear,Color.black.opacity(0.2),Color.black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                            }
                            ProgressView()
                        }
                }
            }
            
            VStack(spacing: 0) {
                VStack(alignment: .leading,spacing: 0){
                    Spacer()
                    HStack {
                        Image("Planet").resizable().frame(width: 30, height: 30)
                        AddText(TextString: "\(UserProfile.address?.city ?? "Lakeside"),\(UserProfile.address?.state ?? "USA")", TextSize: 15,Color: .white,FontWeight: .bold).shadow(color: .black.opacity(0.8), radius: 3, x: 1, y: 0.5)
                    }.padding(.horizontal)
                    HStack {
                        
                        NavigationLink {
                            HomeProfileDetails(UserProfileHomepage: UserProfile,OtherPics: UserProfile.otherPic?.components(separatedBy: ",") ?? [])
                        } label: {
                            
                            HStack {
                                AddText(TextString: Name, TextSize: 25,Color: .white,FontWeight: .bold,FontFamily: "Grandista").background(.white.opacity(0.002)).shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 0)
                                Image("verifier").resizable().frame(width: 25, height: 25)
                            }
                        }
                    }.padding(.horizontal)
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack {
                            ForEach(UserProfile.hobbies?.components(separatedBy: ",") ?? ["Travelling","Gym","18+"],id: \.self) { hobby in
                                TagView(Tag: hobby)
                            }
                        }
                    }.padding(.horizontal).frame(height: 40)
                    HStack{
                        Spacer()
                        Button {
                            AccountSetupViewModel.hitLikeRejectApi(ProfilesUserID: PersonUserID, isLiked: 0,isReject: 1)
                        } label: {
                            Image("Cross Btn")
                        }
                        Spacer()
                        
                        NavigationLink {
                            ChatScreen(selectedTab: .constant(2),showback: true)
                        } label: {
                            Image("Msg Btn")
                        }
                        
                        Spacer()
                        Button {
                            AccountSetupViewModel.hitLikeRejectApi(ProfilesUserID: PersonUserID, isLiked: 1,isReject: 0)
                        } label: {
                            Image("Like Btn")
                        }
                        Spacer()
                    }.padding(.top)
                    Spacer().frame(height: 10)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomePage().environmentObject(ColorSchemeVM())
                .previewDevice("iPhone 8")
                .previewDisplayName("iPhone 8")
            
            HomePage().environmentObject(ColorSchemeVM())
                .previewDevice("iPhone 14 Pro Max")
                .previewDisplayName("iPhone 14 Pro Max")
        }
    }
}

struct TagView: View {
    var Tag : String
    var body: some View {
        
        
        Text(Tag).shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 0).font(.custom("Avenir", size: 12)).foregroundColor(Color.white).padding(15).background{
            Capsule().frame( height: 30).foregroundColor(.gray.opacity(0.7)).shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 0)
        }
    }
}
