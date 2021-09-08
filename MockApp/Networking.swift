//
//  Networking.swift
//  MockApp
//
//  Created by Egor Gorskikh on 07.09.2021.
//

import Foundation
import Alamofire

protocol Networkable {
    func getMethod(completionHandler: @escaping (BitcoinResponse?) -> () )
}

class Networking: Networkable {
    
    func getMethod(completionHandler: @escaping (BitcoinResponse?) -> () ) {
                let request = Session.default.request("https://blockchain.info/ticker")
                request.responseDecodable(of: BitcoinResponse.self) { (response) in
                    switch response.result {

                    case .success(let tasks):
                        print("SUCCESS to FETCH JSON")
                        completionHandler(tasks)

                    case .failure(let error):
                        print("FAILED to FETCH JSON: \(error.localizedDescription)")
                    }
                }
    }
    
}


