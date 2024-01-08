//
//  ViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 04.01.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    var didSendEventClosure: ((Event) -> Void)?
        
    private let titleLabel = UILabel()
    private let signUpLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emailNumberTextField = UITextFieldPadding()
    private let passwordTextField = UITextFieldPadding()
    private let logInButton = UIButton(type: .system)
    private let signUpButton = UIButton(type: .system)
    private var titlesStack = UIStackView()
    private var authorizedStack = UIStackView()
    private var signUpStack = UIStackView()
    var isHaveAccount = true {
        didSet {
            changeAuthVCview()
        }
    }
    
    //MARK: - Life Cycle:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLogInButton()
        setTitlesLabel()
        setTitlesStack()
        setAuthorisedTextFields()
        setAuthorizedStack()
        setSignInStack()
        setAuthorisedButton()
        setConstraint()
    }
    
    //MARK: - @objc Function
    
    @objc func logIn() {
        
        guard let email = emailNumberTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else { return }
        didSendEventClosure?(.logIn(email, password))
    }
    
    @objc func signUpUser() {
        guard let email = emailNumberTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else { return }
        
        didSendEventClosure?(.signUp(email, password))
    }
    
    @objc func goToSignUp() {
        isHaveAccount.toggle()
    }
    
    //MARK: - private Function
    
    private func changeAuthVCview() {
        switch isHaveAccount {
        case true:
            setLogInButton()
        case false:
            setSignUpButton()
        }
    }
    
    //MARK: - constraints:
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            
            titlesStack.topAnchor.constraint(equalTo: navigationItem.titleView?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titlesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titlesStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titlesStack.heightAnchor.constraint(equalToConstant: 150),
            
            authorizedStack.topAnchor.constraint(equalTo: titlesStack.bottomAnchor, constant: 40),
            authorizedStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            authorizedStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorizedStack.heightAnchor.constraint(equalToConstant: 140),
            
            logInButton.topAnchor.constraint(equalTo: authorizedStack.bottomAnchor, constant: 40),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpStack.heightAnchor.constraint(equalToConstant: 50),
            signUpStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            signUpStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

//MARK: - TextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    private func minimizePlaceholder(_ tf: UITextField) {
        UIView.animate(withDuration: 0.3) {
            guard let tf = tf as? UITextFieldPadding else { return }
            tf.configureFrameCustomPlaceHolder(frame: .init(x: 14, y: 3, width: 200, height: 17))
        }
    }
    
    private func expandLabel(_ tf: UITextField) {
        UIView.animate(withDuration: 0.5) {
            guard let tf = tf as? UITextFieldPadding else { return }
            tf.configureFrameCustomPlaceHolder(frame: .init(x: 14, y: 5, width: 200, height: 40))
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailNumberTextField {
            minimizePlaceholder(textField)
        } else {
            minimizePlaceholder(textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.isEmpty else { return }
        if textField == emailNumberTextField {
            expandLabel(textField)
        } else {
            expandLabel(textField)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.endEditing(true)
    }
}

//MARK: - setView elements:

extension LoginViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        let background = UIImageView()
        background.frame = view.bounds
        background.image = ImageConstants.welcomeBackground
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
    }
    
    private func setTitlesLabel() {
        let labels = [titleLabel, descriptionLabel]
        labels.forEach { label in
            label.textAlignment = .left
            label.numberOfLines = 0
            label.textColor = .white
        }
        titleLabel.text = TitleConstants.welcomeApp
        titleLabel.font = UIFont(name: FontsConstants.openSansExtraBold, size: 42)
        descriptionLabel.text = TitleConstants.eventDescriptionApp
        descriptionLabel.font = UIFont(name: FontsConstants.openSansSemiBold, size: 24)
    }
    
    private func setTitlesStack() {
        titlesStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        titlesStack.axis = .vertical
        titlesStack.spacing = 10
        titlesStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titlesStack)
    }
    
    private func setAuthorisedTextFields() {
        let textFields = [emailNumberTextField, passwordTextField]
        let placeholderArray = [TitleConstants.email, TitleConstants.password]
        
        textFields.enumerated().forEach { index, tf in
            tf.delegate = self
            tf.font = .systemFont(ofSize: 19)
            tf.configureCustomPlaceholder(text: placeholderArray[index],
                                          frame: .init(x: 14, y: 5, width: 200, height: 40))
            
            tf.setBorderLayer(backgroundColor: .secondarySystemBackground,
                              borderColor: .lightGray,
                              borderWidth: 1,
                              cornerRadius: 9,
                              tintColor: nil)
        }
        passwordTextField.addSequreAndClearButtons()
        emailNumberTextField.addEmailImageAndClearButton()
        emailNumberTextField.setActivityIndicator()
    }
    
    private func setAuthorizedStack() {
        authorizedStack = UIStackView(arrangedSubviews: [emailNumberTextField,passwordTextField])
        authorizedStack.axis = .vertical
        authorizedStack.spacing = 40
        authorizedStack.distribution = .fillEqually
        authorizedStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorizedStack)
    }
    
    private func setSignUpButton() {
        logInButton.setTitle(TitleConstants.signUpButton, for: .normal)
        logInButton.addTarget(self, action: #selector(signUpUser), for: .touchUpInside)
        signUpButton.setTitle(TitleConstants.logInButton, for: .normal)
        signUpLabel.text = TitleConstants.logInLabel
    }
    
    private func setLogInButton() {
        logInButton.setTitle(TitleConstants.logInButton, for: .normal)
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        signUpButton.setTitle(TitleConstants.signUpButton, for: .normal)
        signUpLabel.text = TitleConstants.signUpLabel
    }
    
    private func setAuthorisedButton() {
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.backgroundColor = ColorConstans.logInColor
        logInButton.tintColor = .label
        logInButton.layer.cornerRadius = 10
        logInButton.layer.borderColor = UIColor.gray.cgColor
        logInButton.layer.borderWidth = 1
        logInButton.titleLabel?.font = UIFont(name: FontsConstants.openSansSemiBold, size: 18)
        view.addSubview(logInButton)
    }
    
    private func setSignInStack() {
        signUpLabel.textColor = .white
        signUpLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        signUpButton.tintColor = ColorConstans.logInColor
        signUpButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        signUpButton.titleLabel?.font = UIFont(name: FontsConstants.openSansSemiBold, size: 20)
        
        signUpStack = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        signUpStack.axis = .horizontal
        signUpStack.spacing = 15
        signUpStack.translatesAutoresizingMaskIntoConstraints = false
        signUpStack.alignment = .center
        view.addSubview(signUpStack)
    }
}

extension LoginViewController {
    enum Event {
        case logIn(String, String)
        case signUp(String, String)
        case remindLater
    }
}

