//
//  UIDatePickerExtension.swift
//  AESApp
//
//  Created by Alex on 7/14/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit

extension UIDatePicker {
func set18YearValidation() {
    let currentDate: Date = Date()
    var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
    var components: DateComponents = DateComponents()
    components.calendar = calendar
    components.year = -18
    let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
    components.year = -150
    let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
    self.minimumDate = minDate
    self.maximumDate = maxDate
} }
