//
//  LoginVC.swift
//  Foods
//
//  Created by MAC on 26/11/2023.
//

import UIKit
import KeychainSwift

class LoginVC: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var passwordTFView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTFView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var showPasswordImg: UIImageView!
        
    //MARK: - Variables

    let keychain = KeychainSwift()
    var isPasswordHidden = true
    let color: UIColor = UIColor(red: 240.0/255.0, green: 141.0/255.0, blue: 2.0/255.0, alpha: 1.0)

    //MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        SetUI()
        addEyeTapRecogniser()
    }
    
    //MARK: - IBActions

    @IBAction func loginBtn(_ sender: Any) {
        let password = passwordTF.text
        let email = emailTF.text
        
        if !(password?.isEmpty ?? true) &&
        !(email?.isEmpty ?? true) {
            guard let password = password else {return}
            guard let email = email else {return}
            if isValidEmail(email)
                && isValidPassword(password)
            {
                keychain.set(password, forKey: ConstantsStrings.PASSWORD)
                keychain.set(email, forKey: ConstantsStrings.EMAIL)
                navigateToHome()
            } else {
                showToast(controller: self, message:"Data not valid", seconds: 2)
            }
        }else{
           showToast(controller: self, message:"Please enter all fields", seconds: 2)
        }
    }
    
    
    //MARK: - Methods

    func SetUI(){
        containerView.layer.cornerRadius = 30
        viewTFDesign()
        viewBtnDesign()
    }
    func viewTFDesign(){
        emailTFView.layer.cornerRadius = 30
        emailTFView.layer.borderWidth = 2.0
        emailTFView.layer.borderColor = color.cgColor
        passwordTFView.layer.cornerRadius = 30
        passwordTFView.layer.borderWidth = 2.0
        passwordTFView.layer.borderColor = color.cgColor
    }
    
    func viewBtnDesign(){
        loginBtn.layer.cornerRadius = 30
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.borderColor = UIColor.darkGray.cgColor
    }
    func navigateToHome(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBar")as! CustomTabBar
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func addEyeTapRecogniser(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPassword))
        showPasswordImg.isUserInteractionEnabled = true
        showPasswordImg.addGestureRecognizer(tap)
    }
    
    @objc func showPassword(){
        if isPasswordHidden {
            passwordTF.isSecureTextEntry = false
            isPasswordHidden = false
        } else {
            isPasswordHidden = true
            passwordTF.isSecureTextEntry = true
        }
    }
}
