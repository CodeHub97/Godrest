//
//  ColorSchemeVM.swift
//  Godterest
//
//  Created by Varjeet Singh on 17/09/23.
//

import Foundation
import SwiftUI


class ColorSchemeVM: ObservableObject {
  @Published var SelectedColorScheme:ColorScheme = .light
}
