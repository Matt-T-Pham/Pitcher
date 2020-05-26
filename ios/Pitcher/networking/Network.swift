//
//  Network.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import Foundation
import Alamofire

struct Network : Networking {
  
  let url = "http://206.189.167.176:8080/"
  
  func request(to route: String, _ networkResponse: @escaping (Data?) -> ()) {
    Alamofire.request(url+route)
      .validate()
      .responseData { response in
        switch response.result {
        case .success:
          networkResponse(response.data)
        case .failure(let error):
          print(error)
          networkResponse(nil)
        }
    }
  }
  
  func post(to route: String, with parameters: Parameters, _ networkResponse: @escaping (Data?) -> ()) {
    Alamofire.request(url+route, method: .post, parameters: parameters)
      .validate()
      .responseData { response in
        switch response.result {
        case .success:
          networkResponse(response.data)
        case .failure(let error):
          print(error)
          networkResponse(nil)
        }
    }
  }
}
