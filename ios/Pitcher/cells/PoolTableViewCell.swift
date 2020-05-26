//
//  PoolTableViewCell.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/8/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class PoolTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var paymentStateImageView: UIImageView!
  @IBOutlet weak var backgroundPaymentStateImageView: UIImageView!
  @IBOutlet weak var costAmountLabel: UILabel!
  @IBOutlet weak var dueDateLabel: UILabel!
  
  var viewModel: PoolCellViewModel! {
    didSet {
      nameLabel.text = viewModel.pool.name
      costAmountLabel.text = viewModel.costString
      dueDateLabel.text = viewModel.dueDateString
      paymentState = viewModel.pool.paymentState
    }
  }
  
  var paymentState: PaymentState! {
    didSet {
      switch paymentState {
      case .notPaid:
        paymentStateImageView.image = viewModel.notPaidImage
        paymentStateImageView.tintColor = .red
        paymentStateImageView.backgroundColor = .black
        paymentStateImageView.layer.cornerRadius = paymentStateImageView.frame.height/2
        backgroundPaymentStateImageView.isHidden = true
      case .paid:
        paymentStateImageView.image = viewModel.paidImage
        paymentStateImageView.tintColor = .green
        paymentStateImageView.backgroundColor = .black
        paymentStateImageView.layer.cornerRadius = paymentStateImageView.frame.height/2
        backgroundPaymentStateImageView.isHidden = true
      case .funded:
        paymentStateImageView.image = viewModel.fundedImage
        paymentStateImageView.tintColor = .yellow
        paymentStateImageView.backgroundColor = .clear
        paymentStateImageView.layer.cornerRadius = 0
        backgroundPaymentStateImageView.isHidden = false
        backgroundPaymentStateImageView.image = viewModel.fundedImage
        backgroundPaymentStateImageView.tintColor = .black
      default:
        break
      }
    }
  }
    
}
