//
//  InputForm.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit
import InputMask

class InputForm: UIView {
    
    //MARK: Closures
    
    var clickedSuggestionItem: IntClosure?
    var valueChanged: StringClosure?
    
    //MARK: Fields
    
    lazy var nextForm: InputForm? = nil {
        didSet {
            textField.returnKeyType = .next
        }
    }
    
    let type: InputFormType
    let placeholder: String
    let topTitleText: String
    let bottomErrorText = ""
    let isFilledState = false
        
    var isUserInput = true
    
    var isValid = false
    
    var inputMask: MaskedTextFieldDelegate!
    
    var predicate: NSPredicate?
    
    var initialTitleLabelWidth: CGFloat = 0
        
    //MARK: UIElements
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_1B1919.uiColor()
        label.font = MainFont.regular(size: 16)
        label.text = topTitleText
        return label
    }()
    
    let leftImage: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFit
       imageView.isHidden = true
       return imageView
   }()
    
     let rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_1B1919.uiColor()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_A5A7AD.uiColor()
        label.font = MainFont.regular(size: 16)
        label.text = placeholder
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = MainFont.regular(size: 16)
        return textField
    }()
    
    lazy var bottomErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_E73626.uiColor()
        label.font = MainFont.regular(size: 16)
        label.isHidden = true
        return label
    }()
    
    init(type: InputFormType, topTitleText: String, placeholder: String) {
        self.type = type
        self.topTitleText = topTitleText
        self.placeholder = placeholder
        super.init(frame: .zero)
        textField.delegate = self
        addElements()
        addTargets()
        configure()
    }
    
    convenience init(type: InputFormType) {
        self.init(type: type, topTitleText: "", placeholder: "DAY/ MONTH/ YEAR")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValue(_ value: String?) {
        isUserInput = false
        
        guard let text = textField.text,
              let value = value,
              text.isEmpty != value.isEmpty else { return }
        
        titleLabel.hideView()
        textField.text = value
    }
    
    func getValue() -> String {
        guard let text = textField.text else { return "" }
        return text
    }
    
    private func configure() {
        switch type {
        case .email:
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            leftImage.isHidden = false
            leftImage.image = AppIcons.getIcon(.i_email_icon)
            let firstpart = "[A-Z0-9a-z_%+-]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
            let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
            let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
            predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        case .name:
            textField.autocapitalizationType = .words
            leftImage.isHidden = false
            leftImage.image = AppIcons.getIcon(.i_user_icon)
        case .password:
            textField.isSecureTextEntry = true
            textField.autocapitalizationType = .none
            leftImage.isHidden = false
            rightImage.isHidden = false
            leftImage.image = AppIcons.getIcon(.i_password_icon)
            rightImage.image = AppIcons.getIcon(.i_eye_image)
        case .calendar:
            leftImage.isHidden = false
            rightImage.isHidden = false
            rightImage.image = AppIcons.getIcon(.i_calendar_icon)
            titleLabel.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            textField.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        case .text:
            titleLabel.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            textField.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            textField.autocapitalizationType = .words
        case .partnerName:
            leftImage.isHidden = false
            rightImage.isHidden = false
            rightImage.image = AppIcons.getIcon(.i_heart_input)
            titleLabel.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            textField.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        }
    }
    
    private func addTargets() {
        textField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldClicked)))
        if type == .password {
            rightImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePasswordAction)))
        }
    }
    
    @objc private func hidePasswordAction() {
        textField.isSecureTextEntry.toggle()
        rightImage.image = textField.isSecureTextEntry ?
        AppIcons.getIcon(.i_eye_image) : AppIcons.getIcon(.i_eye_close_image)
    }
    
    @objc private func textFieldClicked() {
        startEditing()
    }
    
    func startEditing() {
        textField.becomeFirstResponder()
    }
    
    func endEditing() {
        textField.endEditing(true)
    }
    
    func showError(type: InputFormType) {
        switch type {
        case .password:
            bottomErrorLabel.isHidden = false
            bottomErrorLabel.text = "Passwords don’t match"
        default:
            break
        }
    }
    
    func hideError() {
        bottomErrorLabel.isHidden = true
    }
    
}

extension InputForm: MaskedTextFieldDelegateListener {
    func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        guard let text = textField.text else { return }
        if isUserInput {
            isUserInput = true
            valueChanged?(text)
        }
    }
}
