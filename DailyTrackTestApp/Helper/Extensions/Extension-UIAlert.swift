
import UIKit

extension UIViewController {
    func hiddenBack() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension UIViewController {
    func showAlert(title: String, mess: String) {
        let alert = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}


    
