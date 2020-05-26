//
//  PoolCellViewModel.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/8/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class PoolCellViewModel {
  
  let pool: Pool
  
  init(with pool: Pool) {
    self.pool = pool
  }
  
  var dueDateString: String {
    get {
      return getDateString(for: pool.dueDate)
    }
  }
  var eventDateString: String {
    get {
      return getDateString(for: pool.eventDate)
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
      return #imageLiteral(resourceName: "funded_24pt").tintable()
    }
  }
  var paidImage: UIImage {
    get {
      return #imageLiteral(resourceName: "paid_24pt").tintable()
    }
  }
  var notPaidImage: UIImage {
    get {
      return #imageLiteral(resourceName: "not_paid_24pt").tintable()
    }
  }
  
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.medium
    formatter.timeStyle = DateFormatter.Style.short
    return formatter
  }()
  
  let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter
  }()
  
  
  private func getDateString(for date: Date) -> String {
    return dateFormatter.string(from: date)
  }
  
}
