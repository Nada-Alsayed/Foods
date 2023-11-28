//
//  HomeVC.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
      
    //MARK: - Variables

    var recipes:[Reciepe] = []
    var viewModel = HomeViewModel()
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfiguration()
        fetchData()
    }
    
    //MARK: - Methods

    func fetchData(){
        viewModel.bindResultToView = { [weak self]  in
            DispatchQueue.main.async {
                self?.recipes = self?.viewModel.result ?? []
                self?.tableView.reloadData()
            }
        }
        viewModel.getData()
    }
    
    func setTableViewConfiguration(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: foodCell.id, bundle: nil), forCellReuseIdentifier: foodCell.id)
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let details = self.storyboard?.instantiateViewController(withIdentifier: "details2") as! DetailsVTwoVC
//        details.modalPresentationStyle = .fullScreen
//        details.receipe = arrayOfReciebes[indexPath.row]
//        present(details,animated: true)
//    }
}
