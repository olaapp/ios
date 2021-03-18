
//  Collections.swift
//  AESApp
//
//  Created by Alex on 7/16/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation


extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
