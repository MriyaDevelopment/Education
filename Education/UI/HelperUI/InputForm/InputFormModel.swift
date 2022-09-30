//
//  InputFormModel.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Foundation

enum InputFormType {
    case email
    case name
    case text
    case password
    case calendar
    case partnerName
}

enum InputFormState {
    case disable
    case errorFilled
    case errorNotFilled
    case normal
}
