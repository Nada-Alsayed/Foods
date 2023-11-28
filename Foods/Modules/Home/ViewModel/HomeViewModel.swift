//
//  HomeViewModel.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation

class  HomeViewModel{
    
    var bindResultToView : (()->()) = {}
    private var apiFetchHandler : NetworkManager!
    var result : [Reciepe] = [] {
        didSet{
          //  print("8888888")
            bindResultToView()
        }
    }
    
    init(apiFetchHandler: NetworkManager = NetworkManager()) {
           self.apiFetchHandler = apiFetchHandler
    }
    
    func getData(){
        apiFetchHandler.fetchData(url: URLCreator().getFoods()) { [weak self] (root: [Reciepe]?, err) in
            guard let root = root else { return }
            self?.result = root
         //   print("\(root)")
        }
    }
}

