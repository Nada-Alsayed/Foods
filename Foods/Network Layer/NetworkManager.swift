//
//  NetworkManager.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import Alamofire

class NetworkManager {
    
    //MARK: - Methods

    func fetchData<T:Codable>(url:URL,complition : @escaping (T?,Error?) -> () ){
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let data):
             complition(data,nil)
           case .failure(let error):
             print(error.localizedDescription)
              complition(nil,error)
            }
        }
    }
}
