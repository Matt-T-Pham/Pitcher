//
//  CreatePoolViewController.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class CreatePoolViewController: UIViewController {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var dueDateField: UITextField!
  @IBOutlet weak var eventDateField: UITextField!
  @IBOutlet weak var poolTypeSelector: UISegmentedControl!
  @IBOutlet weak var maxPeopleField: UITextField!
  @IBOutlet weak var moneyAmountLabel: UILabel!
  @IBOutlet weak var moneyAmountField: UITextField!
  
  var selectedDateField: UITextField!
  
  var viewModel: CreatePoolViewModel = CreatePoolViewModel()
  
  let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter
  }()
  
  
  // MARK: - viewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: - Button Actions
  
  @IBAction func didTapNext(_ sender: UIBarButtonItem) {
    PoolCreater(networking: Network()).create(with: viewModel.pool) { id in
      guard let id = id else {
        return
      }
      print("ID: \(id)")
      self.performSegue(withIdentifier: "next", sender: nil)
    }
  }
  
  @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
  // MARK: - SegmentedControl Actions
  
  @IBAction func indexChanged(_ sender: UISegmentedControl) {
    viewModel.pool.type = PoolType(rawValue: sender.selectedSegmentIndex)!
    switch viewModel.pool.type {
    case .goal:
      moneyAmountLabel.text = "Total pool cost:"
    case .perPerson:
      moneyAmountLabel.text = "Min contribution:"
    }
  }
  
  
  
  // MARK: - Textfield Actions
  
  @IBAction func textFieldChanged(_ sender: UITextField) {
    if sender == nameField {
      viewModel.pool.name = sender.text ?? ""
    }
    if sender == maxPeopleField {
      viewModel.pool.maxPeople = Int(sender.text ?? "") ?? 0
    }
    if sender == moneyAmountField {
      if let amountString = sender.text?.currencyInputFormatting() {
        sender.text = amountString
        let amount = currencyFormatter.number(from: amountString) ?? 0
        viewModel.pool.cost = Int(amount.doubleValue*100)
      }
      
    }
  }
  
  @IBAction func textFieldBeginEditing(_ sender: UITextField) {
    selectedDateField = sender
    
    let datePickerView: UIDatePicker = UIDatePicker()
    datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
    sender.inputView = datePickerView
    
    datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
    
  }
  
  @objc func datePickerValueChanged(sender: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = DateFormatter.Style.medium
    dateFormatter.timeStyle = DateFormatter.Style.short
    
    selectedDateField.text = dateFormatter.string(from: sender.date)
    
    if selectedDateField == dueDateField {
      viewModel.pool.dueDate = sender.date
    }
    if selectedDateField == eventDateField {
      viewModel.pool.eventDate = sender.date
    }
  }
}
