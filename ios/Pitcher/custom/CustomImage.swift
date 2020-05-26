//
//  CustomImage.swift
//  Pitcher
//
//  Created by Greg Rosich on 9/9/18.
//  Copyright © 2018 Free Food?. All rights reserved.
//

import UIKit

extension UIImage {
  
  func tintable() -> UIImage {
    return self.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
  }
  
}
