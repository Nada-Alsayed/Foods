//
//  HomeViewModel.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import Reachability

class  HomeViewModel{
    
    //MARK: - Variables

    var bindResultToView : (()->()) = {}
    private var apiFetchHandler : NetworkManager!
    var result : [Reciepe] = [] {
        didSet{
            bindResultToView()
        }
    }
    
    //MARK: - Init

    init(apiFetchHandler: NetworkManager = NetworkManager()) {
           self.apiFetchHandler = apiFetchHandler
    }
    
    //MARK: - Methods

    func getData(vc:UIViewController){
        let reachability = try? Reachability()
        if reachability?.connection != .unavailable {
            apiFetchHandler.fetchData(url: URLCreator().getFoods()) { [weak self] (root: [Reciepe]?, err) in
                guard let self = self else{return}
                guard let root = root else { return }
                self.result = root
            }
        }else{
            vc.showToast(controller: vc, message: "Check your network conniction", seconds: 1)
//            var x : [Reciepe] = [Reciepe]()
//            let storedArray = FavoriteViewModel().getSoredFavs()
//            for i in storedArray{
//                x.append(Reciepe().convertToRecipe(from: i))
//            }
//            result = x
        }
    }
}

