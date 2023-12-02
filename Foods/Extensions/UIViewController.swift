//
//  UIViewController.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import UIKit

extension UIViewController {

    //MARK: - Keyboard hiding Methods

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Alert Methods

    func showToast(controller:UIViewController,message:String,seconds:Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
    }
    
    func showAlertWithAction(title: String?,titleAction: String?,titleNoAction: String?, message: String?, viewController: UIViewController, compilitionHandler: @escaping () -> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: titleAction, style: .destructive) {_ in
            compilitionHandler()
        }
        let noAction = UIAlertAction(title: titleNoAction, style: .default ,handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(noAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
