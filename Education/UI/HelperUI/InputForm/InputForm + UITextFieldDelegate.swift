//
//  InputForm + UITextFieldDelegate.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

extension InputForm: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if type != .calendar || type != .partnerName {
            titleLabel.isHidden = true
        }
        isUserInput = true

        if type == .calendar {
            if textField.text == "" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM yyyy"
                titleLabel.text = ""
                textField.text = dateFormatter.string(from: Date())
                valueChanged?(dateFormatter.string(from: Date()))
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
              let isValid = predicate?.evaluate(with: text) else { return }
        if !isValid && type == .email {
            bottomErrorLabel.isHidden = false
            bottomErrorLabel.text = "Please enter correct email adress"
        } else {
            self.isValid = isValid
            bottomErrorLabel.isHidden = true
        }
        titleLabel.isHidden = !text.isEmpty && type != .calendar && type != .partnerName
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if type == .text {
            let maxLength = 30
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            result = newString.count <= maxLength
        } else if type == .name || type == .partnerName {
            let maxLength = 15
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            result = newString.count <= maxLength
        }
        return result
    }
}
