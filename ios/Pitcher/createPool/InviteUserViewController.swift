//
//  InviteUserViewController.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class InviteUserViewController: UIViewController {
  
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var inviteButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
    navigationItem.leftBarButtonItem = backButton
    
    inviteButton.layer.borderWidth = 2
    inviteButton.layer.borderColor = PitcherColor.globalTint.cgColor
    inviteButton.layer.cornerRadius = inviteButton.frame.height/2
  }
  
  
  // MARK: - Button Action
  
  @IBAction func doneTapped(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
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
