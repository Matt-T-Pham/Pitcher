//
//  PoolCreater.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let dateFormatter: DateFormatter = {
  let result = DateFormatter()
  result.dateFormat = "yyyy-MM-dd HH:mm:ss"
  return result
}()

struct PoolCreater {
  let networking: Networking
  
  func create(with pool: Pool, _ response: @escaping (String?) -> ()) {
    let parameters: [String: Any] = ["NAME": pool.name, "EVENTDATE": dateFormatter.string(from: (pool.eventDate ?? Date())), "PAYMENTDATE": dateFormatter.string(from: (pool.dueDate ?? Date())), "TYPE": pool.type.rawValue == 0 ? "GOAL" : "PERSON", "COMPLETE": 0, "COST": pool.cost]
    networking.post(to: "pools", with: parameters) { data in
      guard let data = data else {
        response(nil)
        return
      }
      do {
        let json = try JSON(data: data)
        print(json)
        response(json["ID"].string)
      } catch {
        response(nil)
      }
    }
  }
}
