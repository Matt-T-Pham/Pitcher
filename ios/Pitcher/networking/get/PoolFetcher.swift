//
//  PoolFetcher.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct PoolFetcher {
  let networking: Networking
  
  func fetch(_ response: @escaping ([Pool]?) -> ()) {
    networking.request(to: "pools") { data in
      let pools = data.map { self.decode($0 as Data) }
      response(pools)
    }
  }
  
  fileprivate func decode(_ data: Data) -> [Pool] {
    var json: JSON!
    do {
      json = try JSON(data: data)
    } catch {
      return []
    }
    var pools: [Pool] = []
    print(json)
//    for (_, j) in json["list"] {
//      if let id = j["id"].int {
//        cities.append(City(id: id, name: j["name"].string ?? "", weather: j["weather"][0]["main"].string ?? ""))
//      }
//    }
    return pools
  }
}
