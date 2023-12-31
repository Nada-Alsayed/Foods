//
//  HomeVC.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import UIKit
import KeychainSwift
import Reachability
import RealmSwift

class HomeVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOut: UIImageView!
    
    //MARK: - Variables
    
    var recipes:[Reciepe] = []
    var viewModel = HomeViewModel()
    var keychain = KeychainSwift()
    
    //MARK: - View Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try? Realm()
        
        //MARK: - to get the realm file path

        let realmURL = realm?.configuration.fileURL
      //  print(realmURL)
        
        indicatorView.layer.cornerRadius =
        indicatorView.layer.bounds.size.height / 2
        indicatorView.layer.masksToBounds = true
        setTableViewConfiguration()
        fetchData()
        addTap()
    }
    
    //MARK: - Methods
    
    func fetchData(){
        indicator.startAnimating()
        viewModel.bindResultToView = { [weak self]  in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.recipes = self.viewModel.result
                self.indicator.stopAnimating()
                self.indicatorView.isHidden = true
                self.tableView.reloadData()
            }
        }
        viewModel.getData(vc: self)
    }
    
    func setTableViewConfiguration(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: foodCell.id, bundle: nil), forCellReuseIdentifier: foodCell.id)
    }
    
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(logout))
        signOut.isUserInteractionEnabled = true
        signOut.addGestureRecognizer(tap)
    }
    
    func checkNetwork(){
        do {
            let reachability = try Reachability()
            if reachability.connection != .unavailable {
             //   print("Reachable via WiFi")
                self.fetchData()
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    @objc func logout(){
        showAlertWithAction(title: ConstantsStrings.ALERT, titleAction: ConstantsStrings.LOGOUT, titleNoAction: ConstantsStrings.NO_ACTION_BTN, message: ConstantsStrings.CONFIRM_LOGOUT_MESSEGE, viewController: self) {
            self.keychain.clear()
            self.navigateToLogin()
        }
    }
    
    func navigateToLogin(){
        dismiss(animated: true)

    }
}

//MARK: - Extensions

extension HomeVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(136)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodCell.id, for: indexPath) as!foodCell
        
        cell.configureCell(recipe: recipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.DETAILS_VC) as! DetailsVC
        details.modalPresentationStyle = .fullScreen
        details.recipe = recipes[indexPath.row]
        present(details,animated: true)
    }
}
