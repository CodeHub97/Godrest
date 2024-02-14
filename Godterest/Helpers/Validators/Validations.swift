//
//  Validations.swift
//  Godterest
//
//  Created by Varjeet Singh on 22/09/23.
//

import Foundation


struct Validation {
    static func isEmailValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

  static func isPasswordValid(_ password: String) -> Bool {
      let passwordRegex = "^(?=.*[a-zA-Z])(?=.*\\d)[a-zA-Z\\d!@#$%^&*()_+\\-=\\[\\]{};':\",.<>]{8,}$"
      let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
      return passwordPredicate.evaluate(with: password)
  }

}
