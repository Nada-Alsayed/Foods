//
//  HomeVC.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var recipes:[Reciepe] = []
    var viewModel = HomeViewModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfiguration()
        
        fetchData()
    }

    func fetchData(){
        viewModel.bindResultToView = { [weak self]  in
           // print("222")
            DispatchQueue.main.async {
                self?.recipes = self?.viewModel.result ?? []
               // print("5555\(self?.recipes.count)")

                self?.tableView.reloadData()
            }
        }
        viewModel.getData()
    }
    
    func setTableViewConfiguration(){
       // print("9999")

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
