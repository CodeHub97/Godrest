//
//  ReportOtherUserView.swift
//  Godterest
//
//  Created by Bajrang Sinha on 22/01/24.
//

import SwiftUI


struct ReportOtherUserView: View {
    var reasonReportArray = [
        "Fake or scammer profile",
        "Rude, sexual, or abusive talk",
        "Asking for money",
        "Advertising or promoting",
        "Behavior outside HOLY app",
        "Inappropriate content",
        "Under 18",
        "I'm just not interested"
    ]
    @State var selectedItem:Int?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedData: String?

    var body: some View {
        VStack{
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark").font(.system(size: 20)).bold()
                }
                Spacer()
            }.foregroundColor(.black).padding(.leading)
            VStack(alignment: .center,spacing: 20 ) {
                VStack(alignment: .leading,spacing: 05 ) {
                    Text("Help keep our community safe").fontWeight(.bold).foregroundColor(Color.primary).font(.custom("Avenir", size: 30))
                    Text("Please report any behavior that is not Christ-honoring. Your report is private and will be reviewed by our team.").fontWeight(.regular).foregroundColor(Color.primary).font(.custom("Avenir", size: 20)).padding(.bottom,20)
                    List(0..<reasonReportArray.count,id:\.self) { index in
                        HStack {
                            Text(reasonReportArray[index]).frame(maxWidth: .infinity,alignment:.leading)
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
                            self.selectedItem = index
                        }.listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                            .listRowBackground(Color("App Background"))
                            .frame(maxWidth: .infinity,alignment:.leading).padding().background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [ Color.gray.opacity(0.25),
                                                  Color.gray.opacity(0.25)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            )
                            .background(Color.white)
                            .cornerRadius(12)
                        
                    }.listStyle(.plain).padding(.horizontal, 0)
                        .background(Color("App Background"))
                    Button {
                        selectedData = reasonReportArray[selectedItem ?? 0]
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Spacer()
                            Text("Done").fontWeight(.bold).foregroundColor(Color.white).font(.custom("Avenir", size: 18))
                            Spacer()
                        }.frame( height: 60, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 30)).foregroundStyle(LinearGradient(colors: [selectedItem != nil ? Color.black : Color.gray , selectedItem != nil ? Color.black : Color.gray ], startPoint: .leading, endPoint: .trailing))
                    }.padding(.top, 10)
                        .disabled(selectedItem == nil)
                }.padding(.horizontal ,0)
            }.padding(20)
            Spacer()
        }.background(Color("App Background"))
    }
}



