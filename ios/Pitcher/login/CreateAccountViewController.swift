//
//  CreateAccountViewController.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
  
  @IBOutlet weak var firstField: UITextField!
  @IBOutlet weak var lastField: UITextField!
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var createAccountButton: UIButton!
  
  
  // MARK: - viewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createAccountButton.layer.borderWidth = 2
    createAccountButton.layer.borderColor = PitcherColor.globalTint.cgColor
    createAccountButton.layer.cornerRadius = createAccountButton.frame.height/2
  }
  
  
  // MARK: - Button Actions
  
  @IBAction func createAccountTapped(_ sender: UIButton) {
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
    UIApplication.shared.keyWindow?.rootViewController = viewController
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
