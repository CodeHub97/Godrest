//
//  Modifiers.swift
//  Godterest
//
//  Created by Varjeet Singh on 18/09/23.
//

import Foundation
import SwiftUI

struct GradientTextModifier: ViewModifier {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint

    init(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    func body(content: Content) -> some View {
        content.foregroundStyle(
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: startPoint,
                endPoint: endPoint
            )
        )
    }
}

extension View {
    func gradientText(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.modifier(GradientTextModifier(colors: colors, startPoint: startPoint, endPoint: endPoint))
    }
}
