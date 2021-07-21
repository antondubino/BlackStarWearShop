import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var infoLoginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UIView!
    @IBOutlet weak var forgetPassword: UIView!
    @IBOutlet weak var loginButton: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.layer.cornerRadius = 10
    }
}
