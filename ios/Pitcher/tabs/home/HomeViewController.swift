//
//  ViewController.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/8/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var viewModel: HomeViewModel = HomeViewModel()
  
  
  // MARK: - viewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    
    tableView.register(UINib(nibName: String(describing: PoolTableViewCell.self), bundle: nil), forCellReuseIdentifier: ReuseID.PoolTVC)
    
    demoPools()
  }


  func demoPools() {
    let pool1 = Pool()
    pool1.name = "A pool"
    pool1.dueDate = Date()
    pool1.eventDate = Date()
    pool1.cost = 5000
    pool1.paymentState = PaymentState.funded
    pool1.type = PoolType.perPerson
    viewModel.pools.append(pool1)
    
    
    let pool2 = Pool()
    pool2.name = "Another pool"
    pool2.dueDate = Date()
    pool2.eventDate = Date()
    pool2.cost = 2520
    pool2.paymentState = PaymentState.notPaid
    pool2.type = PoolType.perPerson
    viewModel.pools.append(pool2)
    
    let pool3 = Pool()
    pool3.name = "Wow a pool!"
    pool3.dueDate = Date()
    pool3.eventDate = Date()
    pool3.cost = 1234
    pool3.paymentState = PaymentState.paid
    pool3.type = PoolType.perPerson
    viewModel.pools.append(pool3)
  }
}


// MARK: - TableView DataSource and Delegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.pools.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.PoolTVC) as? PoolTableViewCell {
      cell.viewModel = PoolCellViewModel(with: viewModel.pools[indexPath.row])
      return cell
    }
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let pool = viewModel.pools[indexPath.row]
    let poolViewModel = PoolViewModel(with: pool)
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "poolViewController") as! PoolViewController
    viewController.viewModel = poolViewModel
    self.present(viewController, animated: true, completion: nil)
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

