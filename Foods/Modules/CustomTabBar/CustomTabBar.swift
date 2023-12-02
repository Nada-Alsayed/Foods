//
//  CustomTabBar.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import UIKit

class CustomTabBar: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var homeStack: UIStackView!
    @IBOutlet weak var favoriteStack: UIStackView!
    @IBOutlet weak var collapsedHomeView: UIView!
    @IBOutlet weak var expandedHomeView: UIView!
    @IBOutlet weak var collapsedFavView: UIView!
    @IBOutlet weak var expandedFavView: UIView!
   
    //MARK: - Variables

//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    var isHomeSelected = true
    var isFavoriteSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarDesign()
        showHomeVC()
        addTapRecogniser()
    }
    
    //MARK: - Methods
    
    func showHomeVC(){
        guard let home = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.HOME_VC) as? HomeVC else {return}
        self.addChild(home)
        home.view.frame = containerView.bounds
        containerView.addSubview(home.view)
        home.didMove(toParent: self)
    }
    
    func showFavoriteVC(){
        guard let favorite = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.FAVORITE_VC) as? FavoriteVC else {return}
        self.addChild(favorite)
        favorite.view.frame = containerView.bounds
        containerView.addSubview(favorite.view)
        favorite.didMove(toParent: self)
    }
    
    func tabBarDesign(){
        expandedFavView.isHidden = true
        collapsedHomeView.isHidden = true
        tabBarView.layer.cornerRadius = tabBarView.layer.frame.size.height / 2
        tabBarView.layer.shadowColor = UIColor.black.cgColor
        tabBarView.layer.shadowOffset = CGSize(width: 0, height: 4)
        tabBarView.layer.shadowOpacity = 0.8
        tabBarView.layer.shadowRadius = 5.0
    }
    
    
    func addTapRecogniser(){
        let homeTap = UITapGestureRecognizer(target: self, action: #selector(homeStackOnClick))
        homeStack.isUserInteractionEnabled = true
        homeStack.addGestureRecognizer(homeTap)
        
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(favoriteStackOnClick))
        favoriteStack.isUserInteractionEnabled = true
        favoriteStack.addGestureRecognizer(favoriteTap)
    }
    
    @objc func homeStackOnClick(){
        if isHomeSelected == false {
            showHomeVC()
            expandedHomeView.isHidden = false
            collapsedHomeView.isHidden = true
            expandedFavView.isHidden = true
            collapsedFavView.isHidden = false
            isFavoriteSelected = false
            isHomeSelected = true
        }
    }
    
    @objc func favoriteStackOnClick(){
        if isFavoriteSelected == false {
            showFavoriteVC()
            expandedHomeView.isHidden = true
            collapsedHomeView.isHidden = false
            expandedFavView.isHidden = false
            collapsedFavView.isHidden = true
            isFavoriteSelected = true
            isHomeSelected = false
        }
    }
    
}
