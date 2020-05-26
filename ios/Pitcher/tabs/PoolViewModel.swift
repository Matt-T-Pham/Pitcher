//
//  PoolViewModel.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class PoolViewModel {
  
  let pool: Pool
  
  init(with pool: Pool) {
    self.pool = pool
  }
  
  var paymentStateText: String {
    get {
      switch pool.paymentState {
      case .notPaid:
        return "Not Paid"
      case .paid:
        return "Paid"
      case .funded:
        return "Funded"
      default:
        return "oops"
      }
    }
  }
  
  var dueDateString: String {
    get {
      return dateFormatter.string(from: pool.dueDate)
    }
  }
  var eventDateString: String {
    get {
      return dateFormatter.string(from: pool.eventDate)
    }
  }
  var costString: String {
    get {
      let actualCost: Double = Double(pool.cost)/100
      return currencyFormatter.string(from: NSNumber(floatLiteral: actualCost)) ?? "$0.00"
    }
  }
  
  
  var fundedImage: UIImage {
    get {
      return #imageLiteral(resourceName: "funded_36pt").tintable()
    }
  }
  var paidImage: UIImage {
    get {
      return #imageLiteral(resourceName: "paid_36pt").tintable()
    }
  }
  var notPaidImage: UIImage {
    get {
      return #imageLiteral(resourceName: "not_paid_36pt").tintable()
    }
  }
  
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.medium
    formatter.timeStyle = DateFormatter.Style.short
    return formatter
  }()
  
  private let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter
  }()
  
}
