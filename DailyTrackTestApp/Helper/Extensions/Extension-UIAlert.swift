
import UIKit

extension UIViewController {
    func hiddenBack() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
extension UIViewController {
    
    func alert(mess: String, onDelete: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let titleFont = UIFont(name: "Livvic-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        let messageFont = UIFont(name: "Livvic-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
        
        let titleString = NSAttributedString(string: "Thông báo", attributes: [.font: titleFont, .foregroundColor: UIColor.black])
        let messageString = NSAttributedString(string: mess, attributes: [.font: messageFont, .foregroundColor: UIColor.black])
        
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        
        // OK button triggers the onDelete closure to perform the delete action
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            onDelete()  // Call delete function after user presses OK
        }
        alert.addAction(okAction)
        
        // Cancel button to dismiss the action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

    
