//
//  EnableLocation.swift
//  Godterest
//
//  Created by Varjeet Singh on 11/09/23.
//

import SwiftUI

struct EnableLocation: View {
    @State var LocationEnabled = false
  @ObservedObject var locationViewModel = LocationViewModel.shared

    var body: some View {
        if LocationEnabled {
            HomePage()
        } else {
            VStack {
                Spacer()
                Image("Lady")
                AddText(TextString: "Ready to meet your future partner?", TextSize: 22, FontWeight: .bold)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)

                AddText(TextString: "Enable location permission to start seeing Christian singles nearby", TextSize: 18, Color: Color.gray, FontWeight: .bold)
                    .multilineTextAlignment(.center)

                Spacer()

                VStack {
                  Text("Latitude: \(LocationViewModel.shared.currentLocation?.coordinate.latitude ?? 0.0)")
                  Text("Longitude: \(LocationViewModel.shared.currentLocation?.coordinate.longitude ?? 0.0)")
                }

                Button("Request Permission") {
                  locationViewModel.askLocation()
                }
                .padding(30)
                .onChange(of: LocationViewModel.shared.authorizationStatusDescription) { newValue in
                  if newValue == "Authorized"{
                    LocationEnabled = true
                  }
                }
            }
            .padding()
        }
    }
}


struct EnableLocation_Previews: PreviewProvider {
    static var previews: some View {
        EnableLocation()
    }
}
