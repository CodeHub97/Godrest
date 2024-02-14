//
//  SessionManager.swift
//  Godterest
//
//  Created by Sandip Gill on 30/09/23.
//

import UIKit
import SwiftUI

struct SessionManager: EnvironmentKey {
    static var defaultValue: Bool = false // Set your default value here
}

extension EnvironmentValues {
    var isLoggedIn: Bool {
        get { self[SessionManager.self] }
        set { self[SessionManager.self] = newValue }
    }
}


