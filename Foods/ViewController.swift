//
//  ViewController.swift
//  Foods
//
//  Created by MAC on 26/11/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(navigate), userInfo: nil, repeats: false)
        
    }
    
    @objc func navigate() {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.TABBAR_VC) as! CustomTabBar
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }

}

