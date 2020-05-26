//
//  Pool.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/8/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import Foundation

enum PoolType: Int {
  case goal, perPerson
}

enum PaymentState: Int {
  case notPaid, paid, funded
}

class Pool {
  var name: String = ""
  var dueDate: Date!
  var eventDate: Date!
  var numPeople: Int = 0
  var maxPeople: Int = 0
  var cost: Int = 0
  var type: PoolType = PoolType.goal
  var paymentState: PaymentState!
}
