//
//  InvitesViewController.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/8/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class InvitesViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: - viewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
}


// MARK: - TableView DataSource and Delegate

extension InvitesViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
