//
//  LoginViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 6/11/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    // Constraints
    @IBOutlet private weak var textEmail: CustomTextField!
    @IBOutlet private weak var textPassword: CustomTextField!
    @IBOutlet private weak var unlock: UIImageView!
    @IBOutlet private weak var offEyes: UIImageView!
    @IBOutlet private weak var dontHaveAccountTextview: NoCopyPasteTextView!
    @IBOutlet private weak var loginErrorLabel: UILabel!
    
    // Variable
    private var isShowPassword = false
    private let textEmailPlaceholder = "Your E-mail"
    private let textPasswordPlaceholder = "Your password"
    private let dontHaveAccountTextviewTitle = "Don’t have an account?"
    private let loginSignupTitle = "Sign Up"
    private let noInformationEnteredLabelTitle = "No information entered"
    private let incorrectEmailOrPasswordTitle = "Incorrect email or password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Actions
extension LoginViewController {
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapShowPassword(_ sender: Any) {
        isShowPassword.toggle()
        textPassword.isSecureTextEntry = !isShowPassword
        offEyes.image = UIImage(resource: isShowPassword ? .eyeShow : .eyeHide)
        unlock.image = UIImage(resource: isShowPassword ? .lock1 : .lock)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        if textEmail.text == "" || textPassword.text == "" {
            highlightTextFieldError(textEmail)
            highlightTextFieldError(textPassword)
            loginErrorLabel.text = noInformationEnteredLabelTitle
            loginErrorLabel.isHidden = false
        }
        else {
            Auth.auth().signIn(withEmail: textEmail.text!, password: textPassword.text!) { authResult, error in
                if let error = error as NSError? {
                               let errorCode = AuthErrorCode(rawValue: error.code)
                               
                               switch errorCode {
                               case .invalidEmail:
                                   self.highlightTextFieldError(self.textEmail)
                                   self.highlightTextFieldError(self.textPassword)
                                   self.loginErrorLabel.text = self.incorrectEmailOrPasswordTitle
                                   self.loginErrorLabel.isHidden = false
                               default:
                                   break
                               }
                           }
                else{
                    let vc = SurveyViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBAction func didTapLoginFacebook(_ sender: Any) {
    }
    
    @IBAction func didTapLoginApple(_ sender: Any) {
    }
    
    @IBAction func didTapLoginGoogle(_ sender: Any) {
    }
    
    @IBAction func didTapForgotPassword(_ sender: Any) {
        let vc = ForgotPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSignup() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: - Custom methods
extension LoginViewController {
    
    private func setupUI() {
        setupDismissKeyboard()
        setupText()
        setupDontHaveAccountTextView()
        navigationController?.setNavigationBarHidden(true, animated: true)
        loginErrorLabel.isHidden = true
    }
    
    private func setupText() {
        textEmail.leftPadding = 50
        textPassword.leftPadding = 50
        textEmail.placeholder = textEmailPlaceholder
        textPassword.placeholder = textPasswordPlaceholder
        dontHaveAccountTextview.text = dontHaveAccountTextviewTitle
        setupColorText()
    }
    
    private func setupColorText() {
        textEmail.attributedPlaceholder = NSAttributedString(
            string: textEmailPlaceholder,
            attributes: [
                .foregroundColor: Constants.color8A8E9E,
                .font: UIFont.systemFont(ofSize: 14)
            ]
        )

        textPassword.attributedPlaceholder = NSAttributedString(
            string: textPasswordPlaceholder,
            attributes: [
                .foregroundColor: Constants.color8A8E9E,
                .font: UIFont.systemFont(ofSize: 14)
            ]
        )
    }
    
    func highlightTextFieldError(_ textField: UITextField) {
        textField.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    private func setupDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupDontHaveAccountTextView() {
        let fullText = "\(dontHaveAccountTextviewTitle) \(loginSignupTitle)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Define the range for the first attribute
        let normalRedRange = (fullText as NSString).range(of: dontHaveAccountTextviewTitle)
        attributedString.addAttribute(.font,
                                      value: UIFont.systemFont(ofSize: 14),
                                      range: normalRedRange)
        attributedString.addAttribute(.foregroundColor, value: Constants.color8A8E9E, range: normalRedRange)
        
        // Define the range for the second attribute
        let boldBlueRange = (fullText as NSString).range(of: loginSignupTitle)
        attributedString.addAttribute(.font,
                                      value: UIFont.systemFont(ofSize: 14),
                                      range: boldBlueRange)
        attributedString.addAttribute(.foregroundColor, value: Constants.color355BE1, range: boldBlueRange)
        attributedString.addAttribute(.link, value: "tapHere", range: boldBlueRange)
        
        dontHaveAccountTextview.attributedText = attributedString
        dontHaveAccountTextview.textAlignment = .center
        dontHaveAccountTextview.delegate = self
        
        dontHaveAccountTextview.textContainerInset = .zero
        dontHaveAccountTextview.textContainer.lineFragmentPadding = 0
        dontHaveAccountTextview.dataDetectorTypes = [.link]
    }
}

//MARK: - UITextViewDelegate
extension LoginViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "tapHere" {
            // Handle the tap action
            didTapSignup()
            return false
        }
        return true
    }
}
