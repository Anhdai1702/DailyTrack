//
//  SignUpViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 6/11/24.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    // Constraints
    @IBOutlet private weak var textEmail: CustomTextField!
    @IBOutlet private weak var textPassword: CustomTextField!
    @IBOutlet private weak var textPasswordAgain: CustomTextField!
    @IBOutlet private weak var offEyesPasswordImage: UIImageView!
    @IBOutlet private weak var offEyesPasswordAgainImage: UIImageView!
    @IBOutlet private weak var lockPasswordImage: UIImageView!
    @IBOutlet private weak var lockPasswordAgainImage: UIImageView!
    @IBOutlet private weak var haveAccountSignInTextView: UITextView!
    
    // Variable
    private var showPass = false
    private var showPassAgain = false
    private let textEmailPlaceholder = "Your E-mail"
    private let textPasswordPlaceholder = "Your password"
    private let textPasswordAgainPlaceholder = "Confirm password"
    private let haveAccountSignInTextViewTitle = "Already have an account?"
    private let loginSignupTitle = "Log in"
    private let noInformationEnteredLabelTitle = "No information entered"
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Actions
extension SignUpViewController {
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapShowPassword(_ sender: Any) {
        togglePasswordVisibility(textPassword, showPass, offEyesPasswordImage, lockPasswordImage)
    }
    
    @IBAction func didTapShowAgainPassword(_ sender: Any) {
        togglePasswordVisibility(textPasswordAgain, showPass, offEyesPasswordAgainImage, lockPasswordAgainImage)
    }
    
    private func togglePasswordVisibility(_ textField: UITextField, _ showPass: Bool, _ eyeImageView: UIImageView, _ lockImageView: UIImageView) {
        self.showPass.toggle()
        textField.isSecureTextEntry = !showPass
        eyeImageView.image = showPass ? UIImage(resource: .eyeShow) : UIImage(resource: .eyeHide)
        lockImageView.image = showPass ? UIImage(resource: .lock1) : UIImage(resource: .lock)
    }
    
    @IBAction func didTapSignUp(_ sender: Any) {
        guard let email = textEmail.text, !email.isEmpty,
              let password = textPassword.text, password.count >= 6,
              let confirmPassword = textPasswordAgain.text, password == confirmPassword else {
            self.showAlert(title: "Notification", mess: "Invalid input.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                self.showAlert(title: "Notification", mess: "Error: \(error.localizedDescription)")
            } else {
                self.showAlert(title: "Notification", mess: "Registration successful.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func didTapsignUpFaceBook(_ sender: Any) {
    }
    
    @IBAction func didTapSignUpApple(_ sender: Any) {
    }
    
    @IBAction func didTapSignUpGoogle(_ sender: Any) {
    }
    
    private func didTapLogin() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Custom methods
extension SignUpViewController {
    
    private func setupUI(){
        setupDismissKeyboard()
        setupText()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupText() {
        textEmail.leftPadding = 50
        textPassword.leftPadding = 50
        textPasswordAgain.leftPadding = 50
        textEmail.placeholder = textEmailPlaceholder
        textPassword.placeholder = textPasswordPlaceholder
        textPasswordAgain.placeholder = textPasswordAgainPlaceholder
        setupColorText()
        setupHaveAccountSignInTextView()
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
        
        textPasswordAgain.attributedPlaceholder = NSAttributedString(
            string: textPasswordAgainPlaceholder,
            attributes: [
                .foregroundColor: Constants.color8A8E9E,
                .font: UIFont.systemFont(ofSize: 14)
            ]
        )

    }
    
    private func setupHaveAccountSignInTextView() {
        let fullText = "\(haveAccountSignInTextViewTitle) \(loginSignupTitle)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Define the range for the first attribute
        let normalRedRange = (fullText as NSString).range(of: haveAccountSignInTextViewTitle)
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
        
        haveAccountSignInTextView.attributedText = attributedString
        haveAccountSignInTextView.textAlignment = .center
        haveAccountSignInTextView.delegate = self
        
        haveAccountSignInTextView.textContainerInset = .zero
        haveAccountSignInTextView.textContainer.lineFragmentPadding = 0
        haveAccountSignInTextView.dataDetectorTypes = [.link]
    }
}

//MARK: - UITextViewDelegate
extension SignUpViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "tapHere" {
            // Handle the tap action
            didTapLogin()
            return false
        }
        return true
    }
}
