//
//  ScrollViewExtension.swift
//  AESApp
//
//  Created by Alex on 5/30/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}
