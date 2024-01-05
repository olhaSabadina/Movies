//
//  ViewController.swift
//  Movies
//
//  Created by Olga Sabadina on 04.01.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    var didSendEventClosure: (() -> Void)?
        
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
//        guard let email = emailNumberTextField.text, !email.isEmpty,
//              let password = passwordTextField.text, !password.isEmpty else { return }
//        authorisedCoordinator?.authManager.logIn(email: email, pasword: password, errorHandler: { [weak self] error in
//            self?.presentAlert(with: "Error", message: error.localizedDescription, buttonTitles: "Ok", styleActionArray: [.cancel], alertStyle: .alert, completion: nil)
//        })
    }
    
    @objc func signUpUser() {
//        guard let email = emailNumberTextField.text, !email.isEmpty,
//              let password = passwordTextField.text, !password.isEmpty else { return }
//        let user = UserProfile(login: email)
//        authorisedCoordinator?.authManager.signUp(email, password, profile: user, errorHandler: { [weak self] error in
//            self?.presentAlert(with: "Error", message: error?.localizedDescription, buttonTitles: "OK", styleActionArray: [.default], alertStyle: .alert, completion: nil)
//        })
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
            
            titlesStack.topAnchor.constraint(equalTo: navigationItem.titleView?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titlesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titlesStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titlesStack.heightAnchor.constraint(equalToConstant: 150),
            
            authorizedStack.topAnchor.constraint(equalTo: titlesStack.bottomAnchor, constant: 40),
            authorizedStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            authorizedStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorizedStack.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: authorizedStack.bottomAnchor, constant: 30),
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
        view.backgroundColor = .systemCyan
    }
    
    private func setTitlesLabel() {
        let labels = [titleLabel, descriptionLabel]
        labels.forEach { label in
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .label
        }
        titleLabel.text = TitleConstants.eventApp
        titleLabel.font = .boldSystemFont(ofSize: 24)// UIFont(name: FontConstants.semiBold, size: 24)
        descriptionLabel.text = TitleConstants.eventDescriptionApp
        descriptionLabel.font = .systemFont(ofSize: 20)// UIFont(name: FontConstants.semiBold, size: 20)
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
        authorizedStack.spacing = 10
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
        logInButton.backgroundColor = .link
        logInButton.tintColor = .systemBackground
        logInButton.layer.cornerRadius = 10
        logInButton.layer.borderColor = UIColor.gray.cgColor
        logInButton.layer.borderWidth = 1
        logInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(logInButton)
    }
    
    private func setSignInStack() {
        signUpLabel.textColor = .white
        signUpLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        signUpButton.tintColor = .link
        signUpButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        signUpStack = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        signUpStack.axis = .horizontal
        signUpStack.spacing = 15
        signUpStack.translatesAutoresizingMaskIntoConstraints = false
        signUpStack.alignment = .center
        view.addSubview(signUpStack)
    }
}


