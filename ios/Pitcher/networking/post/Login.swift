//
//  Login.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Login {
  let networking: Networking
  
  func authenticate(with username: String, password: String, _ response: @escaping (String?) -> ()) {
    let parameters: [String: Any] = ["USERNAME": username, "PASSWORD": password]
    networking.post(to: "login", with: parameters) { data in
      guard let data = data else {
        response(nil)
        return
      }
      do {
        let json = try JSON(data: data)
        print(json)
        response(json["ID"].stringValue)
      } catch {
        response(nil)
      }
    }
  }
}
