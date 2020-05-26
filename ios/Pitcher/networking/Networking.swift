//
//  Networking.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import Foundation

protocol Networking {
  func request(to route: String, _ networkResponse: @escaping (Data?) -> ())
  func post(to route: String, with parameters: [String: Any], _ networkResponse: @escaping (Data?) -> ())
}
