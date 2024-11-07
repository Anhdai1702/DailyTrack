//
//  ForgotPasswordViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 7/11/24.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    // Constraints
    @IBOutlet private weak var textEmail: CustomTextField!
    
    // Variable
    private let textEmailPlaceholder = "Your E-mail"
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Actions
extension ForgotPasswordViewController {
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSendCode(_ sender: Any) {
        guard let checkEmail = textEmail.text, !checkEmail.isEmpty else {
            self.showAlert(title: "Notification", mess: "Invalid input.")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: checkEmail) { (error) in
            if error != nil {
                self.showAlertWithCancel(title: "Notification", mess: "Email sent, check email again") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

//MARK: - Custom methods
extension ForgotPasswordViewController {
    
    private func setupUI() {
        setupText()
    }
    
    private func setupText() {
        textEmail.leftPadding = 50
        textEmail.placeholder = textEmailPlaceholder
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
    }
}
