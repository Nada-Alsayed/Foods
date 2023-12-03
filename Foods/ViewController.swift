//
//  ViewController.swift
//  Foods
//
//  Created by MAC on 26/11/2023.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {
    
    //MARK: - Variables

    var keychain = KeychainSwift()
 
    //MARK: - ViewController lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(navigate), userInfo: nil, repeats: false)
        
    }
    
    //MARK: - Methods

    @objc func navigate() {
        if !isLoggedIn().isEmpty {
            navigateToHome()
        } else {
            navigateToLogin()
        }
     }
     
     func isLoggedIn() -> String {
         guard let storedEmail = keychain.get(ConstantsStrings.EMAIL) else {return ""}
         return storedEmail
     }
     
     func navigateToHome() {
         let vc = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.TABBAR_VC) as! CustomTabBar
         vc.modalPresentationStyle = .fullScreen
         present(vc, animated: true, completion: nil)
     }
     
     func navigateToLogin(){
         let loginVC = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.LOGIN_VC) as! LoginVC
         loginVC.modalPresentationStyle = .fullScreen
         present(loginVC, animated: true, completion: nil)
     }

}

