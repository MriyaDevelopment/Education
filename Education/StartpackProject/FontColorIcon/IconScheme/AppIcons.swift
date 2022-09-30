//
//  AppIcons.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//


import UIKit

final class AppIcons {
    
    enum iconsEnum {
        case i_back_button_detail
        case i_back_button_profile
        case i_calendar_icon
        case i_email_icon
        case i_eye_close_image
        case i_eye_image
        case i_password_icon
        case i_user_icon
        case i_heart_input

    }
    
    static func getIcon(_ type: iconsEnum) -> UIImage {
        switch type {
        case .i_back_button_detail: return UIImage(named: "i_back_button_detail")!
        case .i_back_button_profile: return UIImage(named: "i_back_button_profile")!
        case .i_calendar_icon: return UIImage(named: "i_calendar_icon")!
        case .i_email_icon: return UIImage(named: "i_email_icon")!
        case .i_eye_close_image: return UIImage(named: "i_eye_close_image")!
        case .i_eye_image: return UIImage(named: "i_eye_image")!
        case .i_password_icon: return UIImage(named: "i_password_icon")!
        case .i_user_icon: return UIImage(named: "i_user_icon")!
        case .i_heart_input: return UIImage(named: "i_heart_input")!
        }
    }
}
