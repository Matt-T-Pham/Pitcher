//
//  LoginViewController.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  // MARK: - viewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loginButton.layer.borderWidth = 2
    loginButton.layer.borderColor = PitcherColor.globalTint.cgColor
    loginButton.layer.cornerRadius = loginButton.frame.height/2
  }
  
  
  // MARK: - Button Actions
  
  @IBAction func loginTapped(_ sender: UIButton) {
    Login(networking: Network()).authenticate(with: usernameField.text ?? "", password: passwordField.text ?? "") { id in
      guard let id = id else {
        return
      }
      userID = id
      
      let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
      UIApplication.shared.keyWindow?.rootViewController = viewController
    }
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
