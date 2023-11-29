//
//  ViewController.swift
//  Foods
//
//  Created by MAC on 26/11/2023.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {
    
    var keychain = KeychainSwift()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(navigate), userInfo: nil, repeats: false)
        
    }
    
    
    @objc func navigate() {
        // Check if the user is logged in
        if !isLoggedIn().isEmpty {
            navigateToHome() // User is logged in, show the main content
        } else {
            navigateToLogin() // User is not logged in, show the login screen
        }
     }
     
     func isLoggedIn() -> String {
         if let storedEmail = keychain.get(ConstantsStrings.EMAIL)
         {
             return storedEmail
             
         }else{
             return ""
         }
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

