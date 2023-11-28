//
//  URLCreator.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation

class URLCreator {
    
    //MARK: - properties
    private var endPoint = ""
    private let base_url = "https://api.npoint.io"
    
    //MARK: - Methods
    func getFoods() -> URL{
        endPoint = "/43427003d33f1f6b51cc"
        return URL(string: base_url + endPoint)!
    }
    
}
