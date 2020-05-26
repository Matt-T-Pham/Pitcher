//
//  PoolViewController.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class PoolViewController: UIViewController {
  
  @IBOutlet weak var paymentStateLabel: UILabel!
  @IBOutlet weak var backgroundPaymentStateImageView: UIImageView!
  @IBOutlet weak var paymentStateImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var dueDateLabel: UILabel!
  @IBOutlet weak var eventDateLabel: UILabel!
  @IBOutlet weak var costLabel: UILabel!
  
  var viewModel: PoolViewModel!
  
  // MARK: - viewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameLabel.text = viewModel.pool.name
    switch viewModel.pool.type {
    case .goal:
      typeLabel.text = "Goal"
    case .perPerson:
      typeLabel.text = "Per-Person"
    }
    dueDateLabel.text = viewModel.dueDateString
    eventDateLabel.text = viewModel.eventDateString
    costLabel.text = viewModel.costString
    
    setPaymentState()
  }
  
  func setPaymentState() {
    paymentStateLabel.text = viewModel.paymentStateText
    
    switch viewModel.pool.paymentState {
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
  
  
  // MARK: - Button Actions
  
  @IBAction func didTapBack(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
